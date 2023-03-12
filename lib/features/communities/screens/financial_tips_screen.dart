import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FinancialTipsScreen extends StatelessWidget {
  const FinancialTipsScreen({Key? key}) : super(key: key);

  Widget _buildFactItem(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.purpleAccent,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Tips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Financial Tips for Women',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Here are some important financial tips for women to help them stay financially secure and make the most of their money:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- Start saving early and often',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '- Create and stick to a budget',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '- Learn about investing and retirement planning',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '- Protect yourself and your assets with insurance',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Here are some helpful resources to learn more:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permanent Facts',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFactItem(
                      'Women earn 81 cents to every dollar earned by men.',
                      Icons.female,
                    ),
                    SizedBox(height: 8),
                    _buildFactItem(
                      'Women are more likely to live in poverty than men.',
                      Icons.money,
                    ),
                    SizedBox(height: 8),
                    _buildFactItem(
                      'Women generally have less saved for retirement than men.',
                      Icons.account_balance_wallet,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.article),
                title: Text(
                  '5 Simple Money Management Tips for Women',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('From Forbes'),
                onTap: () => launch(
                  'https://www.forbes.com/sites/nancyanderson/2018/03/07/5-simple-money-management-tips-for-women/?sh=4f4d82af7b20',
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.article),
                title: Text(
                  'How to Save Money Fast: 100 Tips',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('From The Simple Dollar'),
                onTap: () => launch(
                  'https://www.thesimpledollar.com/save-money/how-to-save-money-fast/',
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.video_library),
                title: Text(
                  'Money Saving Tips for Women',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('From The Financial Diet on YouTube'),
                onTap: () =>
                    launch('https://www.youtube.com/watch?v=Z3qkT7GDbTc'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
