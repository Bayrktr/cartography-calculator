import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordButtonWidget extends StatefulWidget {
  const RecordButtonWidget({super.key, this.onResult});

  final void Function(String)? onResult;

  @override
  State<RecordButtonWidget> createState() => _RecordButtonWidgetState();
}

class _RecordButtonWidgetState extends State<RecordButtonWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _finalText = '';

  bool available = false;


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    available = await _speech.initialize();
  }

  void _checkSupportedLocales() async {
    var locales = await _speech.locales();
    for (var locale in locales) {
      print('Desteklenen dil: ${locale.name} - ${locale.localeId}');
    }
  }

  void _startListening() async {
    if (available) {
      setState(() {
        _isListening = true;
        _finalText = '';
      });

      unawaited(
        _speech.listen(
          localeId: 'tr-TR',
          onResult: (val) {
            setState(() {
              _finalText = val.recognizedWords;
            });
          },
        ),
      );
    } else {
      setState(() => _isListening = false);
      unawaited(_speech.stop());
    }
  }

  void _stopListening() async {
    unawaited(_speech.stop());
    setState(() => _isListening = false);

    if (_finalText.trim().isNotEmpty) {
      widget.onResult?.call(_finalText);
    }
  }

  @override
  Widget build(BuildContext context) {
    //_checkSupportedLocales();
    return FloatingActionButton(
      onPressed: () {
        _isListening ? _stopListening() : _startListening();
      },
      backgroundColor: _isListening ? Colors.red : Colors.blue,
      child: Icon(_isListening ? Icons.stop : Icons.mic),
    );
  }
}
