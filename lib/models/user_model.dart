class UserModel {

  final String uid;
  final String email;
  final String name;
  final String photoUrl;

  // NEW
  final String phone;
  final String address;

  final String createdAt;

  UserModel({

    required this.uid,

    required this.email,

    required this.name,

    required this.photoUrl,

    this.phone = '',

    this.address = '',

    this.createdAt = '',

  });

  Map<String, dynamic> toMap() {

    return {

      'uid': uid,

      'email': email,

      'name': name,

      'photoUrl': photoUrl,

      'phone': phone,

      'address': address,

      'createdAt': createdAt,

    };
  }

  factory UserModel.fromMap(
      Map<String, dynamic> map,
      ) {

    return UserModel(

      uid:
      map['uid'] ?? '',

      email:
      map['email'] ?? '',

      name:
      map['name'] ?? '',

      photoUrl:
      map['photoUrl'] ?? '',

      phone:
      map['phone'] ?? '',

      address:
      map['address'] ?? '',

      createdAt:
      map['createdAt'] ?? '',

    );
  }

  UserModel copyWith({

    String? uid,

    String? email,

    String? name,

    String? photoUrl,

    String? phone,

    String? address,

    String? createdAt,

  }) {

    return UserModel(

      uid:
      uid ?? this.uid,

      email:
      email ?? this.email,

      name:
      name ?? this.name,

      photoUrl:
      photoUrl ?? this.photoUrl,

      phone:
      phone ?? this.phone,

      address:
      address ?? this.address,

      createdAt:
      createdAt ??
          this.createdAt,

    );
  }
}