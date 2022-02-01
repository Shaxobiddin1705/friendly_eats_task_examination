import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver  {
  List myList = [];
  ScrollController _scrollController = ScrollController();
  int _currentMax = 6;

  List images = [
    "assets/images/img_0.jpg", "assets/images/img_1.jpg", "assets/images/img_2.jpg",
    "assets/images/img_3.jpg", "assets/images/img_4.jpg", "assets/images/img_5.jpg",
    "assets/images/img_6.jpg", "assets/images/img_7.jpg", "assets/images/img_8.jpg",
    "assets/images/img_0.jpg", "assets/images/img_1.jpg", "assets/images/img_2.jpg",
    "assets/images/img_0.jpg", "assets/images/img_1.jpg", "assets/images/img_2.jpg",
    "assets/images/img_3.jpg", "assets/images/img_4.jpg", "assets/images/img_5.jpg",
    "assets/images/img_6.jpg", "assets/images/img_7.jpg", "assets/images/img_8.jpg",
    "assets/images/img_0.jpg", "assets/images/img_1.jpg", "assets/images/img_2.jpg",
  ];

  List names = [
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
    "Dinner SteakHouse", "Fire Hyper", "Deli Cious",
  ];

  List address = [
    "Uzbekistan", "Tajikistan", "Kazakistan",
    "America", "England", "Russia",
    "Spain", "Italian", "Brazil",
    "Uzbekistan", "Tajikistan", "Kazakistan",
    "America", "England", "Russia",
    "Spain", "Italian", "Brazil",
    "Uzbekistan", "Tajikistan", "Kazakistan",
    "America", "England", "Russia",
  ];

  @override
  void initState() {
    super.initState();
    myList = List.generate(_currentMax, (i) => images[i]);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    print(myList);
  }

  _getMoreData() {
    if(_currentMax+6 < images.length) {
      for (int i = _currentMax; i < _currentMax + 6; i++) {
        myList.add(images[i]);
      }
      _currentMax = _currentMax + 6;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final isPortrait =
        MediaQuery.of( context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Icon(Icons.restaurant),
        title: Text("FriendlyEats"),
        bottom: PreferredSize(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: Colors.white,
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const SizedBox(width: 10,),
                  const Icon(Icons.wifi),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const[
                       SizedBox(height: 5,),
                       Text("All Restaurants", style: TextStyle(fontWeight: FontWeight.bold),),
                       Text("by rating", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(0),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        controller: _scrollController,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: shortestSide < 600 ? 350 : 500,
            crossAxisCount: shortestSide < 600 ? 1 : 3,
          ),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            if(index==myList.length){
              return CupertinoActivityIndicator(animating: true, radius: 10,);
            }
            if(shortestSide < 600 && isPortrait) {
              return gridMobile(index);
            }
            return web(index);
          }
      ),
    );
  }

  Widget gridMobile(int index) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
                Image.asset(images[index], fit: BoxFit.cover, height: 230, width: MediaQuery.of(context).size.width,),
                const SizedBox(height: 15,),
                Container(child: Row(
                  children: [
                    Container(
                      child: Text(names[index], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                      width: MediaQuery.of(context).size.width * 0.78,
                    ),
                    Text("\$123")
                  ],
                )),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow,),
                      Icon(Icons.star, color: Colors.yellow,),
                      Icon(Icons.star, color: Colors.yellow,),
                      Icon(Icons.star_half_outlined, color: Colors.yellow,),
                      Icon(Icons.star_border_rounded, color: Colors.yellow,),
                    ],
                  ),
                ),
                const  SizedBox(height: 10,),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(names[index].split(" ").first, style: const TextStyle(color: Colors.grey),),
                      const  SizedBox(width: 3,),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      const  SizedBox(width: 3,),
                      Text(address[index], style: const TextStyle(color: Colors.grey),),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget web(int index) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            Image.asset(images[index], fit: BoxFit.cover, height: 350, width: MediaQuery.of(context).size.width,),
            const SizedBox(height: 15,),
            Container(child: Row(
              children: [
                Container(
                  child: Text(names[index], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                  width: 500,
                ),
                Text("\$123")
              ],
            )),
            Container(
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star, color: Colors.yellow,),
                  Icon(Icons.star_half_outlined, color: Colors.yellow,),
                  Icon(Icons.star_border_rounded, color: Colors.yellow,),
                ],
              ),
            ),
            const  SizedBox(height: 10,),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(names[index].split(" ").first, style: const TextStyle(color: Colors.grey),),
                  const  SizedBox(width: 3,),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  const  SizedBox(width: 3,),
                  Text(address[index], style: const TextStyle(color: Colors.grey),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
