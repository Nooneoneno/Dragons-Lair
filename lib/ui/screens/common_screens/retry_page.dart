import 'package:flutter/material.dart';

class RetryPage extends StatelessWidget {
  final Function() retryFetching;

  const RetryPage({super.key, required this.retryFetching});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 60,
          ),
          const SizedBox(height: 16),
          const Text(
            'Oops!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Something went wrong while loading the game info.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white12,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Retry',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () => retryFetching()
          ),
        ],
      ),
    );
  }
}
