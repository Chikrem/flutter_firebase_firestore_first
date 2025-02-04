import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  entrarUsuario({required String email, required String senha}){
    print("Método de Entrada");
  }

  cadastrarUsuario({required String email, required String senha, required String nome}){
    print("Método de Cadastro");
  }

}