import 'package:any_link_preview/any_link_preview.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

class ResourceCentrePage extends StatelessWidget {
  ResourceCentrePage({Key? key}) : super(key: key);

  final List<Resource> resources = [
    Resource(
      title: 'National Domestic Violence Hotline',
      description:
          'The National Domestic Violence Hotline provides essential tools and support to help survivors of domestic violence so they can live their lives free of abuse.',
      url: 'https://www.thehotline.org/',
      thumbnailUrl:
          'https://teamattorneylex.files.wordpress.com/2021/11/feminism.png',
    ),
    Resource(
      title: 'Planned Parenthood',
      description:
          'Planned Parenthood provides sexual and reproductive health care, education, and advocacy. Their services include birth control, pregnancy testing and counseling, and STD testing and treatment.',
      url: 'https://www.plannedparenthood.org/',
      thumbnailUrl:
          'https://www.thoughtco.com/thmb/s7rGF00TNhgElbc5JfL3TSA13qw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-174007370-58b886035f9b58af5c2a32d6.jpg',
    ),
    Resource(
      title: 'RAINN (Rape, Abuse & Incest National Network)',
      description:
          'RAINN is the nation’s largest anti-sexual violence organization. They provide counseling and support for victims of sexual assault and abuse, and work to prevent sexual violence.',
      url: 'https://www.rainn.org/',
      thumbnailUrl: 'https://www.epw.in/system/files/sm-feminismDK.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // define the behavior when the back button is pressed
        // in this case, we just pop the current screen to go back to the previous screen
        Navigator.of(context).pop();
        return false; // return false to prevent the app from exiting
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resource Centre'),
        ),
        body: ListView.builder(
          itemCount: resources.length,
          itemBuilder: (context, index) {
            final resource = resources[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                          height: 100,
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          resource.description,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900] // set color for dark mode
                    : Color(0xFFffe9ec),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            );
          },
        ),
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
