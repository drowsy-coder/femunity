import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OpportunitiesScreen extends StatelessWidget {
  final List<Map<String, String>> scholarships = [
    {
      'title': 'ABC Scholarship',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae odio in leo cursus faucibus. Nulla facilisi.'
      'Vivamus interdum enim at leo commodo, vitae fringilla massa consequat.',
      
      'url': 'https://www.example.com/scholarship1'
    },
    {
      'title': 'XYZ Scholarship',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae odio in leo cursus faucibus. Nulla facilisi.'
      'Vivamus interdum enim at leo commodo, vitae fringilla massa consequat.',
      
      'url': 'https://www.example.com/scholarship2'
    },
    {
      'title': '123 Scholarship',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae odio in leo cursus faucibus. Nulla facilisi.'
      'Vivamus interdum enim at leo commodo, vitae fringilla massa consequat.',
      
      'url': 'https://www.example.com/scholarship3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opportunities'),
      ),
      body: Column(
        children: [
          Expanded(
  child: Container(
    height: 200.0,
    child: CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: scholarships.map((scholarship) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF1C1C1E)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    scholarship['title']!,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      scholarship['description']!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  MaterialButton(
                    onPressed: () => launch(scholarship['url']!),
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                    minWidth: 120.0,
                    height: 40.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    ),
  ),
),
          Expanded(
            child: ListView(
              children: [
                OpportunityTile(
                  company: 'Google',
                  position: 'Software Engineer',
                  url: 'https://www.google.com/about/careers/',
                ),
                OpportunityTile(
                  company: 'Facebook',
                  position: 'Developer Program Manager',
                  url: 'https://www.facebook.com/careers/jobs/',
                ),
                OpportunityTile(
                  company: 'Amazon',
                  position: 'Software Development Engineer',
                  url: 'https://www.amazon.jobs/en/',
                ),
                OpportunityTile(
                  company: 'Google',
                  position: 'Software Engineer',
                  url: 'https://www.google.com/about/careers/',
                ),
                OpportunityTile(
                  company: 'Facebook',
                  position: 'Developer Program Manager',
                  url: 'https://www.facebook.com/careers/jobs/',
                ),
                OpportunityTile(
                  company: 'Amazon',
                  position: 'Software Development Engineer',
                  url: 'https://www.amazon.jobs/en/',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpportunityTile extends StatelessWidget {
  final String company;
  final String position;
  final String url;

  const OpportunityTile({
    required this.company,
    required this.position,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  ),
  child: Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          company,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          position,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        OutlinedButton(
          onPressed: () => launch(url),
          child: Text(
            'Apply Now',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 8.0,
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}