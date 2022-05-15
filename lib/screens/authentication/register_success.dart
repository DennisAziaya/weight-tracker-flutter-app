import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie_animation_files/thank-you.json",
                repeat: false, reverse: true, animate: true),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "An email confirmation link was sent to you",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
