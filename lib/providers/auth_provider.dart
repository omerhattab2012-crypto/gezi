import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get girisYapildi => _user != null;

  Future<bool> girisYap(String email, String sifre) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isNotEmpty && sifre.length >= 6) {
      _user = User(
        id: '1',
        ad: email.split('@').first,
        email: email,
        avatarHarf: email[0].toUpperCase(),
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> kayitOl(String email, String sifre) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isNotEmpty && sifre.length >= 6) {
      _user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        ad: email.split('@').first,
        email: email,
        avatarHarf: email[0].toUpperCase(),
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void adGuncelle(String yeniAd) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        ad: yeniAd,
        email: _user!.email,
        avatarHarf: yeniAd[0].toUpperCase(),
      );
      notifyListeners();
    }
  }

  void cikisYap() {
    _user = null;
    notifyListeners();
  }
}
