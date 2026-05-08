import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceProvider extends ChangeNotifier {
  final List<Place> _yerler = [
    Place(
      id: '1',
      isim: 'Ayasofya',
      tur: 'Gezi',
      puan: 4.9,
      yorumSayisi: 12400,
      sehir: 'İstanbul',
      aciklama:
          'Ayasofya, İstanbul\'un en simgesel yapılarından biridir. Bizans döneminden kalma muhteşem mozaikleri ve devasa kubbesiyle her yıl milyonlarca ziyaretçi çekmektedir.',
      ozellikler: ['Tarihi', 'Müze', 'Cami', 'UNESCO'],
    ),
    Place(
      id: '2',
      isim: 'Kapadokya',
      tur: 'Gezi',
      puan: 4.8,
      yorumSayisi: 9800,
      sehir: 'Nevşehir',
      aciklama:
          'Peri bacaları, yeraltı şehirleri ve sıcak hava balonlarıyla ünlü Kapadokya, dünyanın en eşsiz coğrafyalarından biridir.',
      ozellikler: ['Balon turu', 'Doğa', 'UNESCO', 'Fotoğraf'],
    ),
    Place(
      id: '3',
      isim: 'Nusr-Et',
      tur: 'Restoran',
      puan: 4.5,
      yorumSayisi: 3200,
      sehir: 'İstanbul',
      aciklama:
          'Dünyaca ünlü Salt Bae\'nin restoranı. Et severler için vazgeçilmez bir adres.',
      ozellikler: ['Et', 'Lüks', 'Dünyaca ünlü', 'Akşam yemeği'],
    ),
    Place(
      id: '4',
      isim: 'Çiya Sofrası',
      tur: 'Restoran',
      puan: 4.7,
      yorumSayisi: 5600,
      sehir: 'İstanbul',
      aciklama:
          'Anadolu\'nun dört bir yanından geleneksel tarifleri bünyesinde toplayan Çiya, Kadıköy\'ün en sevilen restoranlarından biridir.',
      ozellikler: ['Geleneksel', 'Anadolu', 'Öğle yemeği', 'Uygun fiyat'],
    ),
    Place(
      id: '5',
      isim: 'Four Seasons Bosphorus',
      tur: 'Otel',
      puan: 4.9,
      yorumSayisi: 2100,
      sehir: 'İstanbul',
      aciklama:
          'Boğaz manzaralı tarihi bir konakta hizmet veren Four Seasons, İstanbul\'un en prestijli otellerinden biridir.',
      ozellikler: ['Lüks', 'Boğaz manzarası', 'Spa', 'Havuz'],
    ),
    Place(
      id: '6',
      isim: 'Swissôtel Istanbul',
      tur: 'Otel',
      puan: 4.6,
      yorumSayisi: 1800,
      sehir: 'İstanbul',
      aciklama:
          'Beşiktaş\'ta yükselen Swissôtel, şehir ve Boğaz manzarasını sunan lüks odaları ve geniş spa alanıyla öne çıkar.',
      ozellikler: ['Lüks', 'Şehir manzarası', 'Kongre', 'Spa'],
    ),
    Place(
      id: '7',
      isim: 'Pamukkale',
      tur: 'Gezi',
      puan: 4.7,
      yorumSayisi: 8700,
      sehir: 'Denizli',
      aciklama:
          'Beyaz travertenler ve antik Hierapolis kalıntılarıyla Pamukkale, Türkiye\'nin en büyüleyici doğal harikalarından biridir.',
      ozellikler: ['Doğa', 'UNESCO', 'Termal', 'Antik kent'],
    ),
    Place(
      id: '8',
      isim: 'Köşkeroğlu',
      tur: 'Restoran',
      puan: 4.6,
      yorumSayisi: 4100,
      sehir: 'İstanbul',
      aciklama:
          'Türk tatlı kültürünün en köklü isimlerinden Köşkeroğlu, baklava ve kadayıf çeşitleriyle nesiller boyu sevilen bir mekandır.',
      ozellikler: ['Tatlı', 'Baklava', 'Geleneksel', 'Kahvaltı'],
    ),
    Place(
      id: '9',
      isim: 'Topkapı Sarayı',
      tur: 'Gezi',
      puan: 4.8,
      yorumSayisi: 11200,
      sehir: 'İstanbul',
      aciklama:
          'Osmanlı İmparatorluğu\'nun merkezi olan Topkapı Sarayı, zengin koleksiyonları ve muhteşem manzarasıyla ziyaretçilerini büyülemektedir.',
      ozellikler: ['Tarihi', 'Müze', 'Osmanlı', 'UNESCO'],
    ),
    Place(
      id: '10',
      isim: 'Efes Antik Kenti',
      tur: 'Gezi',
      puan: 4.8,
      yorumSayisi: 10500,
      sehir: 'İzmir',
      aciklama:
          'Dünyanın en iyi korunmuş antik kentlerinden biri olan Efes, Celcius Kütüphanesi ve görkemli tiyatrosuyla ziyaretçileri etkiler.',
      ozellikler: ['Antik kent', 'UNESCO', 'Tarihi', 'Arkeoloji'],
    ),
    Place(
      id: '11',
      isim: 'Kordon',
      tur: 'Gezi',
      puan: 4.6,
      yorumSayisi: 7800,
      sehir: 'İzmir',
      aciklama:
          'İzmir\'in simgesi olan Kordon, deniz kenarındaki yürüyüş yolu ve kafelerıyla şehrin en popüler mekanlarından biridir.',
      ozellikler: ['Deniz', 'Yürüyüş', 'Manzara', 'Kafe'],
    ),
    Place(
      id: '12',
      isim: 'Veli Usta',
      tur: 'Restoran',
      puan: 4.8,
      yorumSayisi: 6200,
      sehir: 'İzmir',
      aciklama:
          'İzmir\'in efsanevi balık restoranı. Taze deniz ürünleri ve eşsiz manzarasıyla her ziyareti unutulmaz kılar.',
      ozellikler: ['Balık', 'Deniz ürünleri', 'Manzara', 'Taze'],
    ),
    Place(
      id: '13',
      isim: 'Mövenpick İzmir',
      tur: 'Otel',
      puan: 4.5,
      yorumSayisi: 1400,
      sehir: 'İzmir',
      aciklama:
          'Körfez manzaralı lüks odaları ve dünya mutfağından lezzetler sunan restoranıyla İzmir\'in prestijli otellerinden biridir.',
      ozellikler: ['Lüks', 'Körfez manzarası', 'Spa', 'İş'],
    ),
    Place(
      id: '14',
      isim: 'Anıtkabir',
      tur: 'Gezi',
      puan: 4.9,
      yorumSayisi: 15600,
      sehir: 'Ankara',
      aciklama:
          'Türkiye Cumhuriyeti\'nin kurucusu Mustafa Kemal Atatürk\'ün anıt mezarı. Her yıl milyonlarca vatandaş tarafından ziyaret edilir.',
      ozellikler: ['Tarihi', 'Milli', 'Müze', 'Anıt'],
    ),
    Place(
      id: '15',
      isim: 'Kızılay Döner',
      tur: 'Restoran',
      puan: 4.4,
      yorumSayisi: 3800,
      sehir: 'Ankara',
      aciklama:
          'Ankara\'nın kalbinde yer alan bu köklü mekan, yıllardır aynı lezzeti sunan döner kebabıyla ünlüdür.',
      ozellikler: ['Döner', 'Geleneksel', 'Hızlı', 'Uygun fiyat'],
    ),
    Place(
      id: '16',
      isim: 'Sheraton Ankara',
      tur: 'Otel',
      puan: 4.5,
      yorumSayisi: 1600,
      sehir: 'Ankara',
      aciklama:
          'Ankara\'nın merkezinde konumlanan Sheraton, iş ve tatil amaçlı konaklamalar için geniş imkanlar sunmaktadır.',
      ozellikler: ['Lüks', 'Merkezi konum', 'Kongre', 'Spa'],
    ),
    Place(
      id: '17',
      isim: 'Bodrum Kalesi',
      tur: 'Gezi',
      puan: 4.7,
      yorumSayisi: 8900,
      sehir: 'Muğla',
      aciklama:
          'St. Peter Kalesi olarak da bilinen Bodrum Kalesi, içindeki Sualtı Arkeoloji Müzesi ile dünyanın sayılı kalelerinden biridir.',
      ozellikler: ['Tarihi', 'Müze', 'Deniz', 'Fotoğraf'],
    ),
    Place(
      id: '18',
      isim: 'Giritli Restaurant',
      tur: 'Restoran',
      puan: 4.6,
      yorumSayisi: 2900,
      sehir: 'Muğla',
      aciklama:
          'Ege mutfağının en güzel örneklerini sunan Giritli, taze otlar ve zeytinyağlı yemekleriyle ünlüdür.',
      ozellikler: ['Ege mutfağı', 'Deniz ürünleri', 'Bahçe', 'Romantik'],
    ),
    Place(
      id: '19',
      isim: 'Mandarin Oriental Bodrum',
      tur: 'Otel',
      puan: 4.9,
      yorumSayisi: 1200,
      sehir: 'Muğla',
      aciklama:
          'Ege\'nin masmavi sularına bakan Mandarin Oriental, lüks villa ve odaları, özel plajı ile unutulmaz bir tatil sunar.',
      ozellikler: ['Ultra lüks', 'Özel plaj', 'Spa', 'Havuz'],
    ),
    Place(
      id: '20',
      isim: 'Aspendos',
      tur: 'Gezi',
      puan: 4.7,
      yorumSayisi: 7200,
      sehir: 'Antalya',
      aciklama:
          'Dünyanın en iyi korunmuş Roma tiyatrolarından biri olan Aspendos, hâlâ aktif olarak kullanılmakta ve ziyaretçileri büyülemektedir.',
      ozellikler: ['Antik', 'Roma', 'Tiyatro', 'UNESCO'],
    ),
    Place(
      id: '21',
      isim: 'Vanilla Restaurant',
      tur: 'Restoran',
      puan: 4.5,
      yorumSayisi: 2400,
      sehir: 'Antalya',
      aciklama:
          'Antalya\'nın kalbi Kaleiçi\'nde yer alan Vanilla, Akdeniz mutfağını modern yorumlarla sunan şık bir mekandır.',
      ozellikler: ['Akdeniz', 'Kaleiçi', 'Romantik', 'Şık'],
    ),
    Place(
      id: '22',
      isim: 'Rixos Downtown Antalya',
      tur: 'Otel',
      puan: 4.7,
      yorumSayisi: 2200,
      sehir: 'Antalya',
      aciklama:
          'Antalya\'nın şık otellerinden Rixos Downtown, denize yakın konumu ve her şey dahil konseptiyle öne çıkar.',
      ozellikler: ['Her şey dahil', 'Havuz', 'Spa', 'Plaj'],
    ),
  ];

  final Set<String> _favoriler = {};

  List<Place> get yerler => _yerler;
  List<Place> get favoriler =>
      _yerler.where((p) => _favoriler.contains(p.id)).toList();

  bool favoriMi(String id) => _favoriler.contains(id);

  void favoriToggle(String id) {
    if (_favoriler.contains(id)) {
      _favoriler.remove(id);
    } else {
      _favoriler.add(id);
    }
    notifyListeners();
  }

  void yorumEkle(String placeId, String kullanici, String yorum) {
    final index = _yerler.indexWhere((p) => p.id == placeId);
    if (index != -1) {
      _yerler[index] = _yerler[index].yorumEkle({
        'kullanici': kullanici,
        'yorum': yorum,
        'tarih': DateTime.now().toString().substring(0, 10),
      });
      notifyListeners();
    }
  }
}
