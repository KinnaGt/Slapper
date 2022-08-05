import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:josu_slapper/colors.dart';
import 'slapper.dart';

const pauseMenu = 'PauseMenu';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  final robertSlapper = RobertSlapper();
  runApp(
    GameWidget<RobertSlapper>(
      game: robertSlapper,
      initialActiveOverlays: [
        pauseMenu,
      ],
      overlayBuilderMap: {
        'PauseMenu': (context, game) {
          return PauseMenuOverlay(robertSlapper: game);
        },
      },
    ),
  );
}

class PauseMenuOverlay extends StatelessWidget {
  const PauseMenuOverlay({
    Key? key,
    required this.robertSlapper,
  }) : super(key: key);

  final RobertSlapper robertSlapper;

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Slapper',
      color: Colors.white,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 400,
          height: 340,
          decoration: BoxDecoration(
            color: RobertColors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Slapper',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  )),
              if (robertSlapper.sessionManager.score > 0)
                Text(robertSlapper.sessionManager.scoreComponent.text,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    )),
              Spacer(),
              Image.asset(
                'assets/images/Logo.png',
                height: 180,
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: RobertColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                ),
                onPressed: () {
                  robertSlapper.overlays.remove(pauseMenu);
                  robertSlapper.start();
    
                  robertSlapper.sessionManager.reset();
                },
                child: Text('Start Game'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
