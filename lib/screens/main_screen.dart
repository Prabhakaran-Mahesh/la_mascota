import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/chat_screen.dart';
import 'package:la_mascota/screens/home_screen.dart';
import 'package:la_mascota/screens/myAd_screen.dart';
import 'package:la_mascota/screens/sellItems/seller_category_list.dart';

import 'account_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = "Main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget currentScreen = const HomeScreen();
  int _index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket:_bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
           Navigator.pushNamed(context, SellerCategoryListScreen.id);
        },
        elevation: 0.0,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.teal.shade50,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 0;
                        currentScreen = HomeScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==0 ? Icons.home : Icons.home_outlined,
                          color: _index==0 ? Theme.of(context).primaryColor : Colors.black,
                        ),
                        Text(
                            'HOME',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: _index==0 ? FontWeight.bold : FontWeight.normal,
                            color: _index==0 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                      ],

                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 1;
                        currentScreen = ChatScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==1 ? CupertinoIcons.chat_bubble_2_fill : CupertinoIcons.chat_bubble_2,
                    color: _index==1 ? Theme.of(context).primaryColor : Colors.black,),
                        Text(
                          'CHATS',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: _index==1 ? FontWeight.bold : FontWeight.normal,
                            color: _index==1 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                      ],

                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 2;
                        currentScreen = MyAdsScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==2 ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: _index==2 ? Theme.of(context).primaryColor : Colors.black,),
                        Text(
                          'MY PETS',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: _index==2 ? FontWeight.bold : FontWeight.normal,
                            color: _index==2 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                      ],

                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        _index = 3;
                        currentScreen = AccountScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index==3 ? CupertinoIcons.person_fill : CupertinoIcons.person,
                          color: _index==3 ? Theme.of(context).primaryColor : Colors.black,),
                        Text(
                          'PROFILE',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: _index==3 ? FontWeight.bold : FontWeight.normal,
                            color: _index==3 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                      ],

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
