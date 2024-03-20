import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_project1/view/screen/Feed_menu/blocs/todos/todos_bloc.dart';
import 'package:start_project1/view/screen/Feed_menu/models/todos_model.dart';

part 'todos_status_event.dart';
part 'todos_status_state.dart';

class TodosStatusBloc extends Bloc<TodosStatusEvent, TodosStatusState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosStatusBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosStatusLoading()) {
    on<UpdateTodosStatus>(_onUpdateTodosStatus);

    _todosSubscription = _todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(
          UpdateTodosStatus(todos: state.todos),
        );
      }
    });
  }

  void _onUpdateTodosStatus(
    UpdateTodosStatus event,
    Emitter<TodosStatusState> emit,
  ) {
    List<NewFeed> pendingTodos = event.todos
        .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
        .toList();
    List<NewFeed> completedTodos = event.todos
        .where((todo) => todo?.isCompleted == true && todo.isCancelled == false)
        .toList();
    List<NewFeed> cancelledTodos =
        event.todos.where((todo) => todo.isCancelled == false).toList();

    emit(
      TodosStatusLoaded(
        pendingTodos: pendingTodos,
        completedTodos: completedTodos,
        cancelledTodos: cancelledTodos,
      ),
    );
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
