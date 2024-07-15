import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapchat/auth/screens/chat_screen.dart';
import 'package:snapchat/controllers/update_data.dart';
import 'package:snapchat/auth/screens/landing_screen.dart';
import 'package:snapchat/helper/pref.dart';
import '../../helper/global.dart';
import '../repository/sign_in.dart';
import 'package:path/path.dart' as p;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textC = TextEditingController();
  final nC = TextEditingController();
  XFile? file;
  String? getURLlink;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        file = XFile(pickedImage.path);
        uploadImage(file!.path);
      });
    } else {
      log("No file choosed");
    }
  }

  Future uploadImage(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final userRef = storageRef.child(
        'user_profile/$uid/${DateTime.now().microsecondsSinceEpoch}${p.extension(path)}');

    final user = await userRef.putFile(
        File(path), SettableMetadata(contentType: 'image/jpeg'));
    getURLlink = await user.ref.getDownloadURL();
    log("url -->> $getURLlink");
  }

  @override
  void initState() {
    uid = Pref.uid;
    Pref.skipIntro = true;

    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    log("uid -->> $uid");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Snapchat"),
        actions: [
          IconButton(
              onPressed: () {
                SignIn().signOut();
                SignIn().fbSignOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingScreen(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: StreamBuilder<DocumentSnapshot?>(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data?.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    ListTile(
                      title: Text(data['name'] ?? ""),
                      subtitle: Text(data['phoneNumber'] ?? ""),
                      trailing: Text(data['emailId'] ?? ""),
                      leading: CircleAvatar(
                        radius: 27,
                        backgroundImage: file == null
                            ? CachedNetworkImageProvider(
                                data['photoUrl'] ?? "",
                                errorListener: (p0) =>
                                    Image.asset('assets/images/ph.png'),
                              )
                            : FileImage(File(file!.path)) as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 69),
                    ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: const Text("Pick a file")),
                    const SizedBox(height: 70),
                    ElevatedButton(
                        onPressed: () async {
                          if (getURLlink != null) {
                            data['photoUrl'] = getURLlink;
                            log("photoUrl -->> ${data['photoUrl']}");
                          }
                          await UpdateDataController()
                              .updateUserDetails(data: data);
                          textC.clear();
                        },
                        child: const Text("Update")),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message),
          onPressed: () {
            Get.to(() => const ChatScreen());
          }),
    );
  }
}
