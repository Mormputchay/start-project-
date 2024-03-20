import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_project1/bloc/calcualator_bloc/calculator_bloc.dart';

import '../Components/MyButton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var question = '0';
  var answer = '0';
  final List<String> buttons = [
    'C',
    'Del',
    '%',
    '/',
    '1',
    '2',
    '3',
    '*',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '+',
    '.',
    '0',
    '000',
    '=',
  ];

  late BuildContext myContext;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocProvider(
        create: (context) => CalculatorBloc(),
        child: Builder(
          builder: (context) {
            myContext = context;
            return BlocListener<CalculatorBloc, CalculatorState>(
              listener: (context, state) async {
                if (state is CalculatorLoadingState) {
                  // loadingDialog(context);
                } else if (state is CalculatorFailState) {
                  // errorDialog(context);
                } else if (state is CalculatorSuccessState) {
                  setState(() {
                    answer = state.data;
                  });
                }
              },
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: myWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(question,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          color: Colors.pinkAccent)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: myHeight * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: myWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    answer,
                                    style: const TextStyle(
                                        fontSize: 19, color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return buttons[index] == '/' ||
                                buttons[index] == 'x' ||
                                buttons[index] == '-' ||
                                buttons[index] == '+'
                            ? MyButtonOperator(
                                buttonTapped: () {
                                  if (question == '0') {
                                    question = '';
                                    setState(() {
                                      question += buttons[index];
                                    });
                                  } else {
                                    setState(() {
                                      question += buttons[index];
                                    });
                                  }
                                },
                                buttonText: buttons[index],
                              )
                            : buttons[index] == '='
                                ? MyButtonEqal(
                                    buttonTapped: () {
                                      equalPressed();
                                    },
                                    buttonText: buttons[index],
                                  )
                                : MyButtonNumber(
                                    buttonTapped: buttons[index] == ''
                                        ? null
                                        : () {
                                            if (buttons[index] == 'C') {
                                              setState(() {
                                                question = '0';
                                                answer = '0';
                                              });
                                            } else if (buttons[index] ==
                                                'Del') {
                                              setState(() {
                                                question = question.substring(
                                                    0, question.length - 1);
                                                setState(() {
                                                  answer = '0';
                                                });
                                              });
                                              if (question == '') {
                                                setState(() {
                                                  question = '0';
                                                  answer = '0';
                                                });
                                              }
                                            } else {
                                              if (question == '0') {
                                                question = '';
                                                setState(() {
                                                  question += buttons[index];
                                                });
                                              } else {
                                                setState(
                                                  () {
                                                    question += buttons[index];
                                                  },
                                                );
                                              }
                                            }
                                          },
                                    buttonText: buttons[index],
                                  );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  equalPressed() {
    myContext.read<CalculatorBloc>().add(
          CalculatorEqualEvent(data: question),
        );
  }
}
