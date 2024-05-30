class UserModel {
  late final String name;
  late final String userEmail;
  final String userType;
  late final String adress; // Correct spelling to 'address' if possible
  late final String phoneNumber;
  final String userId;

  UserModel({
    required this.name,
    required this.userEmail,
    required this.userType,
    required this.adress,
    required this.phoneNumber,
    required this.userId,
  });

  // Serialization
  Map<String, dynamic> toJson() => {
        'name': name,
        'userEmail': userEmail,
        'userType': userType,
        'adress': adress, // Correct spelling to 'address' if possible
        'phoneNumber': phoneNumber,
        'userId': userId,
      };

  // Deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      userEmail: json['userEmail'],
      userType: json['userType'],
      adress: json['adress'], // Correct spelling to 'address' if possible
      phoneNumber: json['phoneNumber'],
      userId: json['userId'],
    );
  }

  // CopyWith method
  UserModel copyWith({
    String? name,
    String? userEmail,
    String? userType,
    String? adress, // Correct spelling to 'address' if possible
    String? phoneNumber,
    String? userId,
  }) {
    return UserModel(
      name: name ?? this.name,
      userEmail: userEmail ?? this.userEmail,
      userType: userType ?? this.userType,
      adress:
          adress ?? this.adress, // Correct spelling to 'address' if possible
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
    );
  }
}
