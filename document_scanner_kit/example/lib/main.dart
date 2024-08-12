import 'dart:io';

import 'package:document_scanner_kit/document_scanner_kit.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String>? _scannedImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DocumentScannerKit Example')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_scannedImages == null)
                const SizedBox.shrink()
              else
                Column(
                  children: [
                    for (final path in _scannedImages!) Image.file(File(path)),
                  ],
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    if (!context.mounted) return;
                    try {
                      final result = await scan();
                      setState(() => _scannedImages = result);
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text('$error'),
                        ),
                      );
                    }
                  },
                  child: const Text('Scan Document')),
            ],
          ),
        ),
      ),
    );
  }
}
