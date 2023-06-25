import 'package:gdsc_flutter_camp_2023_app_seis/src/data/providers/add_photo_provider.dart';
import 'package:gdsc_flutter_camp_2023_app_seis/src/data/providers/home_screen.dart';
import 'package:gdsc_flutter_camp_2023_app_seis/src/presentation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddPhotoProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const HomeScreen(),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
