library flsTheme;

import 'package:app_aerofarallones/constants.dart';
import 'package:flutter/material.dart';

class FlsTheme {
  AppBar appBarFls({
    required BuildContext context,
    required String name,
    required bool returning,
  }) {
    return AppBar(
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Constants.mainColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
