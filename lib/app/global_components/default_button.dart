import 'package:flutter/material.dart';

import '../config/constant.dart';
import 'default_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    this.text = '',
    this.onTap,
    this.height = 50,
    this.width = 120,
    super.key,
  });

  final String text;
  final Function()? onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      borderRadius: kDefaultBorderRadius10,
      child: InkWell(
        borderRadius: kDefaultBorderRadius10,
        splashColor: kBgBlack.withOpacity(0.2),
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          child: Center(
            child: DefText(text).large,
          ),
        ),
      ),
    );
  }
}
