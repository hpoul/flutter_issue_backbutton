import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeyboardHandler(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ExampleWidget(),
        // home: TestScaffold(),
      ),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key key, this.index = 0}) : super(key: key);
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
