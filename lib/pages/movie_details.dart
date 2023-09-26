import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Movie_details extends StatefulWidget {
  Movie_details({super.key});

  @override
  State<Movie_details> createState() => _Movie_detailsState();
}

class _Movie_detailsState extends State<Movie_details> {
  double? _deviceHeight;
  double? _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.yellow,
                width: _deviceWidth,
                height: _deviceHeight! * 0.5,
                child: Image.asset("assets/images/icons/Flick GO.png")),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Title(
                        color: Colors.black,
                        child: Text(
                          "Stranger Things",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                              AssetImage("assets/images/icons/heart.png"),size: 30,)),
                    ],
                  ),
                  Column(children: [
                    Text(
                      "In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries.",
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 105,
                        height: 28,
                        child: Text(
                          'Top Cast',
                          style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 18,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < 5; i++)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  color: Colors.brown.shade400,
                                  width: 75,
                                  child: Center(
                                    child: Text(
                                      (i + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 105,
                        height: 28,
                        child: Text(
                          "Rate This",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star_border,
                          size: 60,
                          color: Color(0xFF2196F3),
                        )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                          width: 281,
                          height: 91,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xfff3faff))),
                      Text("Write Your Review",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      Container(
                          width: 103,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff2196f3))),
                      Container(
                          width: 103,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6))),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Submit",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Back",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ],
                  )
                ],
              ),

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(60),
              //   boxShadow: [
              //     BoxShadow(color: Colors.white, spreadRadius: 30),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
