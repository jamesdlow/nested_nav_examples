import 'package:flutter/material.dart';
import 'nested_screen.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

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
      home: MyHomePage(drawer: false),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKeys.globalKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool drawer = false;
  MyHomePage({super.key, this.drawer = false});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<NestedScreen> screens = [];
  List<NavigationDestination> menu = [];
  List<GlobalKey<NavigatorState>> keys = [];

  @override
  Widget build(BuildContext context) {
    var global = widget.drawer && Breakpoints.small.isActive(context);
    if (menu.isEmpty) {
      //Even if we do this, it seems to reset the state of the Navigator, but that's ok
      menu = <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        NavigationDestination(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ];
      for (var item in menu) {
        GlobalKey<NavigatorState> key = GlobalKey();
        keys.add(key);
        screens.add(NestedScreen(
          title: item.label ?? '',
          navigatorKey: key,
          global: global
        ));
      }
    }

    var view = AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 900),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 900),
      internalAnimations: false,
      useDrawer: widget.drawer,
      selectedIndex: _selectedIndex,
      onSelectedIndexChange: (int index) {
        if (global) {
          Navigator.pop(context);
        }
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: menu,
      appBar: global ? AppBar(title: Text(menu[_selectedIndex].label)) : null,
      body: (_) {
        return screens[_selectedIndex];
      },

      /*smallBody: (_) => ListView.builder(
        itemCount: children.length,
        itemBuilder: (_, int idx) => children[idx],
      ),*/
      // Define a default secondaryBody.
      //secondaryBody: (_) => Container(
      //  color: const Color.fromARGB(255, 234, 158, 192),
      //),
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      //secondaryBody: AdaptiveScaffold.emptyBuilder,
      //smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
    return view;
  }
}