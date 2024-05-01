import 'package:flutter/material.dart';

class ReviewBox extends StatelessWidget {
  final String comment;
  const ReviewBox({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  '4.0',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              comment,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
