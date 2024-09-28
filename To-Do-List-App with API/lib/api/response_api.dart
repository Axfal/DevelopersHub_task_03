// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class Api {
  static Future<QuoteModel> getApi() async {
    final response =
        await http.get(Uri.parse("https://zenquotes.io/api/random"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response body: ${response.body}'); // Log the response body

      if (data is List && data.isNotEmpty) {
        print("API fetched successfully");
        return QuoteModel.fromJson(data[0]);
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Failed to fetch API: Status code ${response.statusCode}');
    }
  }
}
