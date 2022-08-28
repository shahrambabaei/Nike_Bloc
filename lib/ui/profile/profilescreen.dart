import 'package:flutter/material.dart';
import 'package:nike/data/repo/auth_repository.dart';



class ProfileSceen extends StatelessWidget {
  const ProfileSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileSceen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile'),
          ElevatedButton(
              onPressed: () {
                authRepository.signOut();
              },
              child: const Text('Sign Out'))
        ],
      )),
    );
  }
}
