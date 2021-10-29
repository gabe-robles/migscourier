import 'package:flutter/material.dart';

const kMainThemeColor = Color(0xFF002540);
const kSecondaryThemeColor = Color(0xFFFFBB00);
const kNegativeColor = Colors.red;
const kNavBarBGColor = Color(0xFF333333);
const kInactiveNavItemColor = Colors.white;
const kScreenBackgroundColor = Colors.white;
const kDarkThemeTextColor = Colors.white;
const kScaffoldBGColor = Color(0xFFF5F5F5);
const kPositiveColor = Colors.green;
const kDisabledColor = Colors.grey;

const kDefaultPadding = 20.0;

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: kMainThemeColor),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kMainThemeColor, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  icon: Text('+63', style: kH4),
  labelText: 'Label',
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontFamily: 'Biryani'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kTextBoxDecoration = InputDecoration(
  icon: null,
  labelText: 'Label',
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontFamily: 'Biryani'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kDropDownDecoration = InputDecoration(
  icon: null,
  labelText: 'Label',
  hintText: 'Select an option',
  hintStyle: TextStyle(fontFamily: 'Biryani'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kTextFieldLeftDecoration = InputDecoration(
  icon: null,
  labelText: 'Label',
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontFamily: 'Biryani'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 1.0),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
  ),
);

const kDropDownRightDecoration = InputDecoration(
  icon: null,
  labelText: 'Label',
  hintText: 'Select an option',
  hintStyle: TextStyle(fontFamily: 'Biryani'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 1.0),
    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainThemeColor, width: 2.0),
    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
  ),
);

//Text Style Black
const kH1 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const kH2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kH3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kH4 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kH5 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const kH6 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const kBody = TextStyle(
  fontSize: 14,
);

//Text Style Blue
const kH1Blue = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kH2Blue = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kH3Blue = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kH4Blue = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kH5Blue = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kH6Blue = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kMainThemeColor,
);

const kBodyBlue = TextStyle(
  fontSize: 14,
  color: kMainThemeColor,
);


//Text Style Blue
const kH1Dark = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kH2Dark = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kH3Dark = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kH4Dark = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kH5Dark = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kH6Dark = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kDarkThemeTextColor,
);

const kBodyDark = TextStyle(
  fontSize: 14,
  color: kDarkThemeTextColor,
);

const kOrderItemTotalTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: kDarkThemeTextColor
);