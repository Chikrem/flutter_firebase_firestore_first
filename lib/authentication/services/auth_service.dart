import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> entrarUsuario({required String email, required String senha}) async {  // Método Login
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      //print("METODO ENTRAR USUARIO");
      return null; // Login bem-sucedido
    } on FirebaseAuthException catch (e) {
      //print("FirebaseAuthException: ${e.code}");
      switch (e.code) {
        case "user-not-found":
          return "Usuário não encontrado.";
        case "wrong-password":
          return "Senha incorreta.";
        case "invalid-email":
          return "O e-mail é inválido.";
        case "user-disabled":
          return "Usuário desativado.";
        default:
          return "Erro desconhecido: ${e.message}";
      }
    } catch (e) {
      //print("Erro inesperado: ${e.toString()}");
      return "Erro inesperado: ${e.toString()}";
    }
  }

  Future<String?> cadastrarUsuario({    // Método cadastro
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      //print("Tentando criar usuário com email: $email");
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      //print("Usuário criado com sucesso: ${userCredential.user}");
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(nome);
        await userCredential.user!.reload();
        User? updatedUser = _firebaseAuth.currentUser;
        //print("Nome do usuário atualizado para: ${updatedUser?.displayName}");
      } else {
        //print("Erro: userCredential.user é null");
      }
    } on FirebaseAuthException catch (e) {
      //print("FirebaseAuthException: ${e.code}");
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
      //print("Erro inesperado: ${e.toString()}");
      return "Erro inesperado: ${e.toString()}";
    }

    return null;
  }

  Future<String?> redefinicaoSenha({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      //print("E-mail de redefinição de senha enviado para: $email");
      return null; // E-mail enviado com sucesso
    } on FirebaseAuthException catch (e) {
      //print("FirebaseAuthException: ${e.code}");
      switch (e.code) {
        case "invalid-email":
          return "O e-mail é inválido.";
        case "user-not-found":
          return "Usuário não encontrado.";
        default:
          return "Erro desconhecido: ${e.message}";
      }
    } catch (e) {
      //print("Erro inesperado: ${e.toString()}");
      return "Erro inesperado: ${e.toString()}";
    }
  }

  Future<String?> deslogar() async {
    try {
      await _firebaseAuth.signOut();
      //print("Usuário deslogado com sucesso");
    } catch (e) {
      //print("Erro ao deslogar usuário: ${e.toString()}");
    }
    return null;
  }

  removerConta() async {
    await _firebaseAuth.currentUser!.delete();
  }
}
