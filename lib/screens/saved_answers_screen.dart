import 'package:farmwise_ai/utils/date_utils.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class SavedAnswersScreen extends StatefulWidget {
  const SavedAnswersScreen({super.key});
  @override
  State<SavedAnswersScreen> createState() => _SavedResultsScreenState();
}

class _SavedResultsScreenState extends State<SavedAnswersScreen> {
  @override
  Widget build(BuildContext context) {
    final savedEntries = LocalStorageService.getSavedAnswers();

    return Scaffold(
      appBar: AppBar(title: Text('Saved Model Answers')),
      body: ListView.builder(
        itemCount: savedEntries.length,
        itemBuilder: (context, index) {
          final entry = savedEntries[index];
          final key = entry.key;
          final result = entry.value;
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
                result.question,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.modelAnswer,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 3,
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
                  await LocalStorageService.deleteAnswer(key);
                  showCustomSnackBar(context, "Deleted successfully");
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade900,
                ),
              ),
              leading: Icon(
                Icons.bolt,
              ),
              onTap: () {
                showCustomSnackBar(context, "New Screen.");
              },
            ),
          );
        },
      ),
    );
  }
}
