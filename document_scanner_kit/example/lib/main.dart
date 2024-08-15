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
  List<String> _scannedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DocumentScannerKit Example')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: _scannedImages.isEmpty
                  ? const Center(child: Text('No images to display'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: _scannedImages.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(_scannedImages[index]),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (!context.mounted) return;
                  try {
                    final result = await scan();
                    if (result != null) {
                      setState(() {
                        _scannedImages.addAll(result);
                      });
                    }
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
                child: Text('Scan Document'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
