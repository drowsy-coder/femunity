import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpportunitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opportunities'),
      ),
      body: ListView(
        children: [
          _buildOpportunityCard(
            context,
            'Software Engineer',
            'Google',
            'Mountain View, CA',
            'https://www.google.com/about/careers/jobs/#!t=jo&jid=/google/software-engineer-machine-learning-1600-amphitheatre-pkwy-mountain-view-ca-4526100013',
          ),
          _buildOpportunityCard(
            context,
            'Product Manager',
            'Facebook',
            'Menlo Park, CA',
            'https://www.facebook.com/careers/jobs/3656672844382376/',
          ),
          _buildOpportunityCard(
            context,
            'UX Designer',
            'Apple',
            'Cupertino, CA',
            'https://jobs.apple.com/en-us/details/200247427/ux-designer',
          ),
          _buildOpportunityCard(
            context,
            'Data Analyst',
            'Amazon',
            'Seattle, WA',
            'https://www.amazon.jobs/en/jobs/1665579/data-analyst',
          ),
          _buildOpportunityCard(
            context,
            'Marketing Manager',
            'Microsoft',
            'Redmond, WA',
            'https://careers.microsoft.com/us/en/job/1123434/Marketing-Manager',
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(
      BuildContext context, String title, String company, String location, String url) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () => _openUrl(url),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              Text(
                company,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8.0),
              Text(
                location,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}