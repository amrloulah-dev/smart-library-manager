import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:librarymanager/app/app_router.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/features/auth/presentation/manager/auth_cubit.dart';
import '../core/theme/app_theme.dart';

class LibraryManagerApp extends StatefulWidget {
  const LibraryManagerApp({super.key});

  @override
  State<LibraryManagerApp> createState() => _LibraryManagerAppState();
}

class _LibraryManagerAppState extends State<LibraryManagerApp> {
  late final AuthCubit _authCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _appRouter = AppRouter(_authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // iPhone X base
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Smart Library',
            debugShowCheckedModeBanner: false,
            // Ensure theme is passed
            theme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: _appRouter.router,
          );
        },
      ),
    );
  }
}
