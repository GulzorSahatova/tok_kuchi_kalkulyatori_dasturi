import 'package:flutter/material.dart';

void main() {
  runApp(const TokKuchiKalkulyatori());
}

class TokKuchiKalkulyatori extends StatelessWidget {
  const TokKuchiKalkulyatori({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tok kuchi kalkulyatori',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TokKuchiHomePage(),
    );
  }
}

class TokKuchiHomePage extends StatefulWidget {
  const TokKuchiHomePage({super.key});

  @override
  State<TokKuchiHomePage> createState() => _TokKuchiHomePageState();
}

class _TokKuchiHomePageState extends State<TokKuchiHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedUnit = 'Amper (A)';
  String _result = '';

  final Map<String, double> _unitValues = {
    'Amper (A)': 1,
    'MilliAmper (mA)': 0.001,
    'KiloAmper (kA)': 1000,
  };

  void _hisobla() {
    double? value = double.tryParse(_controller.text);
    if (value == null) {
      setState(() => _result = 'Iltimos, son kiriting.');
      return;
    }

    double inAmper = value * _unitValues[_selectedUnit]!;
    String natija = '''
${inAmper} A
${inAmper * 1000} mA
${inAmper / 1000} kA
''';

    setState(() => _result = natija);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tok kuchi kalkulyatori'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Qiymatni kiriting:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masalan: 2.5',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              value: _selectedUnit,
              isExpanded: true,
              items: _unitValues.keys.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUnit = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _hisobla,
              child: const Text('Hisoblash'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
