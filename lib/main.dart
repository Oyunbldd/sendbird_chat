import 'package:flutter/material.dart';
import 'package:sendbird_flutter_dashchat/channel_list_view.dart';
import 'package:sendbird_flutter_dashchat/create_channel_view.dart';
import 'package:sendbird_flutter_dashchat/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/login",
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginView(),
        '/channel_list': (context) => ChannelListView(),
        '/create_channel': (context) => CreateChannelView(),
      },
      theme: ThemeData(
        fontFamily: "Gellix",
        primaryColor: const Color(0xff742DDD),
        buttonColor: const Color(0xff742DDD),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff32cdd),
          selectionHandleColor: Color(0xff732cdd),
          selectionColor: Color(0xffD1BAF4),
        ),
      ),
      home: Text('dqwdqqw'),
    );
  }
}
