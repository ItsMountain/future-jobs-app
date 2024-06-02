import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_jobs/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Future<UserModel?> register(
    String name,
    String email,
    String password,
    String goal,
  ) async {
    try {
      // print(
      //     'Register Request - Name: $name, Email: $email, Password: $password, Goal: $goal');

      // Hardcoded values for debugging
      // var body = {
      //   'name': 'Test Name',
      //   'email': 'test@example.com',
      //   'password': 'testpassword',
      //   'goal': 'testgoal',
      // };

      var body = {
        'name': name,
        'email': email,
        'password': password,
        'goal': goal,
      };

      var response = await http.post(
        Uri.parse('https://future-jobs-api.vercel.app/register'),
        body: body,
      );

      // print('Register Response - Status Code: ${response.statusCode}');
      // print('Register Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Register Exception: $e');
      return null;
    }
  }

  Future<UserModel?> login(
    String email,
    String password,
  ) async {
    try {
      var body = {'email': email, 'password': password};

      var response = await http.post(
        Uri.parse('https://future-jobs-api.vercel.app/login'),
        body: body,
      );

      // print('Sign in Response - Status Code: ${response.statusCode}');
      // print('Sign in Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

// ignore_for_file: prefer_const_constructors