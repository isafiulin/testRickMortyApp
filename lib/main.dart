import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrickmortyapp/app_root.dart';
import 'package:testrickmortyapp/injectable.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await configure();

  Animate.restartOnHotReload = true;
  runApp(const AppRoot());
}
