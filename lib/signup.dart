import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/services/authservice.dart';
import 'package:lookgood_cb007942/services/errorHand.dart';

class SignUpP extends StatefulWidget {
  @override
  _SignUpPState createState() => _SignUpPState();
}

class _SignUpPState extends State<SignUpP> {
  final formKey = new GlobalKey<FormState>();

  String email, password;
  String address = " ";

  Color greenColor = Color(0xFF00AF19);

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future _addrreg() {
    return AuthService()
        .users
        .doc(AuthService().getUid())
        .collection("Address")
        .doc("Address0")
        .set({"size": address});
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(height: 75.0),
          Container(
            height: 400.0,
            width: 200,
            child: Stack(
              children: [
                Text('Sign Up',
                    style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                Positioned(
                  top: 82.0,
                  left: 253.0,
                  child: Container(
                      height: 20.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: greenColor)),
                ),
                Positioned(
                    top: 70.0,
                    left: 5,
                    child: Text(
                      'to change how you Shop',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 20.0),
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor))),
            onChanged: (value) {
              this.email = value;
            },
            validator: (value) =>
                value.isEmpty ? 'Email is Required' : validateEmail(value),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor))),
            onChanged: (value) {
              this.password = value;
            },
            validator: (value) => value.isEmpty ? 'Password is Required' : null,
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields())
                AuthService().signUp(email, password).then((userCreds) {
                  Navigator.of(context).pop();
                }).catchError((e) {
                  ErrorHand().errorDialog(context, e);
                });
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(
                      color: greenColor,
                      fontFamily: 'Trueno',
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
