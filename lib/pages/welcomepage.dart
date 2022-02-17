import 'package:flutter/material.dart';
import 'package:insulin/pages/login.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List images = ['images/Welcome Page.png', 'images/banner.jpg'];
  int changeindex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: PageView.builder(
                      onPageChanged: (val) {
                        setState(() {
                          changeindex = val;
                        });
                      },
                      itemCount: images.length,
                      itemBuilder: (context, index) => Container(
                          height: height * .4, child: image(images[index]))),
                )),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.all(1),
                            child: changepage(index),
                          )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 15),
                          child: Text(
                            'Need Some Help with your\n Dose ?',
                            style: TextStyle(
                                fontFamily: 'Public Sans',
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We can record and manage\n your insulin doses for you',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Image.asset(
                      'images/slid.png',
                      height: 140,
                      fit: BoxFit.fitHeight,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 50,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent.shade700,
                                shape: CircleBorder()),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  AnimatedContainer changepage(int index) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: (changeindex == index)
              ? Colors.blueAccent.shade700
              : Colors.white,
          border: Border.all(color: Colors.blueAccent.shade700),
          borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget image(String name) {
    return Image.asset(
      name,
      fit: BoxFit.cover,
    );
  }
}
