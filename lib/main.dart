import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venom_config/venom_config.dart';
import 'package:window_manager/window_manager.dart';

import 'core/colors/vaxp_colors.dart';
import 'presentation/app/vxo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await VenomConfig().init();
  VaxpColors.init();

  if (_usesDesktopWindowControls) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(390, 780),
      minimumSize: Size(360, 680),
      center: true,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const VxoApp());
}

bool get _usesDesktopWindowControls {
  if (kIsWeb) return false;

  return switch (defaultTargetPlatform) {
    TargetPlatform.linux ||
    TargetPlatform.macOS ||
    TargetPlatform.windows => true,
    _ => false,
  };
}
