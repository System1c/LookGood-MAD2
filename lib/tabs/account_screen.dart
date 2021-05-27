import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/screens/widgets/home_bar.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

class AccS extends StatefulWidget {
  @override
  _AccSState createState() => _AccSState();
}

class _AccSState extends State<AccS> {
  final formKey = new GlobalKey<FormState>();
  Color greenColor = Color(0xFF00AF19);
  String email = AuthService().getCurrentEm();

  String name = AuthService().getCurrentDet();
  String address;

  Future _addr() {
    return AuthService()
        .users
        .doc(AuthService().getUid())
        .collection("Address")
        .doc("Address0")
        .set({"size": address});
  }

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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

  String validateLength(String value) {
    if (value.length < 6)
      return 'Please enter valid details';
    else
      return null;
  }

  final SnackBar _sb =
      SnackBar(content: Text("Your Password Reset Link has been sent!"));

  final SnackBar _ab =
      SnackBar(content: Text("Your Account Details Have Been Updated!"));

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Form(key: formKey, child: _buildAccountForm()),
        homeActBar(
          tit: "Your Account",
          titH: true,
          bckar: false,
          crt: false,
          logout: true,
        ),
      ],
    ));
  }

  _buildAccountForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(height: 75.0),
          SizedBox(height: 25.0),
          TextFormField(
            initialValue: name,
            decoration: InputDecoration(
                labelText: 'FULL NAME',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor))),
            onChanged: (value) {
              this.name = value;
            },
            validator: (value) =>
                value.isEmpty ? 'Full Name is Required' : null,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: AuthService()
                .users
                .doc(AuthService().getUid())
                .collection("Address")
                .doc("Address0")
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                address = data['size'];

                return TextFormField(
                  initialValue: address,
                  decoration: InputDecoration(
                      labelText: 'ADDRESS',
                      labelStyle: TextStyle(
                          fontFamily: 'Trueno',
                          fontSize: 12.0,
                          color: Colors.grey.withOpacity(0.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor))),
                  onChanged: (value) {
                    this.address = value;
                  },
                  validator: (value) => value.isEmpty
                      ? 'Address is Required'
                      : validateLength(value),
                );
              }
              if (snapshot.hasData && !snapshot.data.exists) {
                return TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ADDRESS',
                      labelStyle: TextStyle(
                          fontFamily: 'Trueno',
                          fontSize: 12.0,
                          color: Colors.grey.withOpacity(0.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor))),
                  onChanged: (value) {
                    this.address = value;
                  },
                  validator: (value) => value.isEmpty
                      ? 'Address is Required'
                      : validateLength(value),
                );
              }
              return Text("Loading");
            },
          ),
          SizedBox(height: 25.0),
          GestureDetector(
            onTap: () async {
              if (checkFields()) AuthService().setCurrentDet(name);
              await _addr();
              ScaffoldMessenger.of(context).showSnackBar(_ab);
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('UPDATE ACCOUNT',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 100.0),
          TextFormField(
            initialValue: email,
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
          SizedBox(height: 40.0),
          GestureDetector(
            onTap: () {
              if (checkFields())
                ScaffoldMessenger.of(context).showSnackBar(_sb);
              AuthService().resetPassW(email);
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('RESET PASSWORD',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
        ],
      ),
    );
  }
}
