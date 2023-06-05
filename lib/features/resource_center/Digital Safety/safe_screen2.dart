import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SexualHarassmentScreen extends StatefulWidget {
  const SexualHarassmentScreen({super.key});

  @override
  _SexualHarassmentScreenState createState() => _SexualHarassmentScreenState();
}

class _SexualHarassmentScreenState extends State<SexualHarassmentScreen> {
  bool _isIdentifyingExpanded = true;
  bool _isReportingExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sexual Harassment Guide'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSection(
              'Identifying Sexual Harassment',
              _isIdentifyingExpanded,
              [
                buildStepCard(
                  context,
                  'Unwanted Messages or Images',
                  'Be aware of unsolicited sexually explicit messages, images, or videos sent without your consent. These can be forms of online sexual harassment.',
                  Icons.message,
                  "https://blog.ipleaders.in/can-someone-sending-unsolicited-dirty-pictures-nudes/",
                ),
                buildStepCard(
                  context,
                  'Cyberstalking',
                  'Take note if someone constantly follows, monitors, or harasses you online. Cyberstalking is a form of online harassment and should be taken seriously.',
                  Icons.visibility,
                  "https://www.kaspersky.co.in/resource-center/threats/how-to-avoid-cyberstalking",
                ),
                buildStepCard(
                  context,
                  'Non-consensual Sharing of Intimate Content',
                  'If someone shares your intimate photos, videos, or private conversations without your consent, it is a violation of your privacy and a form of sexual harassment.',
                  Icons.image,
                  "https://journals.sagepub.com/doi/10.1177/08862605221122834?icid=int.sj-abstract.citing-articles.2007#:~:text=of%20revenge%20porn.-,Nonconsensual%20Image%20Distribution%3A%20Offending%20and%20Victimization,McGlynn%20%26%20Rackley%2C%202016).",
                ),
                buildStepCard(
                  context,
                  'Sexual Harassment Comments or Threats',
                  'Be cautious of any unwanted sexual comments, explicit language, or threats directed towards you online. These are all forms of sexual harassment.',
                  Icons.comment,
                  "https://kidshealth.org/en/teens/harassment.html",
                ),
              ],
              () {
                setState(() {
                  _isIdentifyingExpanded = !_isIdentifyingExpanded;
                });
              },
            ),
            const SizedBox(height: 16.0),
            buildSection(
              'Reporting Sexual Harassment',
              _isReportingExpanded,
              [
                buildStepCard(
                  context,
                  'Document Evidence',
                  'Keep a record of any offensive messages, images, or other evidence of sexual harassment. This documentation can be helpful when reporting the incident.',
                  Icons.camera_alt,
                  "https://www.forensicnotes.com/best-practice-guidelines-for-recording-and-documenting-evidence/",
                ),
                buildStepCard(
                  context,
                  'Report to the Platform',
                  'Use the reporting mechanisms provided by the platform or social media site to report incidents of sexual harassment. They have procedures in place to address such issues.',
                  Icons.flag,
                  "https://poshatwork.com/sexual-harassment-self-destructing-messages-challenges-evidence/",
                ),
                buildStepCard(
                  context,
                  'Contact Authorities',
                  'If the harassment involves serious threats, explicit content involving minors, or poses a significant risk, contact law enforcement agencies to report the incident.',
                  Icons.phone,
                  'https://cybercrime.gov.in/webform/FAQ.aspx',
                ),
                buildStepCard(
                  context,
                  'Seek Support',
                  'Reach out to trusted friends, family members, or support organizations who can provide emotional support and guidance on dealing with the situation.',
                  Icons.people,
                  "https://support.google.com/youtube/answer/2802268?hl=en",
                ),
              ],
              () {
                setState(() {
                  _isReportingExpanded = !_isReportingExpanded;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
      String title, bool isExpanded, List<Widget> steps, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.deepOrange,
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        AnimatedCrossFade(
          firstChild: Container(), // Placeholder for collapsed state
          secondChild: Column(children: steps),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget buildStepCard(BuildContext context, String title, String description,
      IconData icon, String? link) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              content: Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.deepOrange,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (link != null) const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () => launch(link!),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                      ),
                      child: const Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
