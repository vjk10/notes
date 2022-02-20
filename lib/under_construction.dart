import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/theme/colors.dart';

class UnderConstruction extends StatefulWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  State<UnderConstruction> createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> {
  late Size screenSize;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      screenSize = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      width: 236.74073791503906,
                      height: 94,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 8.703703880310059,
                            left: 6.962963104248047,
                            child: Container(
                                width: 229.77777099609375,
                                height: 85.29629516601562,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(209, 209, 209, 1),
                                  border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    width: 2,
                                  ),
                                ))),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 229.77777099609375,
                                height: 85.29629516601562,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ))),
                      ])),
                  Positioned(
                    bottom: 25,
                    child: Text(
                      "Notes",
                      style: TextStyle(
                        color: grey,
                        fontFamily: 'Theme Font',
                        fontSize: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: LottieBuilder.asset(
                    "assets/lottie/under-construction.json",
                    alignment: Alignment.center,
                    width: screenSize.width / 4,
                    height: screenSize.width / 4,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "We might launch up here soon!",
                    style: TextStyle(
                      color: black,
                      fontFamily: 'Theme Font',
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
