import 'package:flutter/material.dart';

class YogaScreen extends StatelessWidget {
  final List<YogaAsana> yogaAsanas = [
    YogaAsana(
      name: 'Downward-Facing Dog',
      image: 'assets/images/down_dog.jpg',
      description: 'Begin on your hands and knees, with your hands slightly in front of your shoulders. Spread your fingers wide and press firmly through your palms and knuckles. Exhale as you tuck your toes and lift your knees off the floor. Reach your pelvis up toward the ceiling, then draw your sit bones toward the wall behind you. Gently straighten your legs, but do not lock your knees. Bring your body into the shape of an inverted V.',
    ),
    YogaAsana(
      name: 'Tree Pose',
      image: 'assets/images/tree_pose.jpg',
      description: 'Begin standing with your feet together and your arms at your sides. Shift your weight onto your left foot and place the sole of your right foot on your left thigh, keeping your toes pointing downward. Once you are balanced, bring your hands together in front of your chest. Hold the pose for 30 seconds to 1 minute, then release and repeat on the other side.',
    ),
    YogaAsana(
      name: 'Warrior II',
      image: 'assets/images/warrior_2.jpg',
      description: 'Begin in Mountain Pose. Step your left foot back about 3 to 4 feet, making sure your feet are hip-width apart. Turn your left foot out 90 degrees and your right foot in slightly. Bring your hands to your hips and relax your shoulders. Extend your arms out to the sides, then bend your right knee so it is directly above your right ankle. Look over your right hand and hold the pose for 30 seconds to 1 minute. Release and repeat on the other side.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yoga Asanas'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: yogaAsanas.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YogaAsanaDetails(yogaAsana: yogaAsanas[index]),
                ),
              );
            },
            child: Hero(
              tag: yogaAsanas[index].name,
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: Image.asset(
                          yogaAsanas[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        yogaAsanas[index].name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class YogaAsana {
  final String name;
  final String image;
  final String description;

  YogaAsana({
    required this.name,
    required this.image,
    required this.description,
  });
}

class YogaAsanaDetails extends StatelessWidget {
  final YogaAsana yogaAsana;

  YogaAsanaDetails({required this.yogaAsana});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(yogaAsana.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: yogaAsana.name,
              child: Image.asset(
                yogaAsana.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              yogaAsana.description,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}