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
  final TextEditingController _quvvatController = TextEditingController();
  final TextEditingController _kuchlanishController = TextEditingController();

  double? _tokKuchi;

  void _hisobla() {
    final double? p = double.tryParse(_quvvatController.text);
    final double? u = double.tryParse(_kuchlanishController.text);

    if (p != null && u != null && u != 0) {
      setState(() {
        _tokKuchi = p / u;
      });
    } else {
      setState(() {
        _tokKuchi = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iltimos, to‘g‘ri qiymat kiriting!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tok kuchi kalkulyatori'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _quvvatController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quvvat (W)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _kuchlanishController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kuchlanish (V)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _hisobla,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              ),
              child: const Text('Hisoblash'),
            ),
            const SizedBox(height: 30),
            if (_tokKuchi != null)
              Text(
                'Tok kuchi: ${_tokKuchi!.toStringAsFixed(2)} A',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
