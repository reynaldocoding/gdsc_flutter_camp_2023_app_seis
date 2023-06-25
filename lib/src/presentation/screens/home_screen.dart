import 'package:gdsc_flutter_camp_2023_app_seis/src/data/providers/home_screen.dart';
import 'package:gdsc_flutter_camp_2023_app_seis/src/presentation/screens/add_car_screen.dart';
import 'package:gdsc_flutter_camp_2023_app_seis/src/presentation/screens/add_photo_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueProvider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Firebase App"),
        centerTitle: true,
      ),
      body: _Pages(valueProvider: valueProvider),
      bottomNavigationBar: _NavigatorBar(valueProvider: valueProvider),
    );
  }
}

class _NavigatorBar extends StatelessWidget {
  const _NavigatorBar({
    required this.valueProvider,
  });

  final HomeScreenProvider valueProvider;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        valueProvider.setValue = value;
      },
      currentIndex: valueProvider.firstValue,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_photo_alternate),
          label: 'Add Photo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_repair),
          label: 'Add Car',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    required this.valueProvider,
  });

  final HomeScreenProvider valueProvider;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: valueProvider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        valueProvider.setValue = value;
      },
      children: [
        const AddPhotoScreen(),
        CustomForm(),
      ],
    );
  }
}

Future createCar({required String model, required String year}) async {
  final db = FirebaseFirestore.instance.collection('cars');

  final Map<String, dynamic> data = {
    'model': model,
    'year': year,
  };

  await db.add(data);
}
