class UserModel{
  String? name, phone, email, photoUrl;

  UserModel({required this.name, required this.phone, required this.email, required this.photoUrl});

  factory UserModel.fromMap(Map m1){
    return UserModel(
      name: m1['name'],
      phone: m1['phone'],
      email: m1['email'],
      photoUrl: m1['photoUrl'],
    );
  }

  Map<String, String?> toMap(UserModel user){
    return {
      'name' : user.name,
      'phone' : user.phone,
      'email' : user.email,
      'photoUrl' : user.photoUrl,
    };
  }
}