import 'dart:io';

import 'package:chat_app/Authentication/Views/Home%20Screens/new_screen.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/on_loading_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Update/update_profile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  File? _imageFile;
  String _uploadedImageUrl = '';

// Function to pick an image from gallery
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _uploadImage();
      });
    }
  }

// Function to upload profile image to storage and save image URL to Firestore
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      // Step 1: Upload the image to Firebase Storage
      final storage = FirebaseStorage.instance;
      final storageRef = storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Step 2: Get the uploaded image's URL
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await storageRef.getDownloadURL();

        // Step 3: Save the image URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userCollectionRef =
              FirebaseFirestore.instance.collection('users');
          final currentUserDocRef = userCollectionRef.doc(user.uid);

          await currentUserDocRef.update({
            'imageurl': downloadUrl,
          });

          setState(() {
            _uploadedImageUrl = downloadUrl;
          });

          print("Image URL saved to Firestore");
        }
      }
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userCollectionRef =
            FirebaseFirestore.instance.collection('Users');
        final currentUserDocRef = userCollectionRef.doc(user.uid);

        final docSnapshot = await currentUserDocRef.get();
        if (docSnapshot.exists) {
          setState(() {
            imageUrl = docSnapshot.get('imageurl');
          });
        }
      }
    } catch (error) {
      print('Error loading profile image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Chatify",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Text("Chats"),
              Text("Status"),
              Text("Calls"),
            ],
          ),
        ),
        drawer: Container(
          child: Drawer(
            backgroundColor: Color(0xffCAF1DE),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //  ---------------------steam new ----------------------//
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(auth.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final userData = snapshot.data!.data();
                            if (userData != null &&
                                userData is Map<String, dynamic>) {
                              final imageUrl = userData.containsKey('imageurl')
                                  ? userData['imageurl'] as String
                                  : '';

                              return Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      child: ClipOval(
                                        child: imageUrl.isNotEmpty
                                            ? Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(100.0),
                                                child: Text(
                                                  'Image not found',
                                                  style:
                                                      TextStyle(fontSize: 50),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: _pickImage,
                                child: Center(child: Text('Pick Image')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('id',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                          snapshot.data!.docs;
                      // String? name = snapshot.data?.get('name') as String?;
                      if (docs[0]['name'] != null) {
                        return SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // CircleAvatar(
                              //   radius: 64,
                              //   backgroundColor: Colors.teal,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        docs[0]['name'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          docs[0]['email'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.phone_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        docs[0]['phone'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, UpdateProfile.id);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.person_outline,
                                            color: Colors.white, size: 30),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "Update Profile",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /*Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.person_outline,color: Colors.white,size: 30,),
                                      SizedBox(
                                        width: 30,
                                      ),

                                      Text("Update Profile",style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),



                                    ],
                                  ),
                                ),
                              ),*/

                              SizedBox(
                                height: 100,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            title: Center(
                                              child: Text(
                                                "ALERT",
                                                style: TextStyle(
                                                  fontFamily: 'Arima',
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Text(
                                                  "Are u sure want to logout"),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    await FirebaseAuth.instance
                                                        .signOut()
                                                        .then((value) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                OnLoadingOne(),
                                                          ));
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(error);
                                                    });
                                                  },
                                                  child: Text(
                                                    "yes",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "no",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ));
                                  /*
                                  Card(
                  color: Theme.of(context).primaryColor,
                  child: ListTile(

                    title: Text(
                      "Signout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:   Theme.of(context).primaryColor,
                            title: Center(child: Text("ALERT")),
                            content: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text("Are u sure want to logout"),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut().then((value) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoiceScreen(),));

                                    }).onError((error, stackTrace) {
                                      print(error);
                                    });
                                  },
                                  child: Text(
                                    "yes",
                                    style: TextStyle(   color: Theme.of(context).accentColor,),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "no",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ));
                    },
                  ),
                )
                                  */
                                },
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Log out",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        fontFamily: "Arima",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                        // child: Text(
                        //   'Welcome ${docs[0]['name']}',
                        //   style: TextStyle(
                        //     fontSize: 50,
                        //   ),
                        // ),
                      } else {
                        return Text('Name not found');
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            /// chat part
            Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                snapshot.data!.docs;

            // Filter out the current user's data
            docs = docs.where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid).toList();

            if (docs.isEmpty) {
              return Center(child: Text("No data"));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xffCAF1DE),
                ),
                child: ListView.builder(
                  itemCount: docs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    String imageUrl = docs[index]['imageurl'].toString();
                    return Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewScreen(
                                  userName: docs[index]['name'].toString(),
                                  userId: docs[index].id,
                                  // currentUserImageUrl: docs[index]['imageUrl'].toString(),
                                ),
                              ),
                            );
                            //Navigator.pushNamed(context, NewScreen.id);
                            print(docs[index].id);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(0xffd29a50),
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl) // Load the profile picture from the URL
                                  : null, // Show default avatar if the URL is empty
                            ),
                            title: Text(
                              docs[index]['name'].toString(),
                              style: TextStyle(
                                fontFamily: 'Arima',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              docs[index]['email'].toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Arima",
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              '12:30 PM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        ),
        ),
            /// status part
            Container(
              height: 100,
              color: Colors.grey[300],
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc('status')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final statusData = snapshot.data!.data();
                    if (statusData != null) {
                      final statusText = statusData['status'];
                      final statusTime = statusData['time'];

                      return ListTile(
                        leading: CircleAvatar(
                          // Add your user's profile picture here
                        ),
                        title: Text('My Status'),
                        subtitle: Text(statusText),
                        trailing: Text(statusTime),
                      );
                    }
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
