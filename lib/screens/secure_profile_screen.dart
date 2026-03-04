import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecureProfileScreen extends StatefulWidget {
  const SecureProfileScreen({super.key});

  @override
  State<SecureProfileScreen> createState() => _SecureProfileScreenState();
}

class _SecureProfileScreenState extends State<SecureProfileScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  Future<void> _saveProfile() async {

    try {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Saved")),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Access Denied")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Secure Profile")),

      body: Column(
        children: [

          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),

          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: "Phone"),
          ),

          ElevatedButton(
            onPressed: _saveProfile,
            child: const Text("Save Profile"),
          ),
        ],
      ),
    );
  }
}