import 'dart:convert';
import 'package:http/http.dart' as http;

class apiCall {
  static Future<void> makeRequest() async {
    final url = Uri.parse('https://anash-visual-qa.hf.space/run/predict');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'data': [
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==',
          'hello world',
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      print(data);
      print('Request Success with status: ${response.statusCode}.');
      // Do something with data
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
