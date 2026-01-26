class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String profilePic;
  final String email;
  final String phoneNumber;
  final bool isTermsAccepted;

  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.isTermsAccepted,
    required this.firstName,
    required this.lastName,
    this.profilePic = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'profilePic': profilePic,
      'email': email,
      'phoneNumber': phoneNumber,
      'isTermsAccepted': isTermsAccepted,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      isTermsAccepted: map['isTermsAccepted'] ?? false,
    );
  }
}
