import 'package:flutter/material.dart';
import 'package:my_store_app/provider/user_provider.dart';
import 'package:my_store_app/view/screens/authentication_screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store_app/view/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //Run the flutter app warpped ina Providrscope for managing app state
  runApp(const ProviderScope(child: MyApp()));
}

//Root widget of the application a  consumer widget to consume state change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  //Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    //obtain an instance of sharedPreferences for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Retrive the authentication token and user data stored locally
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user_data');
    //if both token and user data are available, update the user state
    if (token != null && userJson != null) {
      //set the user data in the app state
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MainScreen(),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final user = ref.watch(userProvider);
          return user != null ? MainScreen() : MainScreen();
        },
      ),
    );
  }
}
