import 'package:migscourier/components/buttons/custom_round.dart';
import 'package:migscourier/services/network/auth.dart';
import 'package:migscourier/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = Provider.of<AuthServices>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("Log In", style: kH3),
        ),
        brightness: Brightness.dark,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _auth.showSpinner,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /// LOGO
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64.0),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Image.asset("assets/images/launcher_icon.jpg",
                          height: 120.0,
                          width: 120.0,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  /// PHONE NUMBER FIELD
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _auth.phone,
                    decoration: kTextFieldDecoration.copyWith(
                      icon: Icon(Icons.phone, size: 40),
                      labelText: "Phone Number",
                      hintText: "e.g. 09123456789",
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                    validator: (value){
                      if(value.length < 11 || value.length > 11) {
                        return 'Invalid Phone Number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.0),
                  /// PASSWORD FIELD
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _auth.password,
                    decoration: kTextFieldDecoration.copyWith(
                      icon: Icon(Icons.lock, size: 40),
                      labelText: "Password",
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                    validator: (value){
                      if(value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 24.0),
                  /// LOGIN BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomRoundButton(
                      buttonTitle: "Log In",
                      buttonColor: kMainThemeColor,
                      buttonWidth: 200.0,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _auth.logIn(_scaffoldKey.currentContext);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
