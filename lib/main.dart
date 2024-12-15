import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moments/repositories/contracts/abs_moment_repository.dart';
import 'package:moments/repositories/databases/db_moment_repository.dart';
import 'package:moments/views/home/pages/main_page.dart';
import 'package:moments/core/resources/colors.dart';
import 'package:moments/core/resources/strings.dart';
import 'package:moments/views/moment/pages/moment_entry_page.dart';

import 'views/moment/bloc/moment_bloc.dart';

void main() {
  runApp(const Moments());
}

class Moments extends StatelessWidget {
  const Moments({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AbsMomentRepository>(create: (context) => DbMomentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MomentBloc>(create: (context) => MomentBloc(
            RepositoryProvider.of<AbsMomentRepository>(context)
          )),
        ],
        child: MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            initialRoute: '/',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case MainPage.routeName:
                  return MaterialPageRoute(builder: (_) => const MainPage());
                case MomentEntryPage.routeName:
                  final momentId = settings.arguments as String?;
                  return MaterialPageRoute(
                      builder: (_) => MomentEntryPage(momentId: momentId));
                default:
                  return MaterialPageRoute(builder: (_) => const MainPage());
              }
            }),
      ),
    );
  }
}
