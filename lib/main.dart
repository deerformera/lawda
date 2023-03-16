import 'package:flutter/material.dart';
import 'components/jadwal.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Jadwal()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}