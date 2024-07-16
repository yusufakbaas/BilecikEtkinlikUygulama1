// Event sınıfı, bir etkinliği temsil eder ve etkinlik verilerini tutar.
class Event {
  // Bu sınıfın değişkenleri tanımlanıyor. Hepsi final yani sadece bir kere atanabilir.
  final int id; // Etkinliğin benzersiz kimlik numarası.
  final String title; // Etkinliğin başlığı.
  final String description; // Etkinliğin açıklaması.
  final String date; // Etkinliğin tarihi.
  final String imageUrl; // Etkinliğe ait resmin URL'si.

  // Event sınıfının kurucusu (constructor). Tüm değişkenlerin atanmasını zorunlu kılar.
  Event({
    required this.id, // Etkinliğin kimlik numarası gereklidir.
    required this.title, // Etkinliğin başlığı gereklidir.
    required this.description, // Etkinliğin açıklaması gereklidir.
    required this.date, // Etkinliğin tarihi gereklidir.
    required this.imageUrl, // Etkinliğe ait resmin URL'si gereklidir.
  });

  // Bu metod, Event nesnesini bir harita (Map) yapısına dönüştürür.
  Map<String, dynamic> toMap() {
    // Harita yapısına değişkenler ekleniyor ve döndürülüyor.
    return {
      'id': id, // 'id' anahtarı ile id değişkeni ekleniyor.
      'title': title, // 'title' anahtarı ile title değişkeni ekleniyor.
      'description':
          description, // 'description' anahtarı ile description değişkeni ekleniyor.
      'date': date, // 'date' anahtarı ile date değişkeni ekleniyor.
      'imageUrl':
          imageUrl, // 'imageUrl' anahtarı ile imageUrl değişkeni ekleniyor.
    };
  }

  // JSON verisinden bir Event nesnesi oluşturmak için kullanılan fabrika (factory) metodu.
  factory Event.fromJson(Map<String, dynamic> json) {
    // JSON verisindeki değerler kullanılarak yeni bir Event nesnesi döndürülüyor.
    return Event(
      id: json[
          'id'], // JSON verisinden 'id' değeri alınarak id değişkenine atanıyor.
      title: json[
          'title'], // JSON verisinden 'title' değeri alınarak title değişkenine atanıyor.
      description: json[
          'description'], // JSON verisinden 'description' değeri alınarak description değişkenine atanıyor.
      date: json[
          'date'], // JSON verisinden 'date' değeri alınarak date değişkenine atanıyor.
      imageUrl: json[
          'imageUrl'], // JSON verisinden 'imageUrl' değeri alınarak imageUrl değişkenine atanıyor.
    );
  }
}
