import 'package:flutter/material.dart';
import './pages/feed.dart';
import './pages/settings.dart';
import './pages/submit_post.dart';
import './pages/login.dart';
import './actions/user_actions.dart';

void main() => runApp(TasteTheWaste());

class TasteTheWaste extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taste the Waste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppContainer(),
    );
  }
}

class AppContainer extends StatefulWidget {
  AppContainer({Key key}) : super(key: key);

  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  int _currentIndex = 0;
  String _accessToken = '';
  List<Widget> _children = [
    Feed(),
    SubmitPost(),
  ];

  final _names = ['Home Feed', 'Submit Post', 'Settings'];

  _AppContainerState() {
    _children.add(Settings());
  }

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  bool _isLoggedIn() {
    return this._accessToken.toString() != '';
  }

  void setToken(String token) {
    setState(() {
      this._accessToken = token;
    });
  }

  void _logout() {
    this.setToken('');
  }

  void _login() {
    this._setIndex(0);
    this.setToken('test');
  }

  @override
  Widget build(BuildContext context) {
    return LoginAction(
      child: LogoutAction(
      child: Scaffold(
      appBar: AppBar(
        title: Text(_isLoggedIn() ? _names[_currentIndex] : 'Login'),
      ),
      body: _isLoggedIn() ? _children[_currentIndex] : Login(),
      bottomNavigationBar: _isLoggedIn() ? BottomNavigationBar(
        onTap: _setIndex,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Extras')
          )
        ],
      ) : null,
    ),
    logout: this._logout,
    ), login: this._login);
    
  }
}