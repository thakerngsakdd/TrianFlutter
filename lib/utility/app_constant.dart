import 'package:flutter/material.dart';

class AppContant {
  BoxDecoration basicBox({required BuildContext context}) => BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
      );

  BoxDecoration linearBox({required BuildContext context}) => BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Theme.of(context).primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );

  BoxDecoration radienBox({required BuildContext context}) => BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Theme.of(context).primaryColor],
          radius: 1,
          center: Alignment(-0.5,-0.5),
        ),
      );
}
