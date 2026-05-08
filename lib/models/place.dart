class Place {
  final String id;
  final String isim;
  final String tur;
  final double puan;
  final int yorumSayisi;
  final String sehir;
  final String aciklama;
  final List<String> ozellikler;
  final List<Map<String, String>> yorumlar;

  const Place({
    required this.id,
    required this.isim,
    required this.tur,
    required this.puan,
    required this.yorumSayisi,
    required this.sehir,
    required this.aciklama,
    required this.ozellikler,
    this.yorumlar = const [],
  });

  Place yorumEkle(Map<String, String> yeniYorum) {
    return Place(
      id: id,
      isim: isim,
      tur: tur,
      puan: puan,
      yorumSayisi: yorumSayisi,
      sehir: sehir,
      aciklama: aciklama,
      ozellikler: ozellikler,
      yorumlar: [...yorumlar, yeniYorum],
    );
  }
}
