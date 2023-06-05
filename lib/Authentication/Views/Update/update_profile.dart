
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  static const String id = "update_profile";

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseAuth currentUser = FirebaseAuth.instance;

  //--------------------------------imagepicker-------------------------

  File? _imageFile;
  String _uploadedImageUrl = '';

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

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
      final storageRef = storage.ref().child(
          'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Step 2: Get the uploaded image's URL
      if (snapshot.state == TaskState.success) {
        setState(() async {
          _uploadedImageUrl = await storageRef.getDownloadURL();
        });

        // Step 3: Save the image URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userCollectionRef =
          FirebaseFirestore.instance.collection('Users data');
          final currentUserDocRef = userCollectionRef.doc(user.uid);

          await currentUserDocRef.update({
            'imageurl': _uploadedImageUrl,
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
        FirebaseFirestore.instance.collection('users');
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

  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final userData = snapshot.data!.data();
                              if (userData != null &&
                                  userData is Map<String, dynamic>) {
                                final imageUrl = userData.containsKey('imageurl')
                                    ? userData['imageurl'] as String
                                    : '';
                                return Container(
                                  color: Colors.grey.shade50,
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      )
                                          : Placeholder(
                                        child: Text('NO IMAGE'),
                                        fallbackHeight: 200,
                                        fallbackWidth: 200,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                       SizedBox(
                         height: 5,
                       ),
                       TextButton(
                          onPressed: _pickImage,
                          child: Text("Add new photo"),
                        ),

                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.person_2_sharp,
                        color: Color(0xff323F4B),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Color(0xff323F4B),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 32.0),
                  Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var documentSnapshot = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .get();
                              if (documentSnapshot.exists) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user!.uid)
                                      .update({
                                    "name": _nameController.text.trim(),
                                    "phone": _phoneController.text.trim(),
                                    "imageurl": _uploadedImageUrl,
                                  });

                                  Fluttertoast.showToast(
                                    msg: "Profile updated successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                  );

                                  Navigator.pop(context);
                                } catch (error) {
                                  Fluttertoast.showToast(
                                    msg: "Failed to update profile",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                                  print('Error updating profile: $error');
                                }
                              }
                            }
                          },
                          child: Text(
                            'Update Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




/*
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatefulWidget {
  static const String id = "update_profile";
  @override
  _UpdateprofileState createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {

  final user = FirebaseAuth.instance.currentUser;
  FirebaseAuth currentUser = FirebaseAuth.instance;


  //--------------------------------imagepicker-------------------------

  File? _imageFile;
  String _uploadedImageUrl='';

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality:40);

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
      final storageRef = storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Step 2: Get the uploaded image's URL
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await storageRef.getDownloadURL();

        // Step 3: Save the image URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userCollectionRef = FirebaseFirestore.instance.collection('Users data');
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

  String imageUrl='';

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userCollectionRef = FirebaseFirestore.instance.collection('users');
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


  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();




  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),

                  Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final userData = snapshot.data!.data();
                              if (userData != null && userData is Map<String, dynamic>) {
                                final imageUrl = userData.containsKey('imageurl')
                                    ? userData['imageurl'] as String
                                    : '';

                                return Container(
                                  color: Colors.grey.shade50,
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(imageUrl, fit: BoxFit.cover)
                                          : Placeholder(
                                        child: Text('NO IMAGE'),
                                        fallbackHeight: 200,
                                        fallbackWidth: 200,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 5,
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.person_2_sharp,
                        color: Color(0xff323F4B),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Color(0xff323F4B),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),





                  SizedBox(height: 32.0),
                  Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Theme.of(context).primaryColor,
                      ),
                      child:  Center(
                        child: TextButton(
                          onPressed: () async {

                            if(formKey.currentState!.validate()) {
                              var documentSnapshot = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .get();
                              if (documentSnapshot.exists) {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user!.uid)
                                      .update({
                                    "name": _nameController.text.trim(),
                                    "phone": _phoneController.text.trim(),
                                    "imageurl" : imageUrl,

                                  });

                                  Fluttertoast.showToast(
                                    msg: "Profile updated successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => btmnavigation(),
                                  //   ),
                                  // );
                                } catch (e) {
                                  Fluttertoast.showToast(
                                    msg: "Failed to update field",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );

                                  print('Error is: $e');
                                }
                              }
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Arima',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
