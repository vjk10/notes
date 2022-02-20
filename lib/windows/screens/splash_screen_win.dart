import 'package:fluent_ui/fluent_ui.dart';
import 'package:notes/theme/colors.dart';
import 'package:notes/windows/widgets/notes_logo.dart';

class SplashScreenWin extends StatefulWidget {
  const SplashScreenWin({Key? key}) : super(key: key);

  @override
  State<SplashScreenWin> createState() => _SplashScreenWinState();
}

class _SplashScreenWinState extends State<SplashScreenWin> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Hero(
                tag: "logoTag",
                child: NotesLogoWin(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressBar(
                  backgroundColor: white.withOpacity(0.2),
                  activeColor: white,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Loading your notes",
                    style: TextStyle(
                      color: white,
                      fontFamily: 'Theme Black',
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
