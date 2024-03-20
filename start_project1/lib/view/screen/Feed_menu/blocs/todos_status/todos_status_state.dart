part of 'todos_status_bloc.dart';

abstract class TodosStatusState extends Equatable {
  const TodosStatusState();

  @override
  List<Object> get props => [];
}

class TodosStatusLoading extends TodosStatusState {}

class TodosStatusLoaded extends TodosStatusState {
  final List<NewFeed> pendingTodos;
  final List<NewFeed> completedTodos;
  final List<NewFeed> cancelledTodos;

  const TodosStatusLoaded({
    this.pendingTodos = const <NewFeed>[],
    this.completedTodos = const <NewFeed>[],
    this.cancelledTodos = const <NewFeed>[],
  });

  @override
  List<Object> get props => [
        pendingTodos,
        completedTodos,
        cancelledTodos,
      ];
}
