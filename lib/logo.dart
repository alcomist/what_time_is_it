import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('지금 몇시지?'),
            const SizedBox(height: 30,),
            ClipOval(
              child: Image.asset('assets/logo.jpg', width: 300),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
              child: const Text('시작'),
            ),
          ],
        ),
      )
    );
  }
}
