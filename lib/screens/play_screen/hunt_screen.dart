import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_pixelmatching/flutter_pixelmatching.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/play_screen/answer_screen/answer_provider.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';


class HuntScreen extends StatefulWidget {
  const HuntScreen(int arguments, {
    super.key,
  });

  @override
  State<HuntScreen> createState() => HuntScreenState();
}

class HuntScreenState extends State<HuntScreen> {
  late final args = ModalRoute.of(context)!.settings.arguments as int;

  CameraController? controller;
  PixelMatching? matching;

  late Uint8List image;

  /// PixelMatching processing
  bool _processing = false;

  /// PixelMatching last processed timestamp
  int _processTimestamp = 0;

  double _similarity = 0;

  bool isDialogUp = false;

  @override
  void didChangeDependencies() {
    QuestionListProvider questionListProvider = context.watch<QuestionListProvider>();
    image = questionListProvider.questionList[args].imageByte!;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // resize target image
      // Larger sizes don't significantly impact recognition performance

      final imglib.Image? img = imglib.decodeImage(image);
      final imgBytes = imglib.encodeJpg(img!);

      // initialize PixelMatching and Camera
      image = imgBytes;
      initializePixelMatching();
      initializeCamera();
    });
    super.initState();
  }

  @override
  dispose() {
    matching?.dispose();
    matching = null;
    controller?.stopImageStream();
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuestionListProvider questionListProvider = context.watch<QuestionListProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hunt",
          style: TextStyleWidget.titleT1(
            color: ColorThemeStyle.white100,
            fontWeight: FontWeightStyle.medium
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: controller != null &&
              controller!.value.isInitialized &&
              matching != null &&
              matching!.isInitialized
          ? Center(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Text(
                    "Clue",
                    style: TextStyleWidget.bodyB1(
                      fontWeight: FontWeightStyle.bold
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    questionListProvider.questionList[args].imageClue,
                    style: TextStyleWidget.headlineH4(
                      fontWeight: FontWeightStyle.bold,
                      color: ColorThemeStyle.brown60
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.memory(
                            image,
                          ),
                        ),
                        Expanded(
                          child: CameraPreview(
                            controller!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top : 30),
                      child: Column(
                        children: [
                          Text(
                            "Image Similarity",
                            style: TextStyleWidget.headlineH4(
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.brown60
                            ),
                          ),
                          Text(
                            "${(_similarity * 100).toStringAsFixed(2)}%",
                            style: TextStyleWidget.bodyB1(
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.black100
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  /// Setup PixelMatching
  initializePixelMatching() async {
    matching = PixelMatching();
    await matching?.initialize(image: image);
    setState(() {});
  }

  /// Setup Camera
  ///
  initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras[0];
    controller =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await controller?.initialize();
    controller?.startImageStream(cameraStream);
    setState(() {});
  }

  /// PixelMatching similarity check
  ///
  /// 1. Check if PixelMatching is processing
  ///    - If processing, skip
  /// 2. Check if PixelMatching is delayed
  ///    - If not delayed, skip
  /// 3. Process PixelMatching
  cameraStream(CameraImage cameraImage) async {
    QuestionListProvider questionListProvider = context.read<QuestionListProvider>();
    AnswerProvider answerProvider = context.read<AnswerProvider>();

    final bool isProcessed = _processing;

    final bool isDelayed =
        DateTime.now().millisecondsSinceEpoch - _processTimestamp > 50;
    if (isProcessed || !isDelayed) return;
    _processing = true;
    _similarity = await matching?.similarity(cameraImage) ?? 0.0;
    if (mounted) {
      setState(() {});
    }
    if (kDebugMode) {
      print(_similarity);
    }
    _processing = false;
    _processTimestamp = DateTime.now().millisecondsSinceEpoch;

    if(_similarity >= 0.825 && isDialogUp == false){
      await questionListProvider.updatePhase(
        index: args,
      );
      await questionListProvider.getGameData(
        gameCode: questionListProvider.questionList[args].gameCode,
        username: questionListProvider.questionList[args].username
      );
      answerProvider.getCurrentHealth(
        health: questionListProvider.questionList[args].health
      );
      bool? navigate = await showDialog<bool>(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          isDialogUp = true;
          return PopScope(
            canPop: false,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: Center(
                child: Text(
                  "Wah kamu hebat!",
                  style: TextStyleWidget.headlineH4(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                )
              ),
              content: const Text(
                "Selamat, kamu berhasil menemukan tanda jejak! Tekan tombol di bawah untuk membuka soal",
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: ButtonWidget.defaultContainer(
                    height: 50,
                    onPressed: () => Navigator.pop(context, true),
                    text: "Jawab Soal"
                  ),
                )
              ],
            ),
          );
        }
      );
      if(mounted){
        if(navigate == true){
          Navigator.pushReplacementNamed(
            context,
            Routes.siswaAnswerScreen,
            arguments: args
          );
        } else {
          Navigator.pop(context);
        }
      }
    }
  }

  /// image rotation
  imageRotation(int angle) async {
    final imglib.Image? img = imglib.decodeImage(image);
    final imglib.Image rotatedImg = imglib.copyRotate(img!, angle: angle);
    final imgBytes = imglib.encodeJpg(rotatedImg);
    image = imgBytes;
    initializePixelMatching();
  }
}