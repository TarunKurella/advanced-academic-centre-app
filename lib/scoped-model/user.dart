import 'package:scoped_model/scoped_model.dart';
import 'package:aacx/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
mixin UserModel on Model{

  User authenticatedUser;

  Future<String > login(String email, String password)async {
    String url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyA99SRvaKgofWcBbIhKn4O-sZ-TVYcrpwA";


    Map values = {
      "email":email,
      "password": password,
      "returnSecureToken": true
    };
    http.Response response =await http.post(url, body: jsonEncode(values),headers: {"Content-Type":"application/json"});
    Map responseData = jsonDecode(response.body);
    print(responseData);
    authenticatedUser =
    new User(id:responseData["localId"] , email: email, password: password);
    Firestore.instance.collection("/users").add({"id":responseData["localId"] , "email": email, "password": password}).then((onValue){
      print(onValue.documentID);
    });
    print((responseData));
    bool hasError = true;
    String message = "something went wrong";
    if(responseData.containsKey('idToken')){
      hasError = false;
      message  = " Authentication Succeded";

    }else if (responseData["error"]["message"]=="EMAIL_NOT_FOUND"){
      message= " Email not found";
    }
    else if (responseData["error"]["message"]=="INVALID_PASSWORD"){
      message= " Wrong password";
    }
    if(hasError){
      return message;
    }else
      {
        return null;
      }

  }

  Future<String> signUp(String email, String password) async {
    String url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyA99SRvaKgofWcBbIhKn4O-sZ-TVYcrpwA";
    Map values = {
      "email":email,
      "password": password,
      "returnSecureToken": true
    };
    http.Response response =await http.post(url, body: jsonEncode(values),headers: {"Content-Type":"application/json"});
    Map responseData = jsonDecode(response.body);
    String message = "something went wrong";
    print((responseData));
    bool hasError = true;
    if(responseData.containsKey('idToken')){
      hasError = false;
      message  = " Authentication Succeded";

    }else if (responseData["error"]["message"]=="EMAIL_EXISTS"){
      message= " This mail already Exists";
    }

    if(hasError){
     return message;
    }else
    {
      return null;
    }
  }
}