import 'package:flutter/material.dart';

class StressTipsScreen extends StatelessWidget {
  const StressTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Stress Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context,
            'Deep breathing',
            [
              _buildFoodItem(
                context,
                'Belly Breathing',
                'Belly breathing is a relaxation technique that involves taking deep breaths and focusing on expanding your belly while inhaling and contracting it while exhaling.',
                'assets/images/yogapsoe.png',
              ),
              _buildFoodItem(
                context,
                '4-7-8 Breathing',
                '4-7-8 breathing technique involves inhaling for 4 counts, holding the breath for 7 counts, and exhaling for 8 counts. Repeat this pattern several times to promote relaxation.',
                'assets/images/breathe.png',
              ),
            ],
          ),
          _buildSection(
            context,
            'Meditation',
            [
              _buildFoodItem(
                context,
                'Mindfulness Meditation',
                'Mindfulness meditation involves focusing your attention on the present moment and accepting it without judgment. It helps reduce stress and promotes overall well-being.',
                'assets/images/namaste.png',
              ),
              _buildFoodItem(
                context,
                'Guided Visualization',
                'Guided visualization is a technique that involves imagining yourself in a peaceful and relaxing environment, which helps in reducing stress and anxiety.',
                'assets/images/soethiingpose.png',
              ),
            ],
          ),
          _buildSection(
            context,
            'Quality Sleep',
            [
              _buildFoodItem(
                context,
                'Sleep Hygiene',
                'Maintaining a regular sleep schedule, creating a comfortable sleep environment, and practicing relaxation techniques before bed can improve the quality of sleep and reduce stress.',
                'assets/images/sleep.png',
              ),
              _buildFoodItem(
                context,
                'Limiting Caffeine',
                'Reducing or avoiding caffeine intake, especially close to bedtime, can help promote better sleep and minimize restlessness.',
                'assets/images/coffee.png',
              ),
            ],
          ),
        ],
      ),

    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> foodItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey[900],
          ),
          child: Column(
            children: foodItems,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodItem(
    BuildContext context,
    String name,
    String description,
    String imageUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          _showDetailsDialog(context, name, description, imageUrl);
        },
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image:AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDetailsDialog(
    BuildContext context,
    String name,
    String description,
    String imageUrl,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      imageUrl,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
