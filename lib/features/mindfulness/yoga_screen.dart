import 'package:flutter/material.dart';

class YogaScreen extends StatelessWidget {
  final List<YogaAsana> yogaAsanas = [
    YogaAsana(
      name: 'Adho Mukha Svanasana',
      sanskritName: 'अधोमुखश्वानासन',
      image: 'assets/images/down_dog.jpg',
      description: 'Begin on your hands and knees, with your hands slightly in front of your shoulders. Spread your fingers wide and press firmly through your palms and knuckles. Exhale as you tuck your toes and lift your knees off the floor. Reach your pelvis up toward the ceiling, then draw your sit bones toward the wall behind you. Gently straighten your legs, but do not lock your knees. Bring your body into the shape of an inverted V.',
    ),
    YogaAsana(
      name: 'Vrikshasana',
      sanskritName: 'वृक्षासन',
      image: 'assets/images/tree_pose.jpg',
      description: 'Begin standing with your feet together and your arms at your sides. Shift your weight onto your left foot and place the sole of your right foot on your left thigh, keeping your toes pointing downward. Once you are balanced, bring your hands together in front of your chest. Hold the pose for 30 seconds to 1 minute, then release and repeat on the other side.',
    ),
    YogaAsana(
      name: 'Virabhadrasana II',
      sanskritName: 'वीरभद्रासन II',
      image: 'assets/images/warrior_2.jpg',
      description: 'Begin in Mountain Pose. Step your left foot back about 3 to 4 feet, making sure your feet are hip-width apart. Turn your left foot out 90 degrees and your right foot in slightly. Bring your hands to your hips and relax your shoulders. Extend your arms out to the sides, then bend your right knee so it is directly above your right ankle. Look over your right hand and hold the pose for 30 seconds to 1 minute. Release and repeat on the other side.',
    ),
    YogaAsana(
      name: 'Trikonasana',
      sanskritName: 'त्रिकोणासन',
      image: 'assets/images/triangle_pose.jpg',
      description: 'Stand with your feet apart and extend your arms out to the sides, parallel to the floor. Turn your right foot out 90 degrees and your left foot in slightly. Reach your right hand forward and tilt your torso to the right, placing your right hand on your shin or ankle. Extend your left arm up toward the ceiling and look up at your left hand. Hold the pose for 30 seconds to 1 minute, then release and repeat on the other side.',
    ),
    YogaAsana(
      name: 'Balasana',
      sanskritName: 'बालासन',
      image: 'assets/images/child_pose.jpg',
      description: 'Begin on your hands and knees, with your hands slightly in front of your shoulders and your knees under your hips. Lower your hips back toward your heels and stretch your arms out in front of you. Rest your forehead on the floor and hold the pose for 30 seconds to 1 minute.',
    ),
    YogaAsana(
      name: 'Bhujangasana',
      sanskritName: 'भुजंगासन',
      image: 'assets/images/cobra_pose.jpg',
      description: 'Lie on your stomach with your hands under your shoulders, palms down. Press through your hands and lift your chest up off the floor, keeping your elbows close to your sides. Look up toward the ceiling and hold the pose for 30 seconds to 1 minute.',
    ),
    YogaAsana(
      name: 'Sukhasana',
      sanskritName: 'सुखासन',
      image: 'assets/images/easy_pose.jpg',
      description: 'Sit on the floor with your legs crossed and your hands on your knees. Keep your spine straight and your head aligned with your spine. Close your eyes and breathe deeply for 30 seconds to 1 minute.',
    ),
    YogaAsana(
      name: 'Sukhasana',
      sanskritName: 'सुखासन',
      image: 'assets/images/easy_pose.jpg',
      description: 'Sit on the floor with your legs crossed and your hands on your knees. Keep your spine straight and your head aligned with your spine. Close your eyes and breathe deeply for 30 seconds to 1 minute.',
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
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${yogaAsanas[index].name} (${yogaAsanas[index].sanskritName})',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8.0),
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
  final String sanskritName;
  final String image;
  final String description;

  YogaAsana({
    required this.name,
    required this.sanskritName,
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
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              yogaAsana.sanskritName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              yogaAsana.description,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}