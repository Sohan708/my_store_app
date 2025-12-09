import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store_app/global_variables.dart';
import 'package:my_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:my_store_app/provider/user_provider.dart';
import 'package:my_store_app/services/manage_http_response.dart';
import 'package:my_store_app/view/screens/authentication_screens/login_screen.dart';
import 'package:my_store_app/view/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> singUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(), //convert user object to json for the request body
        headers: <String, String>{
          //set the headers for the request
          'Content-Type':
              'application/json; charset=utf-8', //specify the content type as json
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackbar(context: context, title: 'account created successfully');
        },
      );
    } catch (e) {
      showSnackbar(context: context, title: 'Error: ${e.toString()}');
    }
  }

  //sign in users function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          //this will set the headers for the request
          'Content-Type': 'application/json; charset=utf-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          //Access sharedPreferences for token and usser data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();

          //extract the authentication token from the response body
          String token = jsonDecode(response.body)['token'];

          //Store the authentication token in sharedPreferences
          await preferences.setString('auth_token', token);

          //encode the user data to json and store it in sharedPreferences
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          //update the application state with the user data
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //store the data in sharedPreference for future use
          await preferences.setString('user_data', userJson);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
          showSnackbar(context: context, title: 'Signed in successfully');
        },
      );
    } catch (e) {
      showSnackbar(context: context, title: 'Error: ${e.toString()}');
    }
  }
}
