import 'package:flutter/material.dart';
import 'package:aacx/scoped-model/mainn.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

enum AuthMode { Signup, Login }

//Login Screen Implementation

class Autho extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Authoclass();
  }
}

class Authoclass extends State<Autho> {
  String email = null;
  String password = null;
  bool property = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController passwordtextcontroller = new TextEditingController();
  AuthMode authMode = AuthMode.Login;

  showwAlert(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please accept the terms and conditions"),
            actions: <Widget>[
              MaterialButton(
                  child: Text("OK"), onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  Widget buildPassword() {
    return TextFormField(
      controller: passwordtextcontroller,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          filled: true,
          fillColor: Colors.white.withOpacity(0.3)),
      onSaved: (String valuee) {
        setState(() {
          password = valuee;
        });
      },
    );
  }

  Widget buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Your Email ",
          filled: true,
          fillColor: Colors.white.withOpacity(0.3)),
      onSaved: (String valuee) {
        setState(() {
          email = valuee;
        });
      },
    );
  }

  Widget passwordValidate() {
    if (authMode == AuthMode.Signup) {
      return TextFormField(
        validator: (String value) {
          if (passwordtextcontroller.text != value) {
            return ' please make sure passwords are same';
          }
        },
        obscureText: true,
        decoration: InputDecoration(
            labelText: "confirm password",
            filled: true,
            fillColor: Colors.white.withOpacity(0.3)),
        onSaved: (String valuee) {
          setState(() {});
        },
      );
    } else
      return Container();
  }

  Widget backgroundImage(
    Widget childd,
  ) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.overlay),
                fit: BoxFit.fill,
                image: AssetImage('asset/hi.png'))),
      ),
      childd
    ]);
  }

  void onSubmitted() {
    formkey.currentState.save();
    ScopedModelDescendant<MainModel>(
      builder: (context, Widget, Mainmodel) {
        Mainmodel.login(email, password);
      },
    );
  }

  Widget buildLogin(Function login, Function signup) {
    String Message;
    return Center(
        child: RaisedButton(
            color: Colors.white.withOpacity(0.4),
            child: Text(authMode == AuthMode.Login ? "Login" : "Sign up"),
            onPressed: ()async {
              if (!property) {
                showwAlert(context);
                return;
              }
              if (!formkey.currentState.validate()) {
                return;
              }
              formkey.currentState.save();
//              authMode = authMode == AuthMode.Login
//                  ? login(email,password)
//                  : signup(email,password);
              if(authMode == AuthMode.Login){

                Message= await  login(email,password);

              }
              else
                {
                  Message=await signup(email,password);

                }
              if(Message==null){
                Navigator.pushReplacementNamed(context, '/');
              }
              else
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(Message),
                          actions: <Widget>[
                            MaterialButton(
                                child: Text("OK"), onPressed: () => Navigator.pop(context))
                          ],
                        );
                      });
                }
            }));

    ;
  }

  @override
  Widget build(BuildContext context) {
//    double deviceWidth = MediaQuery.of(context).size.width;
//    double targetWidth = MediaQuery.of(context).orientation==Orientation.landscape? deviceWidth*0.6 : deviceWidth;
    return Scaffold(
      body: Form(
        key: formkey,
        child: backgroundImage(Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 130.0,
                  ),
                  Icon(
                    Icons.group,
                    size: 140.0,
                  ),
                  buildUsername(),
                  buildPassword(),
                  passwordValidate(),
                  SwitchListTile(
                    title: Text("Accept terms"),
                    onChanged: (bool value) {
                      setState(() {
                        property = value;
                      });
                    },
                    value: property,
                  ),
                  FlatButton(
                    child: Text(
                        " Switch to ${authMode == AuthMode.Login ? "signup" : "Login"}"),
                    onPressed: () {
                      setState(() {
                        authMode = authMode == AuthMode.Login
                            ? AuthMode.Signup
                            : AuthMode.Login;
                      });
                    },
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  ScopedModelDescendant<MainModel>(
                      builder: (context, Widget, Mainmodel) {
                    return buildLogin(Mainmodel.login, Mainmodel.signUp);
                  }),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
