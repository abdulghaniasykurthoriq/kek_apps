import 'package:kek_app/screens/main_screen.dart';
import 'package:kek_app/screens/profile_screen.dart';
import 'package:kek_app/screens/whatever.dart';
import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  bool _isHome = true;

  Widget customAppBar() {
    switch (_selectedIndex) {
      case 0:
        return AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultMargin),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dashboard',
                                style: redTextStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Perawat',
                                style: blueTextStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'Puskesmas',
                            style: blueTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              _selectedIndex = 2;
                              _isHome = false;
                            });
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/doctor_cewe.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

      case 1:
        return AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultMargin),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xffF9FAFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(Icons.menu, color: blueColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                          _isHome = false;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/doctor_cewe.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (_selectedIndex) {
        case 0:
          return const WahatEver();
        case 1:
          return const MainScreen();
        case 2:
          return const ProfileScreen();
        default:
          return const MainScreen();
      }
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), child: customAppBar()),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                semiGray,
              ],
              stops: const [0.3, 0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: body()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isHome ? Colors.blue : Colors.white,
        child: _isHome
            ? const Icon(
                Icons.home,
                key: Key('homeIcon'),
                color: Colors.white,
              )
            : const Icon(
                Icons.home,
                key: Key('otherIcon'),
                color: Colors.grey,
              ),
        onPressed: () {
          setState(() {
            _selectedIndex = 1;
            _isHome = true;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              _isHome = false;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
      ),
    );
  }
}
