import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScaffold(),
    );
  }
}

class TestScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return KeyboardHandler(
    //   child: ExampleWidget(
    //     index: 0,
    //   ),
    // );
    return KeyboardHandler(
      child: BackButtonNavigatorDelegate(onGenerateRoute: (settings) {
        print('onGenerateRoute $settings');
        return MaterialPageRoute(
            builder: (context) => ExampleWidget(
                  index: 0,
                ));
      }),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $index'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Page $index - Open Next'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ExampleWidget(
                      index: index + 1,
                    )));
          },
        ),
      ),
    );
  }
}

/// Wraps a navigator to send pop signals from the parent navigator to the child navigator.
class BackButtonNavigatorDelegate extends StatefulWidget {
  const BackButtonNavigatorDelegate({
    Key key,
    @required this.onGenerateRoute,
  }) : super(key: key);

  /// Called to generate a route for a given [RouteSettings].
  final RouteFactory onGenerateRoute;

  @override
  _BackButtonNavigatorDelegateState createState() =>
      _BackButtonNavigatorDelegateState();
}

class _BackButtonNavigatorDelegateState
    extends State<BackButtonNavigatorDelegate> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('onWillPop...');
        return !await _navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: widget.onGenerateRoute,
      ),
    );
  }
}

class KeyboardHandler extends StatefulWidget {
  const KeyboardHandler({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _KeyboardHandlerState createState() => _KeyboardHandlerState();
}

class _KeyboardHandlerState extends State<KeyboardHandler> {
  final FocusNode _focusNode = FocusNode(
    debugLabel: 'AuthPassKeyboardFocus',
    onKey: (focusNode, rawKeyEvent) {
//      _logger.info('got onKey: ($focusNode) $rawKeyEvent');
      print('onKey $focusNode, $rawKeyEvent');
      return true;
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (key) {
        print('OnKey $key');
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
