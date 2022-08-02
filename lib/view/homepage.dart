import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/tic_tac_toe_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightSizedbox = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<TicTacToeController>(builder: (tictactoeController) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Color(0xFFFCF8E8),
              ),
              child: Column(
                children: [
                  SizedBox(height: heightSizedbox * 0.08),
                  Wrap(
                    children: const [
                      Text(
                        " TIC ",
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      Text(
                        " TAC ",
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94B49F)),
                      ),
                      Text(
                        " TOE ",
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSizedbox * 0.05),
                  tictactoeController.isLoading
                      ? const Text("loading...")
                      : Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 0.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            margin: const EdgeInsets.all(10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: int.parse(
                                          tictactoeController.inputSize)),
                              itemCount: tictactoeController.displayExoh.length,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    tictactoeController.tab(index);
                                    if (tictactoeController.flagShowDialog) {
                                      showAlertWinner(
                                          context, tictactoeController);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: tictactoeController
                                                  .displayExoh[index] ==
                                              ''
                                          ? Colors.grey.withOpacity(0.3)
                                          : tictactoeController
                                                      .displayExoh[index] ==
                                                  'o'
                                              ? Colors.orange.withOpacity(0.3)
                                              : Colors.purple.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        tictactoeController.displayExoh[index],
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  Wrap(
                    children: [
                      customButton("3", tictactoeController),
                      customButton("4", tictactoeController),
                      customButton("5", tictactoeController),
                      customButton("6", tictactoeController),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      tictactoeController.setListDisplay();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD57E7E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            " Restart ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSizedbox * 0.05),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

void showAlertWinner(
    BuildContext context, TicTacToeController tictactoeController) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
            Center(child: Text("The winner is ${tictactoeController.winner}")),
        actions: <Widget>[
          Center(
            child: TextButton(
              child:
                  const Text("OK", style: TextStyle(color: Color(0xFFD57E7E))),
              onPressed: () {
                tictactoeController.clearGridView();
                Get.back();
              },
            ),
          ),
        ],
      );
    },
  );
}

Widget customButton(String size, TicTacToeController ticTacToeController) {
  return GestureDetector(
    onTap: () {
      ticTacToeController.inputSizeController.text = size;
      ticTacToeController.generateGridview();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECB390),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            " $size x $size ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    ),
  );
}
