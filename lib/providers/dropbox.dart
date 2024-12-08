import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:intl/intl.dart'; // For date formatting

Future<void> uploadToDropbox(Map<String, dynamic> data) async {
  final url = Uri.parse('https://content.dropboxapi.com/2/files/upload');
  const accessToken =
      "sl.u.AFZAlVU_x6u8wHYBlYiu4K_SpgRYchHAmpHkhB0fONlVyBaPdmDZiMMz4JIyna3EFy-OxNmXWeJK-Fr9q4Afv_bwYA0kRQ64G0rmBUKwZpEXy13b3-NY4aSC02J6vpsKwNgXIRP-cgcouqVW6eGpkr1IjEIe41BxrfNgK2i_-4BWVffD7_wlN6uTr9uppRlM6SHZ4eQGmhENHDgHEVuvhuxhIVilJAqnh-d5vdQCBXE3jUYkCE8cjq5v4tK1vVa6Bgn4627-IyUHaDJU01NkYlsPMeWSfVb5TIaHMSXE59D3qs1Bf3gSyJjrXaejSKwkj1DKpHqTfPKdCBNpb1DGj5nIBZ2xOBRpQjKsWdpNFFiTBcw-O03jFiBm2M7kJm9mwRKgsO_CFBlRTwQTn8sNSuuDAhUofY3xcJpSw9aEDejG3fkW-bVvbGIlYbCeycujJOhoIxXIycradJgZGKiymtbP71d9XWy5bHfO6w32qYq7dq8uifFVVS9dcmCSl02zbLmkrJofctT6diujelkMeXcXqb3ZSSJjhMGQA__JNGu6A1lkqgiY_zqwendnVh4v7Qxe5U3Otab9d78pBq22mTDpQK2DzLSFbdV9Jk5TsZ1lf3iV-48eYei-rhXJQpt89nGu1D_I-bfBiVKlPmWkgrkRX07c5gC5HwwT4XXNe3yCtxw74_GGXqlSNy1WMUjpIiAixYvkm1Cht3HhL94ZHhcPGlegYfNN2hBvQdzPNTUvdAQu9h93BXv7z3QPMlVYtpx0xuPpSurc-3w4I6g4hh1sKDwTAT4uCAg47L0n5lqKUU6OUgdKQbr55fn3K-juHhsUo9l1eAzeJ27GhP8SfIgG4t1MPnO3EsJdSVD5PCgnGmOXjGUrhYBgrfE0w3_KbWpR9Cpru8Cql7gTfglNNuvPSU3_go3vdfcyPdL4ucJKman6B7u28EpDtY00RIjsadlV2D8uOQhXKnPP8fER4wawxznPKFi1Q4wD1x1jHiPwNzchek86a5FBiINciDoZtt9pAzXh7bRus8E2K0x7tE38CX4o0Y-prPTwGlBVzKAfSZ21eAc9LpYtKJAxKkc1MC4ZdAxFrT1NXs89Wxb4MxzgAgSZe8LzjyhjK3BvozPJi3Ze8Toytji7K58LgQaaZoAxPRAXEaJORXk_hPGsvaz96sRpCWoKGo5QFFErFGjnLEocQOk7K-LjAcv8iht-_y2hoh4BKY0TbCtasUKTK-7i0pDkxnBc1GkJx-y4A8uqMH7N50I_sVobO223Xk5puirj2ZULd4tH2YhS_dd7O-Weukt2cYJ2S6m2V6uOxgAyyKzWbaGva19OD8UtD1e845s_XEMhewwCtPOgHuVcBgujyp6R3VBexWS5_BXL3M34mFvQg-0AasL75IZuYIfNyTHBqscSEyE75p3SQ93zh9DEiCvold5NJeVXFQiDGM44xg";

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
