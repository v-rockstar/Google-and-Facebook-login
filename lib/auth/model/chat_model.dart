import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String userId;
  final String userName;
  final String message;
  final Timestamp createdAt;

  ChatMessage({
    required this.userId,
    required this.userName,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      message: data['message'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'message': message,
      'createdAt': createdAt,
    };
  }
}

class ChatMessageTile {
  final String userId;
  final String userName;

  final Timestamp createdAt;
  final String profilePic;
  final String lastMsg;

  ChatMessageTile({
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.profilePic,
    required this.lastMsg,
  });

  factory ChatMessageTile.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ChatMessageTile(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      profilePic: data['profilePic'] ?? '',
      lastMsg: data['lastMsg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'createdAt': createdAt,
      'profilePic': profilePic,
      'lastMsg': lastMsg,
    };
  }
}
