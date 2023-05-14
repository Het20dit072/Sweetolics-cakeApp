import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';

class PetsImage extends StatefulWidget {
  PetsImage({
    Key? key,
  }) : super(key: key);

  @override
  State<PetsImage> createState() => _PetsImageState();
}

String? url;
String? di;
String? url2;
String? di2;
String? url3;
String? di3;
File? pickedImage;
bool image_pick = true;
File? imageFile;
final _formKey = GlobalKey<FormState>();
var firebaseInstance;
var scaffoldKey = GlobalKey<ScaffoldState>();

class _PetsImageState extends State<PetsImage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;

  final ImagePicker _picker = ImagePicker();
  imagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: Colors.white,
              height: 210,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Pic Image From",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print('yes it runs');
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            if (pickedFile != null) {
                              _photo = File(pickedFile.path);
                              if (_photo == null) return;
                              final fileName = basename(_photo!.path);
                              final destination = 'Add_cake/$fileName';
                              try {
                                final ref = firebase_storage
                                    .FirebaseStorage.instance
                                    .ref(destination)
                                    .child('Add_cake/');

                                ref.putFile(_photo!);
                              } catch (e) {
                                print('error occured');
                              }
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("CAMERA"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print('yes it runs');
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);

                          setState(() {
                            if (pickedFile != null) {
                              _photo = File(pickedFile.path);
                              if (_photo == null) return;
                              final fileName = basename(_photo!.path);
                              final destination = 'Add_cake/$fileName';
                              try {
                                final ref = firebase_storage
                                    .FirebaseStorage.instance
                                    .ref(destination)
                                    .child('Add_cake/');

                                ref.putFile(_photo!);
                              } catch (e) {
                                print('error occured');
                              }
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("CANCEL"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }

  Future imgFromGallery(ImageSource gallery) async {}

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {}
//for image 2

  File? _photo2;

  final ImagePicker _picker2 = ImagePicker();

  Future imgFromGallery2(ImageSource gallery) async {
    final pickedFile = await _picker2.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo2 = File(pickedFile.path);
        uploadFile2();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera2() async {
    final pickedFile = await _picker2.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo2 = File(pickedFile.path);
        uploadFile2();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile2() async {
    if (_photo2 == null) return;
    final fileName = basename(_photo2!.path);
    final destination = 'Add_cake/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('Add_cake/');
      await ref.putFile(_photo2!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 114, 180, 255),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Add Images',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Color(0xffcaf0f8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 220, top: 25),
                        child: Text(
                          "Cake Image 1 :",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: _photo != null
                                    ? Image.file(
                                        _photo!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/cake.png",
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          InkWell(
                            onTap: () {
                              imagePickerOptions(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.9,
                                height: 70,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        offset: Offset(0, 0),
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xff646cd9), width: 2)),
                                child: Center(
                                    child: Text(
                                  'pick cake image ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w400),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 210, top: 25),
                        child: Text(
                          "cake Image 2 :",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: _photo2 != null
                                    ? Image.file(
                                        _photo2!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/cake.png",
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        child: Container(
                                          color: Colors.white,
                                          height: 210,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Pic Image From",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      imgFromCamera2();
                                                    },
                                                    icon: const Icon(
                                                        Icons.camera),
                                                    label: const Text("CAMERA"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      imgFromGallery2(
                                                          ImageSource.gallery);
                                                    },
                                                    icon:
                                                        const Icon(Icons.image),
                                                    label:
                                                        const Text("GALLERY"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                    label: const Text("CANCEL"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.9,
                                height: 70,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        offset: Offset(0, 0),
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xff646cd9), width: 2)),
                                child: Center(
                                    child: Text(
                                  'Upload image 2',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w400),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 2.0,
            backgroundColor: Color.fromARGB(255, 114, 180, 255),
            onPressed: () async {
              User? user = await FirebaseAuth.instance.currentUser;
              Reference ref = storage
                  .ref()
                  .child('cakes')
                  .child(user!.uid)
                  .child('cake1.jpg');
              UploadTask uploadTask = ref.putFile(_photo!);
              TaskSnapshot taskSnapshot =
                  await uploadTask.whenComplete(() => null);
              String downloadUrl = await taskSnapshot.ref.getDownloadURL();

              FirebaseFirestore.instance
                  .collection("cakesdetails")
                  .doc(user.uid) //add ! this
                  .update({
                'cake Image1': downloadUrl,
              });

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Icon(
              Icons.arrow_right_alt,
              size: 42,
            ),
          ),
        ),
      ),
    );
  }
}
