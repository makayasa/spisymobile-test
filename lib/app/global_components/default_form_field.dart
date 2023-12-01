import 'package:flutter/material.dart';
import 'package:spisymobile_test/app/config/constant.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    this.hint,
    this.initialValue,
    this.masText = false,
    required this.onChanged,
    this.onTap,
    this.suffix,
    this.enabled = true,
    this.width,
  });

  final String? hint;
  final String? initialValue;
  final Function(String) onChanged;
  final Function()? onTap;
  final bool masText;
  final Widget? suffix;
  final bool enabled;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        onChanged: onChanged,
        style: kDefaultTextStyle,
        obscureText: masText,
        onTap: onTap,
        enabled: enabled,
        initialValue: initialValue,
        decoration: InputDecoration(
          suffix: suffix,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.amber,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
