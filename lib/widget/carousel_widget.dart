import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app_ui/screens/view_page.dart';
import 'package:movie_app_ui/util/constans.dart';
import 'package:page_transition/page_transition.dart';

final double circleRadius = 120.0;

class CarouselWidgetUI extends StatefulWidget {
  final backgroundColor, bg1, bg2, title, author, description, heroTag;
  final double? heightImage1;
  final double? heightImage2;
  const CarouselWidgetUI({
    Key? key,
    @required this.backgroundColor,
    @required this.bg1,
    @required this.bg2,
    @required this.heightImage1,
    @required this.heightImage2,
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.heroTag,
  }) : super(key: key);

  @override
  _CarouselWidgetUIState createState() => _CarouselWidgetUIState();
}

class _CarouselWidgetUIState extends State<CarouselWidgetUI> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double height = 180;
    return Stack(
      children: <Widget>[
        Container(
          height: _size.height / 1.5,
          width: _size.width,
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: height,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.raius, right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.author,
                style: TextStyle(fontSize: 22, color: Colors.white70),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              Spacer(),
              Center(
                child: Container(
                  width: _size.width,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              child: ViewPageScreen(
                                backgroundColor: widget.backgroundColor,
                                title: widget.title,
                                author: widget.author,
                                image1: widget.bg1,
                                image2: widget.bg2,
                                description: widget.description,
                                heroTag: widget.heroTag,
                              ),
                              type: PageTransitionType.bottomToTop,
                            ));
                      },
                      child: Icon(
                        CupertinoIcons.chevron_up,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        ),
        Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: Hero(
              tag: widget.heroTag,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    widget.bg2,
                    color: Colors.white,
                    height: widget.heightImage2,
                  ),
                  Image.asset(
                    widget.bg1,
                    height: widget.heightImage1,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
