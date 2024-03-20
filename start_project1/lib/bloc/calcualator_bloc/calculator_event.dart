part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class CalculatorEqualEvent extends CalculatorEvent {
  final String data;
  CalculatorEqualEvent({required this.data});
}
