import 'package:flutter/material.dart';

import '/widgets/my_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My custom widget'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            //* Implementing my widget
            child: MyWidget(
              onChange: (i) {
                if (_index != i) {
                  setState(() {
                    _index = i;
                  });
                }
              },
              index: _index,
              children: const [
                'Користувач',
                'Адміністратор',
                'Працівник',
                'Ilya',
                'Власник',
              ],
            ),
          ),
        ),
      ),
    );
  }
}
