import 'dart:convert';

import 'package:collection/collection.dart';

class UserModel {
  final String email;
  final String name;
  final List<String> followers;
  final List<String> following;
  final String profilePicture;
  final String bannerPic;
  final String bio;
  final String uid;
  final bool isDoctor;

  UserModel({
    required this.email,
    required this.name,
    required this.followers,
    required this.following,
    required this.profilePicture,
    required this.bannerPic,
    required this.bio,
    required this.uid,
    required this.isDoctor,
  });

  UserModel copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? following,
    String? profilePicture,
    String? bannerPic,
    String? bio,
    String? uid,
    bool? isDoctor,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePicture: profilePicture ?? this.profilePicture,
      bannerPic: bannerPic ?? this.bannerPic,
      bio: bio ?? this.bio,
      uid: uid ?? this.uid,
      isDoctor: isDoctor ?? this.isDoctor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'followers': followers,
      'following': following,
      'profilePicture': profilePicture,
      'bannerPic': bannerPic,
      'bio': bio,
      'uid': uid,
      'isDoctor': isDoctor,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      profilePicture: map['profilePicture'] ?? '',
      bannerPic: map['bannerPic'] ?? '',
      bio: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      isDoctor: map['isDoctor'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, followers: $followers, following: $following, profilePicture: $profilePicture, bannerPic: $bannerPic, bio: $bio, uid: $uid, isDoctor: $isDoctor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      listEquals(other.followers, followers) &&
      listEquals(other.following, following) &&
      other.profilePicture == profilePicture &&
      other.bannerPic == bannerPic &&
      other.bio == bio &&
      other.uid == uid &&
      other.isDoctor == isDoctor;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      profilePicture.hashCode ^
      bannerPic.hashCode ^
      bio.hashCode ^
      uid.hashCode ^
      isDoctor.hashCode;
  }
}
