import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_project1/view/screen/Feed_menu/blocs/blocs.dart';
import 'package:start_project1/view/screen/Feed_menu/feed_menu_screen.dart';
import 'package:start_project1/view/screen/Feed_menu/models/todos_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(
                todos: [
                  NewFeed(
                      id: '1',
                      title: 'Avary Cyrus',
                      dates: '2022-Jan-12',
                      subtitle1: 'Only Love Can Hurt',
                      comment: '3.6K Comments',
                      subtitle2: 'MJ VS Sokchan Rap',
                      view: '23.6K Views',
                      image:
                          'https://www.sweetwater.com/insync/media/2020/04/Karaoke-Buying-Guide-Featured-Image.jpg'),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodosStatusBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          )..add(const UpdateTodosStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'BloC Pattern - Todos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
