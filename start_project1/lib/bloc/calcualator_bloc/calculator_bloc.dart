// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculatorEqualEvent>((event, emit) async {
      List<String> parts = event.data.split(RegExp(r'[+\-*/%]'));
      List<int> numbers = parts.map(int.parse).toList();
      List<String> operators = event.data
          .split(RegExp(r'\d+'))
          .where((element) => element.isNotEmpty && element.trim().length == 1)
          .toList();
      operators = operators.map((operator) => operator.trim()).toList();

      num result = performCalculation(event.data, numbers, operators);
      emit(CalculatorSuccessState(data: result.toString()));
    });
  }
}

num performCalculation(String data, List<int> numbers, List<String> operators) {
  num result = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    String operator = operators[i - 1];
    if (operator == '+') {
      result += numbers[i];
    } else if (operator == '-') {
      result -= numbers[i];
    } else if (operator == '*') {
      result *= numbers[i];
    } else if (operator == '/') {
      result /= numbers[i];
    }
  }
  return result;
}
