import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/data/repo/cart_repository.dart';

class ProfileSceen extends StatelessWidget {
  const ProfileSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        actions: [
          IconButton(
              onPressed: () {
                authRepository.signOut();
                CartRepository.cartItemCountNotifier.value = 0;
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 32, bottom: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 1)),
            child: Image.asset(
              'assets/images/nike_logo.png',
            ),
          ),
          const Text('shahrambabaei@gmail.com'),
          const SizedBox(
            height: 32,
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 56,
              child: Row(
                children: const <Widget>[
                  Icon(CupertinoIcons.heart),
                  SizedBox(
                    width: 15,
                  ),
                  Text('لیست علاقه مندی ها')
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 56,
              child: Row(
                children: const <Widget>[
                  Icon(CupertinoIcons.cart),
                  SizedBox(
                    width: 15,
                  ),
                  Text('   سوابق سفارش')
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          )
        ],
      )),
    );
  }
}
