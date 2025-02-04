import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  entrarUsuario({required String email, required String senha}) {
    // print("METODO ENTRAR USUARIO");
  }

  Future<String?> cadastrarUsuario({
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      print("Tentando criar usuário com email: $email");
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      print("Usuário criado com sucesso: ${userCredential.user}");
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(nome);
        await userCredential.user!.reload();
        User? updatedUser = _firebaseAuth.currentUser;
        print("Nome do usuário atualizado para: ${updatedUser?.displayName}");
      } else {
        print("Erro: userCredential.user é null");
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}");
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mail já está em uso.";
        case "invalid-email":
          return "O e-mail é inválido.";
        case "operation-not-allowed":
          return "Operação não permitida.";
        case "weak-password":
          return "A senha é muito fraca.";
        default:
          return "Erro desconhecido: ${e.message}";
      }
    } catch (e) {
      print("Erro inesperado: ${e.toString()}");
      return "Erro inesperado: ${e.toString()}";
    }

    return null;
  }
}
