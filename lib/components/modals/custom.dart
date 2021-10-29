import 'package:migscourier/components/buttons/custom_round.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {

  CustomDialogBox({
    this.title,
    this.content,
    this.enableSecondaryButton,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.mainButtonOnPressed,
  });

  final String title;
  final String content;
  final bool enableSecondaryButton;
  final String mainButtonTitle;
  final String secondaryButtonTitle;
  final Function mainButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: kH1Blue),
                Padding(padding: const EdgeInsets.all(12.0)),
                Text(content, style: kBody, softWrap: true, overflow: TextOverflow.visible),
                Padding(padding: const EdgeInsets.all(24.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: enableSecondaryButton,
                  child: CustomRoundButton(
                    buttonTitle: secondaryButtonTitle,
                    buttonColor: kNegativeColor,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                CustomRoundButton(
                  buttonTitle: mainButtonTitle,
                  buttonColor: kMainThemeColor,
                  onPressed: mainButtonOnPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}