import 'package:flutter/material.dart';
import 'package:migscourier/constants.dart';

class CustomRoundButton extends StatelessWidget {

  final String buttonTitle;
  final Color buttonColor;
  final double buttonWidth;
  final Function onPressed;

  const CustomRoundButton({
    @required this.buttonTitle,
    @required this.buttonColor,
    this.buttonWidth,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      elevation: 4.0,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: buttonWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 0.0),
            Text(buttonTitle, style: kH4Dark),
          ],
        ),
      ),
    );
  }

}