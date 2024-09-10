import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../styles/styles.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    // Kayıt bilgilerini doğrula
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty || _surnameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun.')),
      );
      return;
    }

    try {
      // Firebase Authentication üzerinden kullanıcıyı kaydet
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Firestore'da kullanıcının bilgilerini kaydet
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text,
        'name': _nameController.text,
        'surname': _surnameController.text,
      });

      // Başarılı kayıt sonrası login sayfasına yönlendirme
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Firebase hatalarını yönetme
      String errorMessage = 'Kayıt sırasında bir hata oluştu.';
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          errorMessage = 'Parola çok zayıf.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Geçersiz bir e-posta adresi girdiniz.';
        }
      }

      print('Registration Error: $e');
      // Hata mesajını kullanıcıya göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/orman.webp',
            fit: BoxFit.cover,
          ),
          Container(
            color: backgroundColor.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.directions_walk,
                  color: iconColor,
                  size: iconSize,
                ),
                SizedBox(height: 20),
                const Text(
                  'WalkTime',
                  textAlign: TextAlign.center,
                  style: titleTextStyle,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                  style: TextStyle(color: textColor),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: textFieldDecoration.copyWith(hintText: 'Password'),
                  style: TextStyle(color: textColor),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: textFieldDecoration.copyWith(hintText: 'Name'),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _surnameController,
                  decoration: textFieldDecoration.copyWith(hintText: 'Surname'),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _registerUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: buttonTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Already have an account? Log in",
                    style: linkTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}