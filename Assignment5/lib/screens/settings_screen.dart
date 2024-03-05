//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';

// change settings of app
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // new color selected?
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // settings page title
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          // message to choose different app color
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose Your App Display Color:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          // give user 10 options to select theme color from
          ColorOptions(
            onColorSelected: (color) {
              setState(() {
                // highlight selected color
                selectedColor = color;
              });
            },
            selectedColor: selectedColor,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // delete old app color and replace when clicked on save button
              Navigator.pop(context, selectedColor);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// color options user can choose from
class ColorOptions extends StatelessWidget {
  final Function(Color) onColorSelected;
  final Color? selectedColor;

  ColorOptions({
    super.key,
    required this.onColorSelected,
    required this.selectedColor,
  });

  final List<Color> colorOptions = [
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.lightGreen,
    Colors.brown,
    Colors.lightBlue,
    Colors.red,
    Colors.orange,
    Colors.pink,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorOptions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColorButton(
                // color options - highlight which is selected
                color: colorOptions[index],
                isSelected: colorOptions[index] == selectedColor,
                onTap: () {
                  onColorSelected(colorOptions[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// display color options as buttons
class ColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // highlight selected color
          color: isSelected ? color.withOpacity(0.7) : color,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
