import 'package:flutter/material.dart';
import 'package:migscourier/components/modals/custom.dart';

class DialogsServices {

  showCustom({
    BuildContext context,
    String title,
    String content,
    bool enableSecondaryButton = false,
    String mainButtonTitle,
    String secondaryButtonTitle,
    Function mainButtonOnPressed,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOutCubic.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: CustomDialogBox(
              title: title,
              content: content,
              enableSecondaryButton: enableSecondaryButton,
              mainButtonTitle: mainButtonTitle,
              secondaryButtonTitle: secondaryButtonTitle,
              mainButtonOnPressed: mainButtonOnPressed,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      },
    );
  }

  showError(BuildContext context, String content) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOutCubic.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: CustomDialogBox(
              title: "Uh-oh!",
              content: "$content",
              enableSecondaryButton: false,
              mainButtonTitle: "Back",
              secondaryButtonTitle: "",
              mainButtonOnPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      },
    );
  }

  showOffline(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOutCubic.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: CustomDialogBox(
              title: "Offline",
              content: "Please check your internet connection and try again.",
              mainButtonTitle: "Okay",
              mainButtonOnPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      },
    );
  }

}