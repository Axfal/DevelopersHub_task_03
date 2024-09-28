// ignore_for_file: avoid_print

import 'package:firebase/api/response_api.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class QuoteProvider with ChangeNotifier {
  QuoteModel? _quote;
  QuoteModel? get quote => _quote;
  
  fetchQuote() async {
    try {
      print('1');
      final fetchedQuote = await Api.getApi();
      print('res : ${quote?.q}');
      _quote = fetchedQuote;
      print('2');
    } catch (e) {
      print("error is here $e");
    }
    notifyListeners();
  }
}
