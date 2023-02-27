import 'package:buttomy_application/presentaion/splashscreen.dart';
import 'package:buttomy_application/provider/common_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'core/constans/constants.dart';
import 'db/db_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CartItemAdapter().typeId)) {
    Hive.registerAdapter(CartItemAdapter());
  }

  await Hive.openBox<CartItem>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonProvider>(
            create: (context) => CommonProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buttomy',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: Constants.screenColor),
          primarySwatch: Colors.yellow,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
