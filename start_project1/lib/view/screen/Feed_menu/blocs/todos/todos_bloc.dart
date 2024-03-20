import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todos_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }
  void _onLoadTodos(
    LoadTodos event,
    Emitter<TodosState> emit,
  ) {
    emit(TodosLoaded(todos: event.todos));
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodosState> emit,
  ) {
    final state = this.state;
    if (state is TodosLoaded) {
      final updatedTodos = List<NewFeed>.from(state.todos);
      updatedTodos.add(NewFeed(
          id: event.id,
          title: event.todo.title,
          dates: event.todo.dates,
          subtitle1: event.todo.subtitle1,
          subtitle2: event.todo.subtitle2,
          comment: event.todo.comment,
          view: event.todo.comment,
          image: event.todo.image));
      emit(
        TodosLoaded(
          todos: updatedTodos,
        ),
      );
    }
  }

  void _onDeleteTodo(
    DeleteTodo event,
    Emitter<TodosState> emit,
  ) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<NewFeed> todos = (state.todos.where((todo) {
        return todo.id != event.todo.id;
      })).toList();

      emit(TodosLoaded(todos: todos));
    }
  }

  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodosState> emit,
  ) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<NewFeed> todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();

      emit(TodosLoaded(todos: todos));
    }
  }
}
