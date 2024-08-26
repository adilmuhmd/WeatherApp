import 'package:flutter/material.dart';
final TextEditingController cityController = TextEditingController();
class sample extends StatefulWidget {
  const sample({super.key});

  @override
  State<sample> createState() => _sampleState();
}

class _sampleState extends State<sample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TextFormField(
          controller: cityController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            labelText: 'Enter the city',
          ),
        ),
      ),
    );
  }
}
