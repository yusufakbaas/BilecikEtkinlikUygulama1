// User sınıfı, bir kullanıcıyı temsil eder ve kullanıcı verilerini tutar.
class User {
  // Bu sınıfın değişkenleri tanımlanıyor. Hepsi final yani sadece bir kere atanabilir.
  final String id; // Kullanıcının benzersiz kimlik numarası.
  final String name; // Kullanıcının adı.
  final String email; // Kullanıcının e-posta adresi.
  final bool
      isAdmin; // Kullanıcının yönetici olup olmadığını belirten bayrak (flag).

  // User sınıfının kurucusu (constructor). Tüm değişkenlerin atanmasını zorunlu kılar.
  User({
    required this.id, // Kullanıcının kimlik numarası gereklidir.
    required this.name, // Kullanıcının adı gereklidir.
    required this.email, // Kullanıcının e-posta adresi gereklidir.
    required this.isAdmin, // Kullanıcının yönetici olup olmadığı bilgisi gereklidir.
  });

  // Bu metod, User nesnesini bir harita (Map) yapısına dönüştürür.
  Map<String, dynamic> toMap() {
    // Harita yapısına değişkenler ekleniyor ve döndürülüyor.
    return {
      'id': id, // 'id' anahtarı ile id değişkeni ekleniyor.
      'name': name, // 'name' anahtarı ile name değişkeni ekleniyor.
      'email': email, // 'email' anahtarı ile email değişkeni ekleniyor.
      'isAdmin': isAdmin
          ? 1
          : 0, // 'isAdmin' anahtarı ile isAdmin değişkeni 1 veya 0 olarak ekleniyor.
    };
  }

  // JSON verisinden bir User nesnesi oluşturmak için kullanılan fabrika (factory) metodu.
  factory User.fromJson(Map<String, dynamic> json) {
    // JSON verisindeki değerler kullanılarak yeni bir User nesnesi döndürülüyor.
    return User(
      id: json[
          'id'], // JSON verisinden 'id' değeri alınarak id değişkenine atanıyor.
      name: json[
          'name'], // JSON verisinden 'name' değeri alınarak name değişkenine atanıyor.
      email: json[
          'email'], // JSON verisinden 'email' değeri alınarak email değişkenine atanıyor.
      isAdmin: json['isAdmin'] ==
          1, // JSON verisinden 'isAdmin' değeri alınarak isAdmin değişkenine atanıyor. 1 ise true, aksi takdirde false.
    );
  }
}
