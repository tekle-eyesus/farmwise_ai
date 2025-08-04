import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  final String title;
  final String desc;
  const Features({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 369,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.deepPurple,
              ),
              const SizedBox(
                width: 6,
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  color: Color.fromARGB(255, 31, 17, 56),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                child: SizedBox(
                  // width: 300,
                  child: Text(textAlign: TextAlign.center, title),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 27),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Color.fromARGB(255, 31, 17, 56),
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
              ),
              child: Text(textAlign: TextAlign.start, desc),
            ),
          )
        ],
      ),
    );
  }
}
