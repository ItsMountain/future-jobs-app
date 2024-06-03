import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_jobs/models/job_model.dart';
import 'package:http/http.dart' as http;

class JobProvider with ChangeNotifier {
  Future<List<JobModel>> getJobs() async {
    try {
      var response =
          await http.get(Uri.parse('https://future-jobs-api.vercel.app/jobs'));

      // print('Job Status Code: ${response.statusCode}');
      // print('Job Response: ${response.body}');

      if (response.statusCode == 200) {
        List<JobModel> jobs = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((job) {
          jobs.add(JobModel.fromJson(job));
        });

        return jobs;
      } else {
        print('Failed to load jobs: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('getJobs Error: ${e}');
      return [];
    }
  }

  Future<List<JobModel>> getJobsByCategory(String category) async {
    try {
      var response = await http.get(Uri.parse(
          'https://future-jobs-api.vercel.app/jobs?category=$category'));

      // print('Job By Category Status Code: ${response.statusCode}');
      // print('Job By Category Response: ${response.body}');

      if (response.statusCode == 200) {
        List<JobModel> jobs = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((job) {
          jobs.add(JobModel.fromJson(job));
        });

        // parsedJson.forEach((category) {
        //   categories.add(CategoryModel.fromJson(category));
        // });

        return jobs;
      } else {
        return [];
      }
    } catch (e) {
      print('getJobsByCategory Error: ${e}');
      return [];
    }
  }
}
