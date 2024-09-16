import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onTap;

  SearchBarWidget({
    required this.controller,
    required this.onChanged,
    required this.onTap,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }

  Future<void> _checkPermissionsAndStartListening() async {
    var status = await Permission.microphone.status;

    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission to access the microphone is required')),
        );
        return;
      }
    }

    _startListening();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(onResult: (result) {
          widget.controller.text = result.recognizedWords;
          widget.onChanged(result.recognizedWords);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error has occurred during speech recognition')),
        );
      }
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045,
              ),
              decoration: InputDecoration(
                hintText: 'Search games...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white54),
              ),
              onChanged: widget.onChanged,
              onTap: widget.onTap,
            ),
          ),
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
            onPressed: _isListening ? _stopListening : _checkPermissionsAndStartListening,
          ),
        ],
      ),
    );
  }
}
