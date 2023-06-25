import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddPhotoScreen extends HookWidget {
  const AddPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // Aquí puedes cargar tus datos iniciales o realizar cualquier otra acción cuando se cargue la pantalla
      // Ejemplo de carga de datos utilizando un Future
      Future<void> loadData() async {
        // Cargar los datos aquí
        await Future.delayed(
            const Duration(seconds: 2)); // Simulación de una carga de datos
        print('Datos cargados');
      }

      loadData();

      return null;
    }, []);
//    final addPhotoProvider = Provider.of<AddPhotoProvider>(context);
    return Scaffold(
      body: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeGoogleSign(),
          ),
        ),
        title: const Text('Google Sign In'),
      ),
    );
  }
}

class HomeGoogleSign extends StatefulWidget {
  const HomeGoogleSign({super.key});

  @override
  State<HomeGoogleSign> createState() => _HomeGoogleSignState();
}

class _HomeGoogleSignState extends State<HomeGoogleSign> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? userFirst;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _user.user = _auth.user;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _login(),
          ),
          Center(
              child: ElevatedButton(
            child: const Text('Cerrar sesión'),
            onPressed: () async {
              await signOut();
              // Aquí puedes realizar las acciones necesarias después de cerrar sesión
            },
          )),
          const Text('Usuario: '),
          Text(userFirst?.email ?? 'No hay ususario'),
          Text(userFirst?.displayName ?? 'No hay ususario')
        ],
      ),
    );
  }

  Future<void> signOut() async {
    try {
      // Cerrar sesión en Firebase
      await _auth.signOut();

      // Cerrar sesión en Google (si se inició sesión con Google)
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        userFirst = null;
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Configurar la autenticación de Google
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      // Autenticar con Firebase utilizando las credenciales de Google
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _login() {
    return ElevatedButton(
      onPressed: () async {
        UserCredential? userCredential = await signInWithGoogle();
        if (userCredential != null) {
          // User? user = userCredential.user;
          userFirst = userCredential.user;
          setState(() {});
          // Aquí puedes realizar las acciones necesarias con el usuario autenticado
          print(userFirst);
        }
      },
      child: const Text('Login'),
    );
  }
}
