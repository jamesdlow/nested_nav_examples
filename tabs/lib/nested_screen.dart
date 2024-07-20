import 'package:flutter/material.dart';

//https://techblog.geekyants.com/nested-navigation-in-flutter-navigator-widget

class NavigatorKeys {
  static final GlobalKey<NavigatorState> globalKey = GlobalKey();
}

class NestedScreen extends StatelessWidget {
  static const String ROOT = '/';
  //final GlobalKey<NavigatorState> topKey = GlobalKey();
  final GlobalKey<NavigatorState> navigatorKey;
  final String title;
  final bool global;
  NestedScreen({super.key, required this.navigatorKey, this.title = '', this.global = false});

  void _push(BuildContext context, String name) {
    //navigatorKey.currentContext
    BuildContext open = (global ? NavigatorKeys.globalKey.currentContext : context) ?? context;
    Navigator.of(open).push(
      MaterialPageRoute(
        builder: (open) {
          return page(context: open, name: name, backbutton: true);
        }
      ),
    );
  }

  /*Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      '/': (context) => home(context)
    };
  }*/

  @override
  Widget build(BuildContext context) {
    //var routeBuilders = _routeBuilders(context);
    /*var routeBuilders = {
      '/': (context) => home(context)
    };*/

    return Scaffold(
      //appBar: global ? AppBar(title: Text(title)) : null,
      body: Navigator(
        key: navigatorKey,
        initialRoute: ROOT,
        /// Starting route from the onGenerateRoute map
        onGenerateRoute: (routeSettings) {
          /// Generate the route we want
          return MaterialPageRoute(
              //builder: (context) => routeBuilders[routeSettings.name]?.call(context) ?? Container()
              builder: home
            );
        },
      ),
    );
  }

  Widget page({required BuildContext context, required String name, bool backbutton = false, bool appbar = true}) {
    var child = name + ' → Child';
    return Scaffold(
      appBar: appbar ? AppBar(
        title: Text(name),
        leading: backbutton ? IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.keyboard_arrow_left_outlined),
        ) : null
      ) : null,
      body: Center(
        child: GestureDetector(
          onTap: () => _push(context, child),
          child: Text(child, style: TextStyle(fontSize: 50))
        )
      )
    );
  }

  Widget home(BuildContext context) {
    return page(context: context, name: title, appbar: !global);
  }
}
