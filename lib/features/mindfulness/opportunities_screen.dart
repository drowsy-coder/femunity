import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpportunitiesScreen extends StatefulWidget {
  @override
  _OpportunitiesScreenState createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  String selectedField = 'STEM';

  final List<Map<String, String>> scholarships = [
    {
      'title': 'TalentSprint WE',
      'description':
          'Women Engineers (WE), a 24-month immersive and LIVE online learning experiential program offered by TalentSprint and supported by Google, trains deserving first-year women engineering students.',
      'url': 'https://we.talentsprint.com/',
      'image': 'https://i.imgur.com/4FFWJ7E.png',
      'field': 'STEM',
    },
    {
      'title': 'DESIS by D.E. Shaw',
      'description':
          'Students enrolled in an undergraduate or postgraduate degree will participate in unique educational experiences in areas ranging from core technical skills to holistic professional development.',
      'url': 'https://www.deshawindia.com/desis-ascend-educare/about.pdf',
      'image': 'https://avatars.githubusercontent.com/u/2298205?s=200&v=4',
      'field': 'Business',
    },
    {
      'title': 'Adobe Women in Tech',
      'description':
          'They recognize talented female undergraduate & master\'s students studying computer science and provide them an opportunity to learn, build, and grow.',
      'url':
          'https://www.adobe.com/in/lead/creativecloud/women-in-technology.html',
      'image':
          'https://1000logos.net/wp-content/uploads/2021/04/Adobe-logo.png',
      'field': 'Law',
    },
  ];

  List<Map<String, String>> getFilteredOpportunities() {
    return scholarships.where((opportunity) {
      return opportunity['field'] == selectedField;
    }).toList();
  }

  void filterOpportunities(String field) {
    setState(() {
      selectedField = field;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredOpportunities =
        getFilteredOpportunities();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Opportunities',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo,
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
                  if (scholarship['field'] == selectedField) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  scholarship['image'] ?? '',
                                  height: 200.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        scholarship['title']?.toUpperCase() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        scholarship['description'] ?? '',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16.0,
                                right: 16.0,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      launch(scholarship['url'] ?? ''),
                                  child: Text(
                                    'Apply Now',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => filterOpportunities('STEM'),
                  child: Text('STEM'),
                  style: ElevatedButton.styleFrom(
                    primary: selectedField == 'STEM'
                        ? Colors.indigo
                        : Colors.grey.shade300,
                    onPrimary:
                        selectedField == 'STEM' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => filterOpportunities('Business'),
                  child: Text('Business'),
                  style: ElevatedButton.styleFrom(
                    primary: selectedField == 'Business'
                        ? Colors.indigo
                        : Colors.grey.shade300,
                    onPrimary: selectedField == 'Business'
                        ? Colors.white
                        : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => filterOpportunities('Law'),
                  child: Text('Law'),
                  style: ElevatedButton.styleFrom(
                    primary: selectedField == 'Law'
                        ? Colors.indigo
                        : Colors.grey.shade300,
                    onPrimary:
                        selectedField == 'Law' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (selectedField == 'STEM')
                  OpportunityTile(
                    company: 'Facebook',
                    position: 'Developer Program Manager',
                    url: 'https://www.facebook.com/careers/jobs/',
                    logo:
                        'https://1000logos.net/wp-content/uploads/2021/10/logo-Meta.png',
                  ),
                if (selectedField == 'Business')
                  OpportunityTile(
                    company: 'Amazon',
                    position: 'Software Development Engineer',
                    url: 'https://www.amazon.jobs/en/',
                    logo:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png',
                  ),
                if (selectedField == 'Law')
                  OpportunityTile(
                    company: 'Google',
                    position: 'Software Engineer',
                    url: 'https://www.google.com/about/careers/',
                    logo:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2008px-Google_%22G%22_Logo.svg.png',
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
  final String logo;

  const OpportunityTile({
    required this.company,
    required this.position,
    required this.url,
    required this.logo,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              logo,
              width: 60,
              height: 60,
            ),
            SizedBox(width: 16),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
