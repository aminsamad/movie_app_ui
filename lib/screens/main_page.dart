import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_ui/widget/carousel_widget.dart';
import 'package:movie_app_ui/util/constans.dart';
import 'package:movie_app_ui/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    int _current = 0;

    final List<Widget> _children = [
      CarouselWidgetUI(
        backgroundColor: Constants.blueColor,
        bg1: Constants.spiderman1,
        bg2: Constants.spiderman2,
        heightImage1: 180,
        heightImage2: 210,
        title: Constants.spidermanTitle,
        author: Constants.spidermanAuthor,
        description: Constants.spidermanDescription,
        heroTag: Constants.spidermanHerTag,
      ),
      CarouselWidgetUI(
        backgroundColor: Constants.redColor,
        bg1: Constants.spiderman1,
        bg2: Constants.spiderman2,
        heightImage1: 180,
        heightImage2: 210,
        title: Constants.spidermanTitle,
        author: Constants.spidermanAuthor,
        description: Constants.spidermanDescription,
        heroTag: Constants.spidermanHerTag,
      ),
      CarouselWidgetUI(
        backgroundColor: Constants.orangeColor,
        bg1: Constants.ironman1,
        bg2: Constants.ironman2,
        heightImage1: 220,
        heightImage2: 200,
        title: Constants.ironmanTitle,
        author: Constants.ironmanAuthor,
        description: Constants.ironmanDescription,
        heroTag: Constants.ironmanHeroTag,
      ),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            CupertinoIcons.chevron_back,
            size: 25,
            color: iconColor,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                CupertinoIcons.search,
                color: iconColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MARVEL",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            shadows: [
                              BoxShadow(
                                  color: Color(0xFF502220).withOpacity(0.6),
                                  blurRadius: 5,
                                  offset: Offset(2, 0))
                            ]),
                      ),
                      Text(
                        "Super hero",
                        style: TextStyle(
                            color: Colors.grey[500]!.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                items: _children,
                options: CarouselOptions(
                    initialPage: 1,
                    viewportFraction: 0.9,
                    autoPlay: false,
                    height: 600,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                carouselController: _controller,
              ),
            ],
          ),
        ));
  }
}
