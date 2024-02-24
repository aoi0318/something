import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('テスト')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<bool>(
                  future: NfcManager.instance.isAvailable(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('NFCstate: ${snapshot.data}');
                    }
                  },
                ),
                const SizedBox(height: 20), // 余白を追加
                RadioExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum StateList { clockIn, clockOut, startBreak, endBreak }

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  StateList _state = StateList.clockIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile(
          title: const Text('出勤'),
          value: StateList.clockIn,
          groupValue: _state,
          onChanged: (value) {
            setState(() {
              _state = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('退勤'),
          value: StateList.clockOut,
          groupValue: _state,
          onChanged: (value) {
            setState(() {
              _state = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('休憩開始'),
          value: StateList.startBreak,
          groupValue: _state,
          onChanged: (value) {
            setState(() {
              _state = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('休憩終了'),
          value: StateList.endBreak,
          groupValue: _state,
          onChanged: (value) {
            setState(() {
              _state = value!;
            });
          },
        ),
      ],
    );
  }
}
