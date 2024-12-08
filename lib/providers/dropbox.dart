import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:intl/intl.dart'; // For date formatting

Future<void> uploadToDropbox(Map<String, dynamic> data) async {
  final url = Uri.parse('https://content.dropboxapi.com/2/files/upload');
  const accessToken = " accessToken"; // Replace with your token
  // Generate a unique file name based on the current date and time
  final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  final fileName = 'patient_data_$timestamp.json';

  // Define headers for Dropbox API
  final headers = {
    'Authorization': 'Bearer $accessToken', // Replace with your token
    'Dropbox-API-Arg': jsonEncode({
      'path': '/$fileName', // Path in Dropbox
      'mode': 'add', // Create new file or rename if exists
      'autorename':
          true, // Automatically rename if a file with the same name exists
      'mute': false,
    }),
    'Content-Type': 'application/octet-stream',
  };

  // Convert data to JSON string
  final body = utf8.encode(jsonEncode(data));

  try {
    // Send the POST request
    final response = await http.post(url, headers: headers, body: body);

    // Check the response status
    if (response.statusCode == 200) {
      print('File uploaded to Dropbox successfully!');
    } else {
      print('Error uploading to Dropbox: ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
