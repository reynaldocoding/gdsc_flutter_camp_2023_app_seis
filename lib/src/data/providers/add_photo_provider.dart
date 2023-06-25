import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoProvider extends ChangeNotifier {
  XFile? image;
  File? lastImagen;
  //Metodo para agregar la foto
  Future addPhoto() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      lastImagen = File(image!.path);

      notifyListeners();
    }
  }

  Widget getImage(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.file(
              lastImagen!,
              height: 200,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            uploadPhoto();
            // ScaffoldMessenger(child: Text('IMAGEN SUBIDA'));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Imagen Subida'),
            ));
          },
          child: const Text("Upload Photo"),
        ),
      ],
    );
  }

  uploadPhoto() async {
    final post = FirebaseStorage.instance.ref().child('Car Images');
    final time = DateTime.now();
    await post.child('$time.jpg').putFile(lastImagen!);
  }
}
