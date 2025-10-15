import 'dart:io';
import 'package:farmwise_ai/data/disease_dummy_data.dart';
import 'package:farmwise_ai/utils/date_utils.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import 'detect_result_screen.dart';

class SavedResultsScreen extends StatefulWidget {
  @override
  State<SavedResultsScreen> createState() => _SavedResultsScreenState();
}

class _SavedResultsScreenState extends State<SavedResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final savedEntries = LocalStorageService.getSavedResults();

    return Scaffold(
      appBar: AppBar(title: Text('Saved Detection Results')),
      body: ListView.builder(
        itemCount: savedEntries.length,
        itemBuilder: (context, index) {
          final entry = savedEntries[index];
          final key = entry.key;
          final result = entry.value;

          final Map<String, DiseaseInfo>? cropMap =
              cropDiseases[result.cropName.toLowerCase()];
          final DiseaseInfo? disease =
              cropMap?[result.detectionResult[0]["label"]];
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color.fromARGB(132, 200, 230, 201),
            ),
            child: ListTile(
              title: Text(
                disease!.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    DateUtilsHelper.formatReadable(result.savedAt),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.red.shade100,
                  ),
                ),
                onPressed: () async {
                  await LocalStorageService.deleteResult(key);
                  CustomSnackBar.showSuccess(context, "Deleted successfully");
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade900,
                ),
              ),
              leading: Image.asset(
                "assets/icons/${result.cropName.toLowerCase()}.png",
                width: 36,
                height: 36,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetectResultScreen(
                      cropName: result.cropName,
                      image: File(result.imagePath),
                      detectionResult: result.detectionResult,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
