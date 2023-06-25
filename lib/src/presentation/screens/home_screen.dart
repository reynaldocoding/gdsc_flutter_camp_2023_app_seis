import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final modelController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Firebase App"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return _CustomForm(
                      modelController: modelController,
                      yearController: yearController);
                });
          },
          child: const Icon(
            Icons.add,
          ),
        ));
  }
}

class _CustomForm extends StatelessWidget {
  const _CustomForm({
    required this.modelController,
    required this.yearController,
  });

  final TextEditingController modelController;
  final TextEditingController yearController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Modelo del Auto:",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: modelController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.car_repair,
                color: Colors.white,
              ),
              hintText: "Ingresa el modelo del auto",
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.teal,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Año",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: yearController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.numbers,
                color: Colors.white,
              ),
              hintText: "Ingresa el modelo del auto",
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.teal,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                icon: const Icon(
                  Icons.add_box,
                  color: Colors.white,
                ),
                label: const Text(
                  'Guardar Auto',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  String model = modelController.text.trim();
                  String year = yearController.text.trim();

                  print('Modelo: $model');
                  print('Year: $year');
                  createCar(model: model, year: year);
                },
              ),
            ),
          )
        ],
      ),
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
