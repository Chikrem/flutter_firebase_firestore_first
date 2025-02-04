import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  entrarUsuario({required String email, required String senha}) {
    print("Método de Entrada");
  }

  cadastrarUsuario(
      {required String email,
      required String senha,
      required String nome}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);
      await userCredential.user!.updateDisplayName(nome);
      print("Método de Cadastro");
    } on FirebaseAuthException catch (e) {
      switch(e.code){
        case "email-already-in-use":
          return "O e-mail já está cadastrado.";
      }
      return e.code;
    }
  }
}
