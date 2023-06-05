import 'package:flutter/material.dart';

class FoodTipsScreen extends StatelessWidget {
  const FoodTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      appBar: AppBar(
        title: const Text('Healthy Eating'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            context,
            'Iron-Rich Foods',
            [
              _buildFoodItem(
                context,
                'Spinach',
                'Spinach is a great source of iron and other nutrients.',
                'assets/images/spinach-1296x728-header.webp',
              ),
              _buildFoodItem(
                context,
                'Lentils',
                'Lentils are rich in iron and provide essential protein.',
                'assets/images/lentils.png',
              ),
              _buildFoodItem(
                context,
                'Meat',
                'Meat is a good source of iron for those who consume it.',
                'assets/images/cb.jpg',
              ),
            ],
          ),
          _buildSection(
            context,
            'Stay Hydrated',
            [
              _buildFoodItem(
                context,
                'Drink Water',
                'Drink plenty of water during your menstrual cycle to stay hydrated.',
                'assets/images/water.png',
              ),
              _buildFoodItem(
                context,
                'Herbal Tea',
                'Herbal teas like chamomile and peppermint can help with hydration.',
                'assets/images/tea.png',
              ),
            ],
          ),
          _buildSection(
            context,
            'Omega-3 Fatty Acids',
            [
              _buildFoodItem(
                context,
                'Salmon',
                'Salmon is rich in omega-3 fatty acids and provides various health benefits.',
                'assets/images/something.png',
              ),
              _buildFoodItem(
                context,
                'Chia Seeds',
                'Chia seeds are a plant-based source of omega-3 fatty acids.',
                'assets/images/chinaseeds.png',
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
              image: AssetImage(imageUrl),
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
