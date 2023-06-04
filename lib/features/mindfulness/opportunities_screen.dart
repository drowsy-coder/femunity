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
      'image': 'assets/images/talentsprint.png',
      'field': 'STEM',
    },
    {
      'title': 'DESIS by D.E. Shaw',
      'description':
          'Students enrolled in an undergraduate or postgraduate degree will participate in unique educational experiences in areas ranging from core technical skills to holistic professional development.',
      'url': 'https://www.deshawindia.com/desis-ascend-educare/about.pdf',
      'image': 'assets/images/deshaw.png',
      'field': 'STEM',
    },
    {
      'title': 'Adobe Women in Tech',
      'description':
          'They recognize talented female undergraduate & master\'s students studying computer science and provide them an opportunity to learn, build, and grow.',
      'url':
          'https://www.adobe.com/in/lead/creativecloud/women-in-technology.html',
      'image': 'assets/images/Adobe-logo.png',
      'field': 'STEM',
    },
    {
      'title': 'Business Internships',
      'description':
          'Students enrolled in an undergraduate or postgraduate degree will participate in unique educational experiences in areas ranging from core technical skills to holistic professional development.',
      'url': 'https://careers.google.com/students/business-internships/',
      'image': 'assets/images/google.png',
      'field': 'Business',
    },
    {
      'title': 'We Make Scholars',
      'description':
          'They recognize talented female undergraduate & master\'s students studying computer science and provide them an opportunity to learn, build, and grow.',
      'url':
          'https://www.wemakescholars.com/',
      'image': 'assets/images/busScholar.webp',
      'field': 'Business',
    },
    {
      'title': 'DELL SCHOLARS PROGRAM ',
      'description':
          'Women Engineers (WE), a 24-month immersive and LIVE online learning experiential program offered by TalentSprint and supported by Google, trains deserving first-year women engineering students.',
      'url': 'https://www.dellscholars.org/',
      'image': 'assets/images/dell.jpg',
      'field': 'Business',
    },
    {
      'title': 'Empowering Women in Law Scholarship',
      'description':
          'Students enrolled in an undergraduate or postgraduate degree will participate in unique educational experiences in areas ranging from core technical skills to holistic professional development.',
      'url': 'https://studentscholarships.org/scholarship/13274/empowering-women-in-law-scholarship',
      'image': 'assets/images/ss.png',
      'field': 'Law',
    },
    {
      'title': 'LAW SCHOOL SCHOLARSHIPS FOR WOMEN',
      'description':
          'They recognize talented female undergraduate & master\'s students studying computer science and provide them an opportunity to learn, build, and grow.',
      'url':
          'https://www.bu.edu/law/about/offices/financial-aid/scholarships/scholarships-writing-competitions/outside-scholarships/women/',
      'image': 'assets/images/law.jpg',
      'field': 'Law',
    },
    {
      'title': 'Events and opportunities in the field of law',
      'description':
          'Women Engineers (WE), a 24-month immersive and LIVE online learning experiential program offered by TalentSprint and supported by Google, trains deserving first-year women engineering students.',
      'url': 'https://www.lawctopus.com/tag/chennai-law-firm-internship/',
      'image': 'assets/images/lawocc.png',
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
        title: const Text(
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
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: filteredOpportunities.map((scholarship) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      scholarship['title']?.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
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
                                child: const Text(
                                  'Learn More',
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
                                  padding: const EdgeInsets.symmetric(
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
                  child: const Text('STEM'),
                  style: ElevatedButton.styleFrom(
                    primary: selectedField == 'STEM'
                        ? Colors.indigo
                        : Colors.grey.shade300,
                    onPrimary:
                        selectedField == 'STEM' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => filterOpportunities('Business'),
                  child: const Text('Business'),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => filterOpportunities('Law'),
                  child: const Text('Law'),
                  style: ElevatedButton.styleFrom(
                    primary: selectedField == 'Law'
                        ? Colors.indigo
                        : Colors.grey.shade300,
                    onPrimary:
                        selectedField == 'Law' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
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
                  const OpportunityTile(
                    company: 'DAAD WISE',
                    position: 'Research Intern',
                    url:
                        'https://www2.daad.de/deutschland/stipendium/datenbank/en/21148-scholarship-database/?detail=50015295',
                    logo: 'assets/images/daad.png',
                  ),
                if (selectedField == 'STEM')
                  const OpportunityTile(
                    company: 'Mitacs',
                    position: 'Globalink Research Intern',
                    url:
                        'https://www.mitacs.ca/en/programs/globalink/globalink-research-internship',
                    logo: 'assets/images/mitacs.png',
                  ),
                if (selectedField == 'STEM')
                  const OpportunityTile(
                    company: 'CERN',
                    position: 'Summer Student Programme',
                    url: 'https://careers.cern/summer',
                    logo: 'assets/images/CERN.svg.png',
                  ),
                if (selectedField == 'Business')
                  const OpportunityTile(
                    company: 'Amazon',
                    position: 'Software Development Engineer',
                    url: 'https://www.lagrantfoundation.org/about-our-scholarships',
                    logo: 'assets/images/lagrant.png',
                  ),
                if (selectedField == 'Business')
                  const OpportunityTile(
                    company: 'Amazon',
                    position: 'Prouction Manager',
                    url: 'https://www.amazon.jobs/en/',
                    logo: 'assets/images/Amazon_icon.svg.png',
                  ),
                if (selectedField == 'Business')
                  const OpportunityTile(
                    company: 'SFI',
                    position: 'Analyst',
                    url: 'https://www.wemakescholars.com/research-institute/science-foundation-ireland',
                    logo: 'assets/images/sfi.png',
                  ), 
                if (selectedField == 'Law')
                  const OpportunityTile(
                    company: 'ETS',
                    position: 'Accountant',
                    url: 'https://www.wemakescholars.com/other/educational-testing-service-ets-',
                    logo: 'assets/images/ets.jpg',
                  ),
                if (selectedField == 'Law')
                  const OpportunityTile(
                    company: 'ABD',
                    position: 'Staff Attorney',
                    url: 'https://www.wemakescholars.com/scholarship/asian-development-bank-japan-scholarship-program',
                    logo: 'assets/images/abd.jpeg',
                  ),
                if (selectedField == 'Law')
                  const OpportunityTile(
                    company: 'ServiceScape',
                    position: 'Judge',
                    url: 'https://www.wemakescholars.com/scholarship/asian-development-bank-japan-scholarship-program',
                    logo: 'assets/images/ssssss.jpg',
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
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              logo,
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 8),
                  Text(
                    position,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      padding: const EdgeInsets.symmetric(
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
