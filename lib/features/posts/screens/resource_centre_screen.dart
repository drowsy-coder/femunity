import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResourceCentrePage extends StatelessWidget {
  ResourceCentrePage({Key? key}) : super(key: key);

  void navigateToDigital(BuildContext context) {
    Routemaster.of(context).push('/safety/digital');
  }

  final List<Resource> resources = [
    Resource(
      title: 'Cyber Crime Reporting',
      description:
          'This portal is an initiative of Government of India to facilitate victims/complainants to report cyber crime complaints online.',
      url: 'https://cybercrime.gov.in/',
      thumbnailUrl: 'assets/images/cybercrime.png',
    ),
    Resource(
      title: 'NCW',
      description:
          'The National Commission for Women is the apex national level organisation of India with the mandate of protecting and promoting the interests of women.',
      url: 'https://ncwapps.nic.in/',
      thumbnailUrl: 'assets/images/ncw.jpg',
    ),
    Resource(
      title: 'National Consumer Helpline',
      description:
          'Consumers can reach out to the helpline through a toll-free number, email, or by registering their complaint online through the NCH website.',
      url: 'https://consumerhelpline.gov.in/',
      thumbnailUrl: 'assets/images/consumer.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] 
            : const Color(0xFFAEC6CF),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black, 
            child: const SizedBox(height: 1.0), 
          ),
          const Divider(
              height: 1.0, color: Colors.black), // add black divider line
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black // set color for dark mode
                : const Color(0xFFAEC6CF),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8.0),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                        children: [
                          const TextSpan(text: 'Are you in an '),
                          TextSpan(
                            text: 'Emergency',
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.redAccent
                                  : Colors.red,
                            ),
                          ),
                          const TextSpan(text: ' ?'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => launch('tel:100'),
                          icon: Icon(
                            Icons.local_police_outlined,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          tooltip: 'Call Police',
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Police',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => launch('tel:102'),
                          icon: Icon(
                            Icons.local_hospital_outlined,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          tooltip: 'Call Ambulance',
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Ambulance',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FutureBuilder(
                          future: Permission.location.status,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == PermissionStatus.granted) {
                              return IconButton(
                                onPressed: () async {
                            
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high,
                                  );
                                 
                                  String message =
                                      'I am in an Emergency at: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}&zoom=15&ll=${position.latitude},${position.longitude}&markers=color:blue%7Clabel:S%7C${position.latitude},${position.longitude}';
                                  String encodedMessage =
                                      Uri.encodeComponent(message);
                                  String url = 'sms:?body=$encodedMessage';
                                  launchUrlString(url);
                                },
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                tooltip: 'Share location via SMS',
                              );
                            } else {
                              return IconButton(
                                onPressed: () async {
                                  var status =
                                      await Permission.location.request();
                                  if (status == PermissionStatus.granted) {
                  
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high,
                                    );
                                   
                                    String message =
                                        'I am in an Emergency at: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}&zoom=15&ll=${position.latitude},${position.longitude}&markers=color:blue%7Clabel:S%7C${position.latitude},${position.longitude}';
                                    String encodedMessage =
                                        Uri.encodeComponent(message);
                                    String url = 'sms:?body=$encodedMessage';
                                    launchUrlString(url);
                                  }
                                },
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                tooltip: 'Share location via SMS',
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Location',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.grey[900],
            child: InkWell(
              borderRadius: BorderRadius.circular(16.0),
              onTap: () {
       
                navigateToDigital(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: const Center(
                  child: Text(
                    '👩‍💻 Stay Safe Digitally 👩‍💻',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () => launch(resource.url),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0),
                            ),
                            child: Image.asset(
                              resource.thumbnailUrl,
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resource.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  resource.description,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Resource {
  final String title;
  final String description;
  final String url;
  final String thumbnailUrl; // new property

  Resource({
    required this.title,
    required this.description,
    required this.url,
    required this.thumbnailUrl, // initialize the new property
  });
}
