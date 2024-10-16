import 'dart:convert';

class ProgressModels {
  Map<int,bool> skuProgress;
  List<String> gameProgress;
  int points;
  int questionAnswered;

  ProgressModels({
    required this.skuProgress,
    required this.gameProgress,
    required this.points,
    required this.questionAnswered
  });

  static const Map<String,bool> blankSkuIslam = {
    "0": false, "1": false, "2": false, "3": false, "4": false, "5": false, "6": false, "7": false, "8": false, "9": false,
    "10": false, "11": false, "12": false, "13": false, "14": false, "15": false, "16": false, "17": false, "18": false, "19": false,
    "20": false, "21": false, "22": false, "23": false, "24": false, "25": false, "26": false, "27": false, "28": false, "29": false,
    "30": false, "31": false, "32": false, "33": false, "34": false, "35": false, "36": false, "37": false, "38": false, "39": false,
    "40": false, "41": false, "42": false, "43": false, "44": false, "45": false, "46": false, "47": false, "48": false, "49": false,
    "50": false, "51": false, "52": false, "53": false, "54": false, "55": false, "56": false, "57": false, "58": false, "59": false,
    "60": false, "61": false, "62": false, "63": false, "64": false, "65": false, "66": false, "67": false, "68": false, "69": false,
    "70": false, "71": false, "72": false, "73": false, "74": false, "75": false, "76": false, "77": false, "78": false, "79": false,
    "80": false, "81": false, "82": false, "83": false, "84": false, "85": false, "86": false, "87": false, "88": false, "89": false,
    "90": false, "91": false, "92": false, "93": false, "94": false, "95": false, "96": false
  };

  static const Map<String,bool> blankSkuKatolik = {
    "0": false, "1": false, "2": false, "3": false, "4": false, "5": false, "6": false, "7": false, "8": false, "9": false,
    "10": false, "11": false, "12": false, "13": false, "14": false, "15": false, "16": false, "17": false, "18": false, "19": false,
    "20": false, "21": false, "22": false, "23": false, "24": false, "25": false, "26": false, "27": false, "28": false, "29": false,
    "30": false, "31": false, "32": false, "33": false, "34": false, "35": false, "36": false, "37": false, "38": false, "39": false,
    "40": false, "41": false, "42": false, "43": false, "44": false, "45": false, "46": false, "47": false, "48": false, "49": false,
    "50": false, "51": false, "52": false, "53": false, "54": false, "55": false, "56": false, "57": false, "58": false, "59": false,
    "60": false, "61": false, "62": false, "63": false, "64": false, "65": false, "66": false, "67": false, "68": false, "69": false,
    "70": false, "71": false, "72": false, "73": false, "74": false, "75": false, "76": false, "77": false, "78": false, "79": false,
    "80": false, "81": false, "82": false, "83": false, "84": false, "85": false, "86": false, "87": false, "88": false, "89": false,
    "90": false, "91": false, "92": false, "93": false, "94": false, "95": false
  };

  static const Map<String,bool> blankSkuKristen = {
    "0": false, "1": false, "2": false, "3": false, "4": false, "5": false, "6": false, "7": false, "8": false, "9": false,
    "10": false, "11": false, "12": false, "13": false, "14": false, "15": false, "16": false, "17": false, "18": false, "19": false,
    "20": false, "21": false, "22": false, "23": false, "24": false, "25": false, "26": false, "27": false, "28": false, "29": false,
    "30": false, "31": false, "32": false, "33": false, "34": false, "35": false, "36": false, "37": false, "38": false, "39": false,
    "40": false, "41": false, "42": false, "43": false, "44": false, "45": false, "46": false, "47": false, "48": false, "49": false,
    "50": false, "51": false, "52": false, "53": false, "54": false, "55": false, "56": false, "57": false, "58": false, "59": false,
    "60": false, "61": false, "62": false, "63": false, "64": false, "65": false, "66": false, "67": false, "68": false, "69": false,
    "70": false, "71": false, "72": false, "73": false, "74": false, "75": false, "76": false, "77": false, "78": false, "79": false,
    "80": false, "81": false, "82": false, "83": false, "84": false, "85": false, "86": false, "87": false, "88": false, "89": false,
    "90": false, "91": false, "92": false, "93": false, "94": false, "95": false, "96": false, "97": false, "98": false
  };

