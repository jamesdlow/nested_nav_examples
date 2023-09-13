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
      home: MyHomePage(),
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
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () { _onItemTapped(0); }
        ),
        ListTile(
          leading: Icon(Icons.business),
          title: Text('Business'),
          onTap: () { _onItemTapped(1); }
        ),
        ListTile(
          leading: Icon(Icons.school),
          title: Text('School'),
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
        title: Text('Nested Navigation'),
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