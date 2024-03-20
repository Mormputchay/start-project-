// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:start_project1/view/screen/Feed_menu/models/todos_model.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/boot_sheet_report.dart';
import 'package:start_project1/view/screen/Feed_menu/widget/button_menu_bootsheet.dart';

import '../blocs/todos/todos_bloc.dart';

class ModelBootSheet extends StatefulWidget {
  final NewFeed newFeed;
  final BuildContext context;

  const ModelBootSheet(
      {super.key, required this.newFeed, required this.context});

  @override
  State<ModelBootSheet> createState() => _ModelBootSheetState();
}

class _ModelBootSheetState extends State<ModelBootSheet> {
  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 265,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Button_Menu_BootSheet(
                  title: "My Favorite",
                  onPress: () {},
                  image: "assets/svg/favorite.svg"),
              const SizedBox(height: 10),
              Button_Menu_BootSheet(
                  title: "Share Video",
                  onPress: () async {
                    await Share.share(
                        "https://www.youtube.com/watch?v=u3R5vACg8oU");

                    Navigator.pop(context);
                  },
                  image: "assets/svg/share.svg"),
              const SizedBox(height: 10),
              Button_Menu_BootSheet(
                  title: "Hide Video",
                  onPress: () {
                    context.read<TodosBloc>().add(
                          DeleteTodo(
                            todo: widget.newFeed.copyWith(isCancelled: true),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  image: "assets/svg/hide_video.svg"),
              const SizedBox(height: 10),
              Button_Menu_BootSheet(
                  title: "Report Video",
                  onPress: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const BootSheetReport();
                        });
                  },
                  image: "assets/svg/report_video.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
