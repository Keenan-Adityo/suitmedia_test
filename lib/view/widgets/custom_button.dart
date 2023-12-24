import 'package:flutter/material.dart';
import 'package:suitmedia_test/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const CustomButton({required this.text, required this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            backgroundColor:
                MaterialStateProperty.all(const Color.fromRGBO(43, 99, 123, 1))),
        onPressed: callback,
        child: Text(
          text,
          style: kButtonText,
        ),
      ),
    );
  }
}
