//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';
import 'package:mp5/models/user_model.dart';
import 'package:mp5/screens/user_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedColor = Colors.blue.value; // Default color is blue

// color options list
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
    return Scaffold(
      // register page title
      appBar: AppBar(title: const Text('Register New')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text fireld for user name
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            // test field for password
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            // choice from list of colors
            const SizedBox(height: 16),
            const Text('Choose App Color:'),
            ColorOptions(
              colorOptions: colorOptions,
              selectedColor: selectedColor,
              onColorSelected: (color) {
                setState(() {
                  // hightlight selected
                  selectedColor = color;
                });
              },
            ),
            const SizedBox(height: 16),
            // save details when save button is pressed
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

// register user logic
  void registerUser() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // check if user already exists
      bool userExists = await UserDatabase.isUserExistsAsync(username);

      if (!userExists) {
        // register details if user does nto exist
        User user = User(
            username: username, password: password, appColor: selectedColor);
        await UserDatabase.saveUser(user);

        // return to login screen after registering
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // display error message if user already exists
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'User already exists. Please choose a different username.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}

// color options display
class ColorOptions extends StatelessWidget {
  final List<Color> colorOptions;
  final int selectedColor;
  final Function(int) onColorSelected;

  const ColorOptions({
    super.key,
    required this.colorOptions,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ColorButton(
              // save color selected as hex value
              color: colorOptions[index],
              isSelected: colorOptions[index].value == selectedColor,
              onTap: () {
                onColorSelected(colorOptions[index].value);
              },
            ),
          );
        },
      ),
    );
  }
}

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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          // highlight selected color
          shape: BoxShape.circle,
          color: isSelected ? color.withOpacity(0.7) : color,
          border: isSelected
              ? Border.all(
                  color: Colors.black,
                  width: 3.0,
                )
              : null,
        ),
      ),
    );
  }
}
