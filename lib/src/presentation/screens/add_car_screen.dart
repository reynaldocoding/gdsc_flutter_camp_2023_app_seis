import 'package:flutter/material.dart';

import 'home_screen.dart';

class CustomForm extends StatelessWidget {
  final modelController = TextEditingController();
  final yearController = TextEditingController();

  CustomForm({super.key});

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
