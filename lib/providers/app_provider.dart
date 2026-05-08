import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _onboardingGoruldu = false;
  bool _karanlikMod = false;
  String _dil = 'Türkçe';

  bool get onboardingGoruldu => _onboardingGoruldu;
  bool get karanlikMod => _karanlikMod;
  String get dil => _dil;

  ThemeMode get themeMode => _karanlikMod ? ThemeMode.dark : ThemeMode.light;

  void onboardingTamamla() {
    _onboardingGoruldu = true;
    notifyListeners();
  }

  void karanlikModToggle(bool deger) {
    _karanlikMod = deger;
    notifyListeners();
  }

  void dilDegistir(String yeniDil) {
    _dil = yeniDil;
    notifyListeners();
  }

  String cevir(String anahtar) {
    return _ceviriTablosu[_dil]?[anahtar] ?? anahtar;
  }

  final Map<String, Map<String, String>> _ceviriTablosu = {
    'Türkçe': {
      'anaSayfa': 'Ana Sayfa',
      'favoriler': 'Favoriler',
      'profil': 'Profil',
      'arama': 'Gezi yeri, restoran veya otel ara...',
      'kategoriler': 'Kategoriler',
      'onecikanlar': 'Öne Çıkanlar',
      'tumYerler': 'Tüm Yerler',
      'gezi': 'Gezi',
      'restoran': 'Restoran',
      'otel': 'Otel',
      'hepsi': 'Hepsi',
      'puan': 'Puana Göre',
      'yorum': 'Yorum Sayısına Göre',
      'hakkinda': 'Hakkında',
      'ozellikler': 'Özellikler',
      'haritadaGoster': 'Haritada Göster',
      'yorumYaz': 'Yorumunuzu yazın...',
      'girisYap': 'Giriş Yap',
      'cikisYap': 'Çıkış Yap',
      'ayarlar': 'Ayarlar',
      'bildirimler': 'Bildirimler',
      'karanlikMod': 'Karanlık Mod',
      'dil': 'Dil',
      'merhabaKullanici': 'Merhaba',
      'bugunNereyi': 'Bugün nereyi keşfetmek istersin?',
      'toplamYer': 'Toplam Yer',
      'sehir': 'Şehir',
      'favori': 'Favori',
      'sonucBulunamadi': 'Sonuç bulunamadı',
      'yorumEkle': 'Yorum yapmak için giriş yapın',
      'henuzYorum': 'Henüz yorum yapılmamış. İlk yorumu siz yapın!',
      'favoriEklenmedi': 'Henüz favori eklemediniz',
      'kalpIkonu': 'Kalp ikonuna basarak yer ekleyebilirsiniz',
      'yorumlar': 'Yorumlar',
      'genel': 'Genel',
      'hesap': 'Hesap',
      'uygulamaHakkinda': 'Uygulama Hakkında',
      'uygulamamiPuanla': 'Uygulamayı Puanla',
      'hesapBilgileri': 'Hesap Bilgileri',
      'dilSec': 'Dil Seçin',
      'koyuTemaKullan': 'Koyu tema kullan',
      'yeniYerler': 'Yeni yerler ve güncellemeler',
    },
    'English': {
      'anaSayfa': 'Home',
      'favoriler': 'Favorites',
      'profil': 'Profile',
      'arama': 'Search places, restaurants or hotels...',
      'kategoriler': 'Categories',
      'onecikanlar': 'Featured',
      'tumYerler': 'All Places',
      'gezi': 'Sightseeing',
      'restoran': 'Restaurant',
      'otel': 'Hotel',
      'hepsi': 'All',
      'puan': 'By Rating',
      'yorum': 'By Review Count',
      'hakkinda': 'About',
      'ozellikler': 'Features',
      'haritadaGoster': 'Show on Map',
      'yorumYaz': 'Write a review...',
      'girisYap': 'Login',
      'cikisYap': 'Logout',
      'ayarlar': 'Settings',
      'bildirimler': 'Notifications',
      'karanlikMod': 'Dark Mode',
      'dil': 'Language',
      'merhabaKullanici': 'Hello',
      'bugunNereyi': 'Where would you like to explore today?',
      'toplamYer': 'Total Places',
      'sehir': 'City',
      'favori': 'Favorite',
      'sonucBulunamadi': 'No results found',
      'yorumEkle': 'Login to write a review',
      'henuzYorum': 'No reviews yet. Be the first!',
      'favoriEklenmedi': 'No favorites yet',
      'kalpIkonu': 'Tap the heart icon to add places',
      'yorumlar': 'Reviews',
      'genel': 'General',
      'hesap': 'Account',
      'uygulamaHakkinda': 'About App',
      'uygulamamiPuanla': 'Rate the App',
      'hesapBilgileri': 'Account Info',
      'dilSec': 'Select Language',
      'koyuTemaKullan': 'Use dark theme',
      'yeniYerler': 'New places and updates',
    },
    'Deutsch': {
      'anaSayfa': 'Startseite',
      'favoriler': 'Favoriten',
      'profil': 'Profil',
      'arama': 'Orte, Restaurants oder Hotels suchen...',
      'kategoriler': 'Kategorien',
      'onecikanlar': 'Empfohlen',
      'tumYerler': 'Alle Orte',
      'gezi': 'Sehenswürdigkeiten',
      'restoran': 'Restaurant',
      'otel': 'Hotel',
      'hepsi': 'Alle',
      'puan': 'Nach Bewertung',
      'yorum': 'Nach Anzahl der Bewertungen',
      'hakkinda': 'Über',
      'ozellikler': 'Eigenschaften',
      'haritadaGoster': 'Auf Karte zeigen',
      'yorumYaz': 'Bewertung schreiben...',
      'girisYap': 'Anmelden',
      'cikisYap': 'Abmelden',
      'ayarlar': 'Einstellungen',
      'bildirimler': 'Benachrichtigungen',
      'karanlikMod': 'Dunkelmodus',
      'dil': 'Sprache',
      'merhabaKullanici': 'Hallo',
      'bugunNereyi': 'Was möchten Sie heute entdecken?',
      'toplamYer': 'Orte gesamt',
      'sehir': 'Stadt',
      'favori': 'Favorit',
      'sonucBulunamadi': 'Keine Ergebnisse',
      'yorumEkle': 'Anmelden um zu bewerten',
      'henuzYorum': 'Noch keine Bewertungen. Seien Sie der Erste!',
      'favoriEklenmedi': 'Noch keine Favoriten',
      'kalpIkonu': 'Herz drücken um Orte hinzuzufügen',
      'yorumlar': 'Bewertungen',
      'genel': 'Allgemein',
      'hesap': 'Konto',
      'uygulamaHakkinda': 'Über die App',
      'uygulamamiPuanla': 'App bewerten',
      'hesapBilgileri': 'Kontoinformationen',
      'dilSec': 'Sprache wählen',
      'koyuTemaKullan': 'Dunkles Design verwenden',
      'yeniYerler': 'Neue Orte und Updates',
    },
  };
}
