import 'package:flutter/material.dart';

class Sameh extends StatelessWidget {
  const Sameh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Sameh', style: TextStyle(fontSize: 50)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Sameh', style: TextStyle(fontSize: 50)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Sameh', style: TextStyle(fontSize: 50)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Sameh', style: TextStyle(fontSize: 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
