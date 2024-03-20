part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoadingState extends CalculatorState {}

class CalculatorFailState extends CalculatorState {}

class CalculatorSuccessState extends CalculatorState {
  String data = '';
  CalculatorSuccessState({required this.data});
}
