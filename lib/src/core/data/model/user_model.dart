import '../../domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.avatar,
    required super.name,
    required super.login,
    required super.followers,
    required super.following,
    required super.bio,
    required super.company,
    required super.location,
    required super.email,
    required super.blog,
    required super.twitterUsername,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      avatar:  map['avatar_url'] ?? '',
      name:  map['name'] ?? '',
      login:  map['login'] ?? '',
      followers:  map['followers'] ?? '',
      following:  map['following'] ?? '',
      bio:  map['bio'] ?? '',
      company:  map['company'] ?? '',
      location:  map['location'] ?? '',
      email: map['email'] ?? '',
      blog: map['blog'] ?? '',
      twitterUsername: map['twitter_username'] ?? '',
    );
  }
}