import 'package:flutter/material.dart';
import 'nested_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKeys.navigatorKeyMain,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NestedScreen> screens = [];
  List<BottomNavigationBarItem> pages = [];
  List<GlobalKey<NavigatorState>> keys = [];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      //Even if we do this, it seems to reset the state of the Navigator, but that's ok
      pages = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ];
      for (var page in pages) {
        GlobalKey<NavigatorState> key = GlobalKey();
        keys.add(key);
        screens.add(NestedScreen(
          title: page.label ?? 'Home',
          navigatorKey: key,
        ));
      }
    }
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: pages,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
