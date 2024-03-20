part of 'todos_status_bloc.dart';

abstract class TodosStatusEvent extends Equatable {
  const TodosStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateTodosStatus extends TodosStatusEvent {
  final List<NewFeed> todos;

  const UpdateTodosStatus({this.todos = const <NewFeed>[]});

  @override
  List<Object> get props => [todos];
}
