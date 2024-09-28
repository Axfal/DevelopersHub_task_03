// ignore_for_file: prefer_const_constructors

import 'package:firebase/api/quote_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase/api/provider.dart';
import 'package:firebase/widgets/round_button.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<String>? savedQuotes = []; // Store list of saved quotes

  @override
  void initState() {
    super.initState();
    _loadSavedQuotes(); // Load saved quotes when the screen initializes
  }

  // Load saved quotes from SharedPreferences
  Future<void> _loadSavedQuotes() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      savedQuotes = sp.getStringList('Quotes') ?? [];
    });
  }

  // Save a new quote to SharedPreferences
  Future<void> _saveQuote(String newQuote) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    savedQuotes?.add(newQuote); // Add the new quote to the list
    await sp.setStringList('Quotes', savedQuotes ?? []); // Save the list
    setState(() {}); // Refresh the UI to show the new quote
  }

  @override
  Widget build(BuildContext context) {
    QuoteProvider provider = Provider.of<QuoteProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Quotes Screen',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  String newQuote = provider.quote?.q ?? '';
                  if (newQuote.isNotEmpty) {
                    await _saveQuote(newQuote); // Save the new quote
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Quote saved!')),
                    );
                  }
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                )),
            SizedBox(width: 10,)
          ],
        ),
        body: Consumer<QuoteProvider>(
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 5, // The shadow below the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            value.quote?.q ??
                                "Success is not final, failure is not fatal: It is the courage to continue that counts.",
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RoundButton(
                    title: 'Generate',
                    onTap: () {
                      provider.fetchQuote();
                    },
                  ),
                  const SizedBox(height: 5),
                  RoundButton(
                      title: 'Saved Quotes',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuoteDisplayScreen()));
                      }),
                  const SizedBox(height: 20),
                  savedQuotes != null
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: savedQuotes!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                        )
                      : const CircularProgressIndicator(), // Show loading spinner while loading quotes
                ],
              ),
            );
          },
        ));
  }
}
