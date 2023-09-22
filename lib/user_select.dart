import 'package:flutter/material.dart';

class UserSelectScreen extends StatelessWidget {
  const UserSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              ElevatedButton(
                onPressed: () {

                },
                child: const Text('민찬'),
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: const Text('민기'),
              ),
            ],
          ),
        )
    );
  }
}
