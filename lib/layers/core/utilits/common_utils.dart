import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CommonUtil {
  static bool isSnackBarScheduled = false;

  static void showSnackBar(
    BuildContext context,
    String message, {
    Color messageColor = Colors.black,
  }) {
    Future.delayed(const Duration(milliseconds: 500), () {
      SmartDialog.showToast('',
              displayTime: const Duration(seconds: 2),
              builder: (context) => Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 3,
                            color: Color.fromRGBO(26, 42, 97, 0.06),
                          ),
                        ],
                      ),
                      child: Text(
                        message,
                        style: TextStyle(color: messageColor, fontSize: 16),
                      ),
                    ),
                  ),
              alignment: Alignment.topLeft,
              maskColor: Colors.transparent)
          .then((value) => isSnackBarScheduled = false);
    });
  }
}
