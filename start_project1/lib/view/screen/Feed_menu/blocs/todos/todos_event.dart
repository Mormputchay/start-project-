part of 'todos_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  final List<NewFeed> todos;

  const LoadTodos({
    this.todos = const <NewFeed>[],
  });

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodoEvent {
  final String id;
  final NewFeed todo;

  const AddTodo({
    required this.id,
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final NewFeed todo;

  const UpdateTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final NewFeed todo;

  const DeleteTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
