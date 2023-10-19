import 'package:flutter/material.dart';

import '../../feature/screens/login_screen/components/login_screen.dart';

class SlackScreen extends StatefulWidget {
  const SlackScreen({Key? key}) : super(key: key);

  @override
  _SlackScreenState createState() => _SlackScreenState();
}

class _SlackScreenState extends State<SlackScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 15.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isGestureDetectorVisible = true;
        });
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isGestureDetectorVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.darken),
            child: Image.asset(
              'assets/peakpx.jpg',
              fit: BoxFit.fill,
              height: double.infinity,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 560, right: 5),
                child: Center(
                  child: Container(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 15.0, end: 20.0),
                      duration: Duration(seconds: 1),
                      builder:
                          (BuildContext context, double? value, Widget? child) {
                        return Opacity(
                          opacity: _animation.value / 20.0,
                          child: Text(
                            'Welcome To Historical Place',
                            style: TextStyle(
                              fontSize: value,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _isGestureDetectorVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => LoginScreen()),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Lets Go',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
