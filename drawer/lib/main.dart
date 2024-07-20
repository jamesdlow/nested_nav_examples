import 'package:flutter/material.dart';
import 'nested_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<NestedScreen> screens = [];
  List<ListTile> menu = [];
  List<GlobalKey<NavigatorState>> keys = [];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (menu.isEmpty) {
      //Even if we do this, it seems to reset the state of the Navigator, but that's ok
      menu = <ListTile>[
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () { _onItemTapped(0); }
        ),
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Business'),
          onTap: () { _onItemTapped(1); }
        ),
        ListTile(
          leading: const Icon(Icons.school),
          title: const Text('School'),
          onTap: () { _onItemTapped(2); }
        )
      ];
      for (var item in menu) {
        GlobalKey<NavigatorState> key = GlobalKey();
        keys.add(key);
        screens.add(NestedScreen(
          title: (item.title as Text).data ?? '',
          navigatorKey: key,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Navigation'),
      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: menu
          )
      ),
      body: screens[_selectedIndex]
    );
  }
}