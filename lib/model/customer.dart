class Customer {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? eyeColor;
  String? hairColor;
  int? age;

  Customer({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.eyeColor,
    this.hairColor,
    this.age,
  });

  // when reading document from firestore db
  Customer.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map["id"];
    fullName = map["full_name"];
    email = map["email"];
    phone = map["phone"];
    eyeColor = map["eye_color"];
    hairColor = map["hair_color"];
    age = map["age"];
  }

  // when creating document in firestore db
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "eye_color": eyeColor,
      "hair_color": hairColor,
      "age": age,
    };
  }
}