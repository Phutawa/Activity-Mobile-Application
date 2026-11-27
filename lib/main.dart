import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phutawan World',
      theme: ThemeData(
        fontFamily: 'maa',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 107, 156, 146),
        ),
      ),
      home: const MyHomePage(title: 'Phutawan Shop'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController price = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController received = TextEditingController();
  final TextEditingController change = TextEditingController();

  double _total = 0;
  double _change = 0;

  @override
  void dispose() {
    price.dispose();
    amount.dispose();
    received.dispose();
    change.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(
                "Hello Flutter",
                style: TextStyle(
                  fontFamily: 'maa',
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = const Color.fromARGB(255, 250, 186, 112)
                    ..style = PaintingStyle.fill,
                ),
              ),
              priceTextField(),
              amountTextField(),
              calculateButton(),
              showTotalText(),
              receiveMoneyTextField(),
              calculateChangeButton(),
              showChangeText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceTextField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: price,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'price per item',
        ),
      ),
    );
  }

  Widget amountTextField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: amount,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'amount of items',
        ),
      ),
    );
  }

  Widget receiveMoneyTextField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: received,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'get money',
        ),
      ),
    );
  }

  Widget changeTextField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: change,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Change',
        ),
      ),
    );
  }

  Widget calculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          final itemPrice = double.tryParse(price.text);
          final itemAmount = double.tryParse(amount.text);

          if (itemPrice == null || itemAmount == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter valid numbers')),
            );
            return;
          }

          setState(() {
            _total = itemPrice * itemAmount;
            _change = 0;
            change.text = '0';
          });
        },
        child: const Text('Calculate Total'),
      ),
    );
  }

  Widget calculateChangeButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: _calculateChange,
        child: const Text('Calculate Change'),
      ),
    );
  }

  Widget showTotalText() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('total : ${_total.toStringAsFixed(1)} Baht'),
    );
  }

  Widget showChangeText() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('Change : ${_change.toStringAsFixed(1)} Baht'),
    );
  }

  void _calculateChange() {
    final receivedAmount = double.tryParse(received.text);
    if (receivedAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter received money')),
      );
      return;
    }

    if (receivedAmount < _total) {
      setState(() {
        _change = 0;
        change.text = '0';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('money is not enough')));
      return;
    }

    setState(() {
      _change = receivedAmount - _total;
      change.text = _change.toStringAsFixed(1);
    });
  }
}
