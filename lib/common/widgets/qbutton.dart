import 'package:flutter/material.dart';

class QButton extends StatelessWidget {
  const QButton({
    super.key,
    required this.btnText,
    this.clr = Colors.white,
    this.textClr = Colors.black,
    required this.onTap,
  });

  final String btnText;
  final Color clr;
  final Color textClr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: clr,
            elevation: 5,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              btnText,
              style: TextStyle(color: textClr, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}