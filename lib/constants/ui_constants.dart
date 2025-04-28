import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.breathingLogo,
        // ignore: deprecated_member_use
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }
}
