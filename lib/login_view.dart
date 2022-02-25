import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _enableSignInButton = false;
  final _userIdController = TextEditingController();
  final _appIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Sendbird Sample',
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
      child: Column(
        children: [
          TextField(
            controller: _appIdController,
            onChanged: (value) {
              setState(
                () {
                  _enableSignInButton = _shouldEnableSignInButton();
                },
              );
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'App Id',
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                onPressed: () {
                  _appIdController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _userIdController,
            onChanged: (value) {
              setState(() {
                _enableSignInButton = _shouldEnableSignInButton();
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'User Id',
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(
                onPressed: () {
                  _userIdController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: _signInButton(context, _enableSignInButton),
          )
        ],
      ),
    );
  }

  Widget _signInButton(BuildContext context, bool enabled) {
    if (enabled == false) {
      return TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff742DDD)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () {
        connect(_appIdController.text, _userIdController.text)
            .then((user) => {
                  Navigator.pushNamed(context, '/channel_list'),
                })
            .catchError((error) {
          print('login_view: _signInButton: ERROR: $error');
        });
      },
      child: const Text(
        'Sign In',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  bool _shouldEnableSignInButton() {
    if (_userIdController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<User> connect(String appId, String userId) async {
    try {
      final sendbird = SendbirdSdk(appId: '2596F234-C07F-480B-A1F5-78C0B2A88120');
      final user = await sendbird.connect(userId);
      return user;
    } catch (e) {
      print('login_view:connect : ERROR:$e');
      throw e;
    }
  }
}
