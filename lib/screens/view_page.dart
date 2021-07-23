import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:rubber/rubber.dart';

class ViewPageScreen extends StatefulWidget {
  const ViewPageScreen({
    Key? key,
    @required this.backgroundColor,
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.image1,
    @required this.image2,
    @required this.heroTag,
  }) : super(key: key);
  final backgroundColor, title, author, description, image1, image2, heroTag;

  @override
  _ViewPageScreenState createState() => _ViewPageScreenState();
}

class _ViewPageScreenState extends State<ViewPageScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  RubberAnimationController? _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      changeStatusColor(widget.backgroundColor);
    });

    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(percentage: 0.366),
        upperBoundValue: AnimationControllerValue(percentage: 0.600),
        springDescription: SpringDescription.withDampingRatio(
            mass: 0.7,
            stiffness: Stiffness.LOW,
            ratio: DampingRatio.MEDIUM_BOUNCY),
        duration: Duration(milliseconds: 300));
  }

  @override
  dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    List<Widget> _row1 = [
      myImageUi(3),
      myImageUi(2),
      myImageUi(1),
    ];

    List<Widget> _row2 = [
      myImageUi2('avengers'),
      myImageUi2('evilwar'),
      myImageUi2('million'),
    ];

    return Scaffold(
        body: SafeArea(
      child: RubberBottomSheet(
        dragFriction: 1,
        animationController: _controller!,
        lowerLayer: Container(
          height: _size.height,
          color: widget.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      changeStatusColor(Colors.white);
                    },
                    icon: Icon(
                      CupertinoIcons.chevron_down,
                      color: Colors.white,
                    )),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: widget.heroTag,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            widget.image2,
                            color: Colors.white,
                            height: 250,
                          ),
                          Image.asset(
                            widget.image1,
                            height: 200,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                ],
              ),
            ],
          ),
        ),
        upperLayer: Container(
          height: _size.height,
          width: _size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Padding(
              padding: EdgeInsets.only(top: 40, left: 40),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LATEST NEWS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: _row1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "RELATED MOVIES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: _row2,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  Widget myImageUi(int i) {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/image/movie$i.jpg',
          height: 100,
          width: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget myImageUi2(String name) {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/image/$name.jpg',
          height: 200,
          width: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
