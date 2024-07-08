class User {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  String? bloodGroup;
  double? height;
  double? weight;
  String? eyeColor;
  String? ip;
  String? macAddress;
  String? university;
  String? ein;
  String? ssn;
  String? userAgent;
  String? role;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.ip,
    this.macAddress,
    this.university,
    this.ein,
    this.ssn,
    this.userAgent,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        maidenName: json['maidenName'] as String?,
        age: json['age'] as int?,
        gender: json['gender'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        birthDate: json['birthDate'] as String?,
        image: json['image'] as String?,
        bloodGroup: json['bloodGroup'] as String?,
        height: (json['height'] as num?)?.toDouble(),
        weight: (json['weight'] as num?)?.toDouble(),
        eyeColor: json['eyeColor'] as String?,
        ip: json['ip'] as String?,
        macAddress: json['macAddress'] as String?,
        university: json['university'] as String?,
        ein: json['ein'] as String?,
        ssn: json['ssn'] as String?,
        userAgent: json['userAgent'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'maidenName': maidenName,
        'age': age,
        'gender': gender,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
        'birthDate': birthDate,
        'image': image,
        'bloodGroup': bloodGroup,
        'height': height,
        'weight': weight,
        'eyeColor': eyeColor,
        'ip': ip,
        'macAddress': macAddress,
        'university': university,
        'ein': ein,
        'ssn': ssn,
        'userAgent': userAgent,
        'role': role,
      };
}
