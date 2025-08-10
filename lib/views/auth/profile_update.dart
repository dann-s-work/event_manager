import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/custom_widgets/filed_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});
@override
  State<ProfileUpdate> createState()=> _ProfileUpdateState();
}
  
class _ProfileUpdateState extends State<ProfileUpdate> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final profileNameController = TextEditingController();
  final profileAddressController = TextEditingController();
  final profilePhoneController = TextEditingController();
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  Future<void> _loadUserData()async{
    User? user =_auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        profileNameController.text= doc['name'] ??'';
        profileAddressController.text= doc['address'] ?? '';
        profilePhoneController.text = doc['phonenumber']?? '';
        
      }
    }
    setState(() {
      isloading = false;
    });
  }
  Future<void> updateprofile()async{
    User? user = _auth.currentUser;
    if (user!=null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot snapshot = await userDoc.get();
      if (snapshot.exists) {
        await userDoc.update({
          'name':profileNameController.text,
          'address':profileAddressController.text,
          'phonenumber': profilePhoneController.text,
        });
      } else{
        await userDoc.set({
          'name':profileNameController.text,
          'address': profileAddressController.text,
          'phonenumber':profilePhoneController.text,
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated Successfully')));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Profile Update'),),
      body: isloading?Center(child: CircularProgressIndicator(),):
      Padding(padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          appTextField(controller: profileNameController, label:'Name', icon: Icons.person, hint: 'Enter Name here'),
          appTextField(controller: profileAddressController, label: 'Address', icon: Icons.location_city, hint: 'Enter Your Address here'),
          appTextField(controller: profilePhoneController, label: 'Phone Number', icon: Icons.call,hint: 'Enter Your Phone Number here'),
          ElevatedButton(onPressed: updateprofile, child: Text("Save Changes")),
        ],
      ),
      ),
      
      );
    
  }
}