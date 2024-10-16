
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseDb {
  late var supabase = Supabase.instance.client;
  Future<void> initSupabase() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['URL']!,
      anonKey: dotenv.env['ANON_KEY']!,
    );
  }
}