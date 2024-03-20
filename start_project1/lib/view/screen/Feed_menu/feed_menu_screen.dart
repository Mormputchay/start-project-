import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_project1/color.dart';
import 'package:start_project1/view/screen/Feed_menu/blocs/todos/todos_bloc.dart';
import 'package:start_project1/view/screen/Feed_menu/blocs/todos_status/todos_status_bloc.dart';
import 'package:start_project1/view/screen/Feed_menu/models/todos_model.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/builder_appbar_feed_menu.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/model_boot_sheet_meun.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/text_dates_row_meun.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/text_title_row_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: TColor.primary,
        appBar: BuildAppBarFeedMeun(),
        body: BlocBuilder<TodosStatusBloc, TodosStatusState>(
          builder: (context, state) {
            if (state is TodosStatusLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodosStatusLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _todo(
                      state.pendingTodos,
                      'Pending',
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }

  Column _todo(List<NewFeed> todos, String status) {
    final listKey = GlobalKey<AnimatedListState>();
    return Column(
      children: [
        AnimatedList(
          key: listKey,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          initialItemCount: todos.length,
          itemBuilder: (context, int index, animation) {
            return _todosCard(context, todos[index]);
          },
        ),
        ElevatedButton(
            onPressed: () {
              var todo = NewFeed(
                  id: todos.last.id,
                  title: 'Avary Cyrus',
                  dates: '2022-Jan-12',
                  subtitle1: 'Only Love Can Hurt',
                  comment: '3.6K Comments',
                  subtitle2: 'MJ VS Sokchan Rap',
                  view: '23.6K Views',
                  image: todos.last.image);
              context.read<TodosBloc>().add(AddTodo(todo: todo, id: todo.id));
            },
            child: const Text('Add'))
      ],
    );
  }

  Widget _todosCard(
    BuildContext context,
    NewFeed todo,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(children: [
        SizedBox(
          width: double.maxFinite,
          height: 240,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text_Title_Row_Menu(
                    title: todo.title,
                    icon: "assets/svg/profile.svg",
                    onPress: () {}),
                Text_Dates_Row_Meun(
                    date: todo.dates,
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return ModelBootSheet(
                                newFeed: todo, context: context);
                          });
                    },
                    icon: "assets/images/more.png"),
              ],
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              color: TColor.red,
                              strokeWidth: 4,
                            ),
                          ),
                          imageUrl: todo.image.toString(),
                          height: 180,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              todo.subtitle1.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              todo.comment.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todo.subtitle2,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    todo.view,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
