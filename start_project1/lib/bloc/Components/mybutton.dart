import 'package:flutter/material.dart';

class MyButtonNumber extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? buttonTapped;

  const MyButtonNumber({super.key, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonTapped,
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Text(
          buttonText!,
          style: buttonText == 'C'
              ? const TextStyle(color: Colors.redAccent, fontSize: 24)
              : Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class MyButtonOperator extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? buttonTapped;

  const MyButtonOperator({super.key, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonTapped,
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(
          buttonText!,
          style: const TextStyle(color: Colors.green, fontSize: 35),
        ),
      ),
    );
  }
}

class MyButtonEqal extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? buttonTapped;

  const MyButtonEqal({super.key, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text(buttonText!,
              style: const TextStyle(color: Colors.white, fontSize: 30)),
        ),
      ),
    );
  }
}
