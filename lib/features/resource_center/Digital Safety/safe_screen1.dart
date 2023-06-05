import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CyberCrimeGuideScreen extends StatefulWidget {
  const CyberCrimeGuideScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CyberCrimeGuideScreenState createState() => _CyberCrimeGuideScreenState();
}

class _CyberCrimeGuideScreenState extends State<CyberCrimeGuideScreen> {
  bool _isTipsExpanded = true;
  bool _isAwarenessExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyber Crime Guide'),
        backgroundColor:
            Colors.green, // Set the app bar background color to green
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            buildSection(
              'Safety Tips',
              _isTipsExpanded,
              [
                buildStepCard(
                  context,
                  'Be Vigilant',
                  'Be cautious while sharing personal information online. Avoid sharing sensitive data on unsecured websites or with unknown individuals.',
                  Icons.visibility,
                  'https://www.securityri.com/stay-vigilant/#:~:text=Be%20Aware%20of%20Your%20Surroundings,sure%20to%20look%20around%20often.',
                ),
                buildStepCard(
                  context,
                  'Use Strong Passwords',
                  'Create strong, unique passwords for each online account. Use a combination of letters, numbers, and symbols.',
                  Icons.lock,
                  "https://edu.gcfglobal.org/en/internetsafety/creating-strong-passwords/1/",
                ),
                buildStepCard(
                  context,
                  'Enable Two-Factor Authentication',
                  'Enable two-factor authentication (2FA) for your accounts whenever possible. It provides an extra layer of security.',
                  Icons.verified_user,
                  "https://authy.com/what-is-2fa/",
                ),
                buildStepCard(
                  context,
                  'Update Software Regularly',
                  'Keep your operating system, antivirus software, and other applications up to date to protect against known vulnerabilities.',
                  Icons.system_update_alt,
                  "https://www.techtarget.com/whatis/feature/5-reasons-software-updates-are-important",
                ),
              ],
              () {
                setState(() {
                  _isTipsExpanded = !_isTipsExpanded;
                });
              },
            ),
            const SizedBox(height: 16.0),
            buildSection(
              'Awareness: Identifying Cyber Crime',
              _isAwarenessExpanded,
              [
                buildStepCard(
                  context,
                  'Phishing Scams',
                  'Beware of suspicious emails, text messages, or phone calls asking for personal information or money. Verify the source before providing any sensitive details.',
                  Icons.email,
                  "https://consumer.ftc.gov/articles/how-recognize-and-avoid-phishing-scams",
                ),
                buildStepCard(
                  context,
                  'Fake Websites',
                  'Look out for websites with poor design, unusual URLs, or incorrect branding. Always double-check the website\'s legitimacy before entering any personal information.',
                  Icons.web,
                  "https://nordvpn.com/blog/fake-scam-websites/",
                ),
                buildStepCard(
                  context,
                  'Social Engineering',
                  'Be cautious of individuals or organizations trying to manipulate or deceive you into revealing confidential information or performing actions that may harm you.',
                  Icons.people,
                  "https://www.helpnetsecurity.com/2016/05/19/social-engineer/",
                ),
                buildStepCard(
                  context,
                  'Malware Attacks',
                  'Protect your devices with reliable antivirus software and be cautious when downloading files or clicking on unknown links to avoid malware infections.',
                  Icons.warning,
                  "https://www.cisco.com/c/en/us/products/security/malware-protection-best-practices-detection-prevention.html",
                ),
                buildStepCard(
                  context,
                  'Data Breaches',
                  'Regularly monitor your accounts for any unusual activities. Use unique passwords and consider using a password manager to secure your sensitive information.',
                  Icons.security,
                  "https://www.security.org/identity-theft/what-is-a-data-breach/",
                ),
              ],
              () {
                setState(() {
                  _isAwarenessExpanded = !_isAwarenessExpanded;
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
                color: Colors.green, 
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, 
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        AnimatedCrossFade(
          firstChild: Container(), 
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
                  color: Colors.green,
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
                      color: Colors.green, 
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
                color: Colors.green, // Set the icon color to green
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
                        primary: Colors.green, 
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
