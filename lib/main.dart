import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontFamily: 'Shabnam', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText2: defaultTextStyle, 
                caption: defaultTextStyle.apply(
                    color: LightThemeColors.secondaryTextColor),
                headline6:
                    defaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
            colorScheme: const ColorScheme.light(
                primary: LightThemeColors.primaryColor,
                secondary: LightThemeColors.secondaryColor,
                onSecondary: Colors.white)),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: MyHomePage(title: 'فروشگاه نایک'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'لطفا دکمه پلاس را بفشارید',
            ),
            Text(
              'لطفا دکمه پلاس را بفشارید',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
