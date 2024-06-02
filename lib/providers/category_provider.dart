import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_jobs/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await http.get(
        Uri.parse('https://future-jobs-api.vercel.app/categories'),
      );

      // print('Category Status Code: ${response.statusCode}');
      // print('Category Response: ${response.body}');
      // done, no error.

      if (response.statusCode == 200) {
        List<CategoryModel> categories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((category) {
          categories.add(CategoryModel.fromJson(category));
        });

        return categories;
      } else {
        return [];
      }
    } catch (e) {
      print("getCategories Error: ${e}");
      return [];
    }
  }
}

// ignore_for_file: empty_catches