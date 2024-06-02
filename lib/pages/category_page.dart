import 'package:flutter/material.dart';
import 'package:future_jobs/models/category_model.dart';
// import 'package:future_jobs/models/category_model.dart';
import 'package:future_jobs/models/job_model.dart';
import 'package:future_jobs/providers/job_provider.dart';
import 'package:provider/provider.dart';
import 'package:future_jobs/theme.dart';
import 'package:future_jobs/widgets/job_tile.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class CategoryPage extends StatelessWidget {
  final CategoryModel category;

  CategoryPage(this.category);

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);

    Widget header() {
      return Container(
        height: 270,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: defaultMargin,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(category.imageUrl),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '12,309 available', // static
              style: whiteTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget companies() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Big Companies',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<JobModel>>(
              future: jobProvider.getJobsByCategory(category.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return Column(
                      children: snapshot.data!
                          .map((job) => JobTile(job: job))
                          .toList(),
                    );
                  } else {
                    return Center(
                      child: Text('No jobs found.'),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text('Failed to load jobs.'),
                  );
                }
              },
            ),
            // JobTile(
            //   companyLogo: 'assets/icon_google.png',
            //   name: 'Front-End Developer',
            //   companyName: 'Google',
            // ),
            // JobTile(
            //   companyLogo: 'assets/icon_instagram.png',
            //   name: 'UI Designer',
            //   companyName: 'Instagram',
            // ),
            // JobTile(
            //   companyLogo: 'assets/icon_facebook.png',
            //   name: 'Data Scientist',
            //   companyName: 'Facebook',
            // ),
          ],
        ),
      );
    }

    Widget newStartups() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 20,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Startups',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FutureBuilder<List<JobModel>>(
              future: jobProvider.getJobs(),
              builder: (context, snapshot) {
                print('snapshotData - ${snapshot.data}');
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return Column(
                      children: snapshot.data!
                          .map((job) => JobTile(job: job))
                          .toList(),
                    );
                  } else {
                    return Center(
                      child: Text('No jobs found test.'),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text('Failed to load jobs.'),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            companies(),
            newStartups(),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors