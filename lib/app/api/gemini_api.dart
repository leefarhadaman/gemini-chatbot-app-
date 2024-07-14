import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String apiKey =
      'AIzaSyBAPXlZiWVC-pVzXCYMv4hTF6-KPf3dgVw'; // Replace with your actual API key

  Future<String> generateResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"prompt": prompt}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Log the entire response

      // Adjust parsing logic based on actual response structure
      if (data != null &&
          data['contents'] != null &&
          data['contents'].isNotEmpty) {
        final contents = data['contents'];
        final parts = contents[0]['parts'];
        if (parts != null && parts.isNotEmpty) {
          return parts[0]['text'];
        } else {
          throw Exception('API returned empty parts');
        }
      } else {
        throw Exception('API returned empty contents');
      }
    } else {
      print('API Response: ${response.body}');
      throw Exception(
          'Failed to generate content: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
