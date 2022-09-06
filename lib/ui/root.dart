import 'package:flutter/material.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/cart/cart.dart';
import 'package:nike/ui/cart/widgest/badge.dart';
import 'package:nike/ui/home/homescreen.dart';
import 'package:nike/ui/profile/profilescreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const homeIndex = 0;
const cartIndex = 1;
const profileIndex = 2;

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  late Map<int, GlobalKey<NavigatorState>> map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey
  };
  Future<bool> _onWillPop() async {
    final NavigatorState currentNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(index: selectedScreenIndex, children: [
            _navigator(key: _homeKey, screen: const HomeScreen()),
            _navigator(key: _cartKey, screen: const CartScreen()),
            _navigator(key: _profileKey, screen: const ProfileSceen()),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedScreenIndex,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'خانه'),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      Positioned(
                          right: -10,
                          child: ValueListenableBuilder<int>(
                            valueListenable:
                                CartRepository.cartItemCountNotifier,
                            builder: (context, value, child) {
                              return Badge(value: value);
                            },
                          ))
                    ],
                  ),
                  label: 'سبدخرید'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined), label: 'پروفایل'),
            ],
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
          ),
        ));
  }

//_navigator
  Widget _navigator({required GlobalKey key, required Widget screen}) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => screen),
    );
  }
}
