import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopop/neopop.dart';
import 'package:notes/android/widgets/notes_loading.dart';
import 'package:notes/data/data.dart';
import 'package:notes/services/isar_db/boards_local_schema.dart';
import 'package:notes/theme/colors.dart';

class BoardsView extends StatefulWidget {
  const BoardsView({Key? key}) : super(key: key);

  @override
  State<BoardsView> createState() => _BoardsViewState();
}

class _BoardsViewState extends State<BoardsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: StaticData.isarDb.boardsLocals.watchLazy(),
          builder: (context, snapshot) {
            switch (snapshot.hasData) {
              case true:
                {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      {
                        return Container();
                      }

                    case ConnectionState.waiting:
                      {
                        return const NotesLoadingAndroid(strokeWidth: 2);
                      }
                    default:
                      {
                        return const NotesLoadingAndroid(strokeWidth: 2);
                      }
                  }
                }
              case false:
                {
                  return SafeArea(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/system error.svg"),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "no boards created!",
                            style: StaticData.t.textTheme.titleLarge?.copyWith(
                              fontFamily: 'Cirka',
                              color: popWhite500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          NeoPopTiltedButton(
                            isFloating: true,
                            onTapUp: () {},
                            onTapDown: () {
                              HapticFeedback.heavyImpact();
                            },
                            decoration: const NeoPopTiltedButtonDecoration(
                              color: Color.fromRGBO(255, 235, 52, 1),
                              plunkColor: Color.fromRGBO(255, 235, 52, 1),
                              shadowColor: Color.fromRGBO(36, 36, 36, 1),
                              showShimmer: true,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 70.0,
                                vertical: 15,
                              ),
                              child: Text(
                                'create your first board!',
                                style:
                                    StaticData.t.textTheme.bodyLarge?.copyWith(
                                  color: popBlack600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              default:
                {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/system_error.svg"),
                        Text(
                          "no boards created!",
                          style: StaticData.t.textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Cirka',
                          ),
                        ),
                        NeoPopTiltedButtonShimmer(
                            buttonDepth: 20,
                            color: manna500,
                            plunkColor: manna500,
                            duration: const Duration(seconds: 1),
                            shimmerWidth: 2,
                            child: Text(
                              "create your first board!",
                              style: StaticData.t.textTheme.bodyLarge,
                            ))
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
