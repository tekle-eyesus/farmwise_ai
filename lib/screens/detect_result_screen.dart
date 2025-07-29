import 'dart:io';
import 'package:farmwise_ai/data/tomato_disease_data.dart';
import 'package:farmwise_ai/screens/online_video_section.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetectResultScreen extends StatelessWidget {
  final File image;
  final List detectionResult;

  const DetectResultScreen({
    required this.image,
    required this.detectionResult,
  });

  @override
  Widget build(BuildContext context) {
    final result = detectionResult[0]; // assuming top result
    final label = result['label'];
    final confidence = (result['confidence'] * 100).toStringAsFixed(2);
    final DiseaseInfo disease = tomatoDiseases[label]!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detection Result",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // TODO: implement save logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.file(
                    image,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(203, 153, 8, 8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: const Color.fromARGB(255, 241, 168, 168),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: double.parse(confidence) / 100,
                    center: Text(
                      double.parse(confidence) == 100.00
                          ? "${confidence.toString().split(".")[0]}%"
                          : "${result[confidence]}%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: Colors.white,
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color.fromARGB(255, 219, 235, 5),
                    footer: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(157, 174, 175, 175),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                        "confidence",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease.title,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    disease.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Actions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...disease.recommendations.map((Recommendation r) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.green.shade100,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.approval,
                        ),
                        title: Text(
                          r.title,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          r.subtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Resources",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //videos from youtube,
                  const SizedBox(
                    height: 5,
                  ),
                  OnlineVideoSection(label: label),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
