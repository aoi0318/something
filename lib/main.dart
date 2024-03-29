import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('テスト')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(100),
          child: MyContent(),
        ),
      ),
    );
  }
}

class MyContent extends StatelessWidget {
  const MyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        NFCStatusChecker(),
        SizedBox(height: 20), // 余白を追加
        RadioExample(),
      ],
    );
  }
}

class NFCStatusChecker extends StatefulWidget {
  const NFCStatusChecker({super.key});

  @override
  State<NFCStatusChecker> createState() => _NFCStatusCheckerState();
}

class _NFCStatusCheckerState extends State<NFCStatusChecker> {
  String _nfcStatus = 'Checking NFC availability...';

  @override
  void initState() {
    super.initState();
    _checkNFC();
  }

  Future<void> _checkNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    setState(() {
      _nfcStatus = isAvailable ? 'NFC is available' : 'NFC is not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_nfcStatus),
        ElevatedButton(
          onPressed: _checkNFC,
          child: const Text('Check NFC Availability'),
        ),
      ],
    );
  }
}

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  StateList _state = StateList.clockIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: StateList.values.map((state) {
        return RadioListTile<StateList>(
          title: Text(describeEnum(state)),
          value: state,
          groupValue: _state,
          onChanged: (value) => setState(() => _state = value!),
        );
      }).toList(),
    );
  }

  String describeEnum(StateList state) {
    switch (state) {
      case StateList.clockIn:
        return '出勤';
      case StateList.clockOut:
        return '退勤';
      case StateList.startBreak:
        return '休憩開始';
      case StateList.endBreak:
        return '休憩終了';
      default:
        return '';
    }
  }
}

enum StateList { clockIn, clockOut, startBreak, endBreak }
