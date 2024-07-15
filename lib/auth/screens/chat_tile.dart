import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snapchat/helper/global.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Chats"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("chats").doc(uid).snapshots(),
        builder: (context, snapshot) {
          final chats = snapshot.data!.data();
          if (snapshot.hasData) {
            log("hshsh -->> $chats");
            return const Text("data");
            // return ListView.builder(
            //   itemCount: chats.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(chats[index]['name']),
            //     );
            //   },
            // );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
