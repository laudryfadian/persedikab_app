import 'package:flutter/material.dart';

class IconButtonNav {
  IconButton iconButtonNav(
      Icon icon, void index, double iconSize, Color color) {
    return IconButton(
      onPressed: () {
        return index;
      },
      icon: icon,
      iconSize: iconSize,
      color: color,
    );
  }
}
