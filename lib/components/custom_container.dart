import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
   CustomButton({required this.textTap, this.onTap});

  String textTap;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 40,
                child: Center(
                    child: Text(
                  textTap,
                  style: TextStyle(color: Color(0xff274460), fontSize: 18),
                )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
  }
}