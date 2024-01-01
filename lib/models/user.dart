// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CUser {
  String username;
  String uid;
  String profilePhoto;
  CUser({
    required this.username,
    required this.uid,
    required this.profilePhoto,
  });

  CUser copyWith({
    String? username,
    String? uid,
    String? profilePhoto,
  }) {
    return CUser(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'uid': uid,
      'profilePhoto': profilePhoto,
    };
  }

  factory CUser.fromMap(Map<String, dynamic> map) {
    return CUser(
      username: map['username'] as String,
      uid: map['uid'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CUser.fromJson(String source) => CUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CUser(username: $username, uid: $uid, profilePhoto: $profilePhoto)';

  @override
  bool operator ==(covariant CUser other) {
    if (identical(this, other)) return true;

    return other.username == username && other.uid == uid && other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode => username.hashCode ^ uid.hashCode ^ profilePhoto.hashCode;
}
