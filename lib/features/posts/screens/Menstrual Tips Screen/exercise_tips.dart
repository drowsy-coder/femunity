import 'package:flutter/material.dart';

class ExerciseTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Fitness Exercises'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context,
            'Low-Impact Cardio',
            [
              _buildFoodItem(
                context,
                'Walking',
                'Walking is a low-impact cardio exercise that helps improve blood circulation and reduces menstrual cramps.',
                'https://imgur.com/H5NsZEq.jpg',
              ),
              _buildFoodItem(
                context,
                'Cycling',
                'Cycling is another low-impact exercise that helps boost energy levels and reduces bloating during menstruation.',
                'https://imgur.com/ywXM5WW.jpg',
              ),
            ],
          ),
          _buildSection(
            context,
            'Strength Training',
            [
              _buildFoodItem(
                context,
                'Bodyweight Exercises',
                'Performing bodyweight exercises like squats, lunges, and push-ups helps build strength without putting excessive strain on the body.',
                'https://imgur.com/oDfVals.jpg',
              ),
              _buildFoodItem(
                context,
                'Lightweight Training',
                'Using lightweights or resistance bands can be effective in building muscle tone and improving overall strength during menstruation.',
                'https://imgur.com/o1b9w3D.jpg',
              ),
            ],
          ),
          _buildSection(
            context,
            'Yoga',
            [
              _buildFoodItem(
                context,
                'Child\'s Pose',
                'Child\'s Pose helps relax the body, relieve lower back pain, and reduce menstrual discomfort.',
                'https://imgur.com/15uhqlL.jpg',
              ),
              _buildFoodItem(
                context,
                'Cat-Cow Pose',
                'Cat-Cow Pose helps stretch the spine and alleviate menstrual cramps and lower back pain.',
                'https://imgur.com/4E8DiPM.jpg',
              ),
              _buildFoodItem(
                context,
                'Bridge Pose',
                'Bridge Pose helps strengthen the pelvic muscles and improves blood circulation in the pelvic region.',
                'https://imgur.com/BAcYiKa.jpg',
              ),
            ],
          ),
          // Add more sections as needed
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
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
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
      padding: EdgeInsets.symmetric(vertical: 8.0),
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
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // subtitle: Text(
        //   description,
        //   style: TextStyle(
        //     fontSize: 14.0,
        //     color: Colors.white,
        //   ),
        // ),
        trailing: Icon(
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
          insetPadding: EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      imageUrl,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
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
                  icon: Icon(Icons.close),
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
