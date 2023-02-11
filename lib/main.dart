import 'package:flutter/material.dart';
import 'package:simple_note_app/constant.dart';
import 'package:simple_note_app/view/note_page/note_page_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/notebloc/note_bloc.dart';
import 'logic/searchbloc/search_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Note',
        theme: ThemeData.dark().copyWith(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: bodyTextColor)
              .copyWith(
                bodyText1: const TextStyle(color: bodyTextColor),
                bodyText2: const TextStyle(color: bodyTextColor),
              ),
        ),
        home: const NotePageMain(),
      ),
    );
  }
}