  static const Map<String,bool> blankSkuHindu = {
    "0": false, "1": false, "2": false, "3": false, "4": false, "5": false, "6": false, "7": false, "8": false, "9": false,
    "10": false, "11": false, "12": false, "13": false, "14": false, "15": false, "16": false, "17": false, "18": false, "19": false,
    "20": false, "21": false, "22": false, "23": false, "24": false, "25": false, "26": false, "27": false, "28": false, "29": false,
    "30": false, "31": false, "32": false, "33": false, "34": false, "35": false, "36": false, "37": false, "38": false, "39": false,
    "40": false, "41": false, "42": false, "43": false, "44": false, "45": false, "46": false, "47": false, "48": false, "49": false,
    "50": false, "51": false, "52": false, "53": false, "54": false, "55": false, "56": false, "57": false, "58": false, "59": false,
    "60": false, "61": false, "62": false, "63": false, "64": false, "65": false, "66": false, "67": false, "68": false, "69": false,
    "70": false, "71": false, "72": false, "73": false, "74": false, "75": false, "76": false, "77": false, "78": false, "79": false,
    "80": false, "81": false, "82": false, "83": false, "84": false, "85": false, "86": false, "87": false, "88": false, "89": false,
    "90": false, "91": false, "92": false, "93": false, "94": false, "95": false, "96": false, "97": false, "98": false, "99": false,
    "100": false, "101": false, "102": false, "103": false, "104": false, "105": false, "106": false, "107": false, "108": false, "109": false
  };

  static const Map<String,bool> blankSkuBuddha = {
    "0": false, "1": false, "2": false, "3": false, "4": false, "5": false, "6": false, "7": false, "8": false, "9": false,
    "10": false, "11": false, "12": false, "13": false, "14": false, "15": false, "16": false, "17": false, "18": false, "19": false,
    "20": false, "21": false, "22": false, "23": false, "24": false, "25": false, "26": false, "27": false, "28": false, "29": false,
    "30": false, "31": false, "32": false, "33": false, "34": false, "35": false, "36": false, "37": false, "38": false, "39": false,
    "40": false, "41": false, "42": false, "43": false, "44": false, "45": false, "46": false, "47": false, "48": false, "49": false,
    "50": false, "51": false, "52": false, "53": false, "54": false, "55": false, "56": false, "57": false, "58": false, "59": false,
    "60": false, "61": false, "62": false, "63": false, "64": false, "65": false, "66": false, "67": false, "68": false, "69": false,
    "70": false, "71": false, "72": false, "73": false, "74": false, "75": false, "76": false, "77": false, "78": false, "79": false,
    "80": false, "81": false, "82": false, "83": false, "84": false, "85": false, "86": false, "87": false, "88": false, "89": false,
    "90": false, "91": false, "92": false, "93": false, "94": false, "95": false, "96": false, "97": false, "98": false, "99": false,
  };

  static String convertSkuToJson(Map<String,bool> sku){
    return jsonEncode(
      sku
    );
  }

  factory ProgressModels.fromResponse(List<Map<String, dynamic>> response) {
    Map<String, dynamic> skuProgressStringMap = response[0]['sku_progress'];
    Map<int, bool> skuProgressIntMap = skuProgressStringMap.map((key, value) {
      return MapEntry(int.parse(key), value as bool);
    });

    Map<String,dynamic> gameProgressStringMap = response[0]['game_progress'];
    List<String> gameProgressList = List<String>.from(gameProgressStringMap['finished_game'] as List);

    print("question answered: ${response[0]['question_answered']}");

    return ProgressModels(
      skuProgress: skuProgressIntMap,
      gameProgress: gameProgressList,
      points: response[0]['points'],
      questionAnswered: response[0]['question_answered'],
    );
  }
}