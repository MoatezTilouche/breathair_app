import 'dart:async';
import 'package:breathair_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

class BlowGamePage extends StatefulWidget {
  @override
  _BlowGamePageState createState() => _BlowGamePageState();
}

class _BlowGamePageState extends State<BlowGamePage> {
  late NoiseMeter _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  bool _isRecording = false;
  List<bool> _candlesLit = [true, true, true, true, true];
  int _timeLeft = 30;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter();
    _startGame();
  }

  void _startGame() {
    _startListening();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft <= 0) {
        _stopListening();
        timer.cancel();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _startListening() async {
    if (_isRecording) return;

    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(_onData);
      setState(() => _isRecording = true);
    } catch (err) {
      print("Error starting microphone: $err");
    }
  }

  void _stopListening() {
    _noiseSubscription?.cancel();
    _noiseSubscription = null;
    setState(() => _isRecording = false);
  }

  void _onData(NoiseReading noiseReading) {
    double decibel = noiseReading.meanDecibel;

    // If sound is above a threshold, consider it a "blow"
    if (decibel > 60) {
      setState(() {
        for (int i = 0; i < _candlesLit.length; i++) {
          if (_candlesLit[i]) {
            _candlesLit[i] = false;
            break;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  Widget _buildCandle(bool isLit) {
    return Column(
      children: [
        Icon(
          Icons.local_fire_department,
          color: isLit ? Colors.orange : Colors.grey,
          size: 50,
        ),
        Container(width: 10, height: 40, color: Colors.brown),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blow the Candles')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _candlesLit.map((isLit) => _buildCandle(isLit)).toList(),
            ),
            const SizedBox(height: 20),
            Text('Time left: $_timeLeft s'),
            const SizedBox(height: 20),
           ElevatedButton(
  onPressed: () {
    _stopListening();  // Call your existing method
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),  // Replace with your Home page widget
    );
  },
  child: Text('Stop Game'),
),

          ],
        ),
      ),
    );
  }
}
