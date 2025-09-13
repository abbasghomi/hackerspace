import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/hacker_desktop.dart';
import 'bloc/hacker_bloc.dart';
import 'bloc/hacker_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1920, 1080),
    minimumSize: Size(800, 600),
    backgroundColor: Colors.black,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    fullScreen: true,
    alwaysOnTop: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setFullScreen(true);
    await windowManager.setAlwaysOnTop(false);
    await windowManager.setPreventClose(false);
  });

  runApp(const HackerSpaceApp());
}

class HackerSpaceApp extends StatelessWidget {
  const HackerSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HackerBloc()..add(InitializeSystem()),
      child: MaterialApp(
        title: 'HackerSpace Terminal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Courier',
        ),
        home: const HackerDesktop(),
      ),
    );
  }
}
