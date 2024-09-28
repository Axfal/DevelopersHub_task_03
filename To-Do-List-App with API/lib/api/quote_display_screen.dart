// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteDisplayScreen extends StatefulWidget {
  const QuoteDisplayScreen({Key? key}) : super(key: key);

  @override
  _QuoteDisplayScreenState createState() => _QuoteDisplayScreenState();
}

class _QuoteDisplayScreenState extends State<QuoteDisplayScreen> {
  List<String>? savedQuotes;

  @override
  void initState() {
    super.initState();
    _loadSavedQuotes(); // Load saved quotes when the screen initializes
  }

  // Load saved quotes from SharedPreferences
  Future<void> _loadSavedQuotes() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      savedQuotes = sp.getStringList('Quotes') ?? ['No saved quotes found'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Quotes',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Color to match the theme
      ),
      body: savedQuotes == null
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: savedQuotes!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        savedQuotes![index],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
