import 'package:any_link_preview/any_link_preview.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:routemaster/routemaster.dart';
// import 'package:location/location.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:permission_handler/permission_handler.dart';

class ResourceCentrePage extends StatelessWidget {
  ResourceCentrePage({Key? key}) : super(key: key);

  final List<Resource> resources = [
    Resource(
      title: 'Cyber Crime Reporting',
      description:
          'This portal is an initiative of Government of India to facilitate victims/complainants to report cyber crime complaints online.',
      url: 'https://cybercrime.gov.in/',
      thumbnailUrl: 'https://cybercrime.gov.in/images/i4clogo.jpg',
    ),
    Resource(
      title: 'NCW',
      description:
          'The National Commission for Women is the apex national level organisation of India with the mandate of protecting and promoting the interests of women.',
      url: 'https://ncwapps.nic.in/',
      thumbnailUrl:
          'https://vajiramandravi.s3.us-east-1.amazonaws.com/media/2018/12/16/11/56/10/4.jpg',
    ),
    Resource(
      title: 'National Consumer Helpline',
      description:
          'Consumers can reach out to the helpline through a toll-free number, email, or by registering their complaint online through the NCH website. The helpline also provides consumers with information on various consumer-related issues such as product safety, consumer awareness, consumer rights, and the provisions of the Consumer Protection Act, among others.',
      url: 'https://consumerhelpline.gov.in/',
      thumbnailUrl:
          'https://voxya.com/stories/wp-content/uploads/2021/09/national-consumer-helpline-1024x576.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resource Centre',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color(0xFFAEC6CF),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black, // set container color to black
            child: SizedBox(height: 1.0), // add spacing
          ),
          Divider(height: 1.0, color: Colors.black), // add black divider line
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black // set color for dark mode
                : Color(0xFFAEC6CF),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
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
                          TextSpan(text: 'Are you in an '),
                          TextSpan(
                            text: 'Emergency',
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.redAccent
                                  : Colors.red,
                            ),
                          ),
                          TextSpan(text: ' ?'),
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
                                  // Get the user's current location
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high,
                                  );
                                  // Open the SMS app and prefill the message with the user's location
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
                                    // Get the user's current location
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high,
                                    );
                                    // Open the SMS app and prefill the message with the user's location
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
          Expanded(
            child: ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Card(
                    elevation: 2.0,
                    // ignore: sort_child_properties_last
                    child: InkWell(
                      onTap: () => launch(resource.url),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: resource.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              resource.title,
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.purpleAccent,
                                    )
                                  : TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.purpleAccent,
                                    ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              resource.description,
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? TextStyle(
                                      color: Colors.white,
                                    )
                                  : TextStyle(
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900] // set color for dark mode
                        : Color(0xFFAEC6CF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                );
              },
            ),
          ),
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
