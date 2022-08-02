import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TicTacToeController extends GetxController implements GetxService {
  final TextEditingController _inputSizeController = TextEditingController();
  TextEditingController get inputSizeController => _inputSizeController;

  List<String> _displayExoh = [];
  List<String> get displayExoh => _displayExoh;

  bool _ohTurn = false;
  bool get ohTurn => _ohTurn;

  bool _flagShowDialog = false;
  bool get flagShowDialog => _flagShowDialog;
  String _winner = '';
  String get winner => _winner;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void tab(int index) {
    if (displayExoh[index] == "") {
      if (ohTurn) {
        _displayExoh[index] = 'o';
      } else {
        _displayExoh[index] = 'x';
      }
      _ohTurn = !ohTurn;
      update();
      checkWinnerAll(index);
    }
  }

  // int _size = 3;
  String _inputSize = "1";
  String get inputSize => _inputSize;
  List<int> _firstColumn = [];
  List<int> get firstColumn => _firstColumn;
  List<int> _lastColumn = [];
  List<int> get lastColumn => _lastColumn;

  void setListDisplay() {
    _winner = '';
    _flagShowDialog = false;
    _ohTurn = false;
    if (_inputSizeController.text.isEmpty) {
      _inputSizeController.text = "3";
    }
    _inputSize = _inputSizeController.text.toString();
    int size = int.parse(_inputSize);
    int totalSize = size * size;
    int firstTemp = 0;
    int lastTemp = totalSize - 1;
    _displayExoh = [];
    _firstColumn = [];
    _lastColumn = [];
    for (int i = 0; i < totalSize; i++) {
      if (i == firstTemp) {
        _firstColumn.add(i);
        firstTemp += size;
      }
      _displayExoh.add('');
    }
    for (int i = totalSize - 1; i > 0; i--) {
      if (i == lastTemp) {
        _lastColumn.add(i);
        lastTemp -= size;
      }
    }
    update();
    // generateGridview();
  }

  void generateGridview() {
    setListDisplay();
    if (displayExoh.length != 0) {
      _isLoading = false;
    } else {
      _isLoading = true;
    }
    update();
  }

  void checkWinnerAll(int index) {
    bool _isWinner1 = false;
    int size = int.parse(inputSize);
    if (int.parse(inputSize) == 3) {
      checkWinner3x3();
    } else {
      bool isFirstColumn = firstColumn.contains(index);
      bool isLastColumn = lastColumn.contains(index);

      /// แนวตั้ง แถวแรก
      if (isFirstColumn) {
        //จิ้มอันแรก ท้ายสุด  //หลังมาหน้า
        ///แนวนอน  index 2 1 0
        if (displayExoh[index] == displayExoh[index + 1] &&
            displayExoh[index] == displayExoh[index + 2] &&
            // displayExoh[index] == displayExoh[index + 3] &&
            displayExoh[index] != '') {
          print("เย้");
          _isWinner1 = true;
        } else {
          int firstColLastRowIndex = (((size * size)) - size);
          // จิ้มแถวแรกแนวตั้ง 0 4 8  12
          if (index == 0) {
            if (displayExoh[index] == displayExoh[index + size] &&
                displayExoh[index] == displayExoh[index + (size * 2)] &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            }
          } else if (index == firstColLastRowIndex) {
            //ตัวแรกของแถวสุดท้าย 12 8 4 0
            print("firstColLastRowIndex");
            if (displayExoh[index] ==
                    displayExoh[firstColLastRowIndex - size] &&
                displayExoh[index] ==
                    displayExoh[firstColLastRowIndex - (size * 2)] &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            }
          } else {
            //จิ้มตัวตรงกลาง  หน้าหลัง หน้าๆ หลังๆ
            if (((displayExoh[index] == displayExoh[index + size] &&
                        displayExoh[index] == displayExoh[index - size]) ||
                    (displayExoh[index] == displayExoh[index + size] &&
                        displayExoh[index] ==
                            displayExoh[index + (size * 2)]) ||
                    (displayExoh[index] == displayExoh[index - size] &&
                        displayExoh[index] ==
                            displayExoh[index - (size * 2)])) &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            }
          }
        }
      } else if (isLastColumn) {
        int lastIndex = (size * size) - 1;
        if (displayExoh[index] == displayExoh[index - 1] &&
            displayExoh[index] == displayExoh[index - 2] &&
            displayExoh[index] != '') {
          _isWinner1 = true;
        } else if (index == size - 1) {
          //แถวหลัง จากบนสุด
          if (displayExoh[index] == displayExoh[index + size] &&
              displayExoh[index] == displayExoh[index + (size * 2)] &&
              displayExoh[index] != '') {
            _isWinner1 = true;
          }
        } else if (index == lastIndex) {
          //last Index
          if (displayExoh[index] == displayExoh[lastIndex - size] &&
              displayExoh[index] == displayExoh[lastIndex - (size * 2)] &&
              displayExoh[index] != '') {
            _isWinner1 = true;
          }
        } else {
          if (((displayExoh[index] == displayExoh[index + size] &&
                      displayExoh[index] == displayExoh[index - size]) ||
                  (displayExoh[index] == displayExoh[index + size] &&
                      displayExoh[index] == displayExoh[index + (size * 2)]) ||
                  (displayExoh[index] == displayExoh[index - size] &&
                      displayExoh[index] == displayExoh[index - (size * 2)])) &&
              displayExoh[index] != '') {
            _isWinner1 = true;
          }
        }
      } else {
        // จิ้มตรงกลาง   เช็คหน้าหลัง
        if (((displayExoh[index] == displayExoh[index + 1] &&
                    displayExoh[index] == displayExoh[index - 1]) ||
                (displayExoh[index] == displayExoh[index + 1] &&
                    displayExoh[index] == displayExoh[index + 2]) ||
                (displayExoh[index] == displayExoh[index - 1] &&
                    displayExoh[index] == displayExoh[index - 2])) &&
            displayExoh[index] != '') {
          _isWinner1 = true;
        } else {
          if (index - (size * 2) > 0) {
            if (displayExoh[index] == displayExoh[index - size] &&
                displayExoh[index] == displayExoh[index - (size * 2)] &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            } else {
              if (index + (size * 2) < (size * size)) {
                if (displayExoh[index] == displayExoh[index + size] &&
                    displayExoh[index] == displayExoh[index + (size * 2)] &&
                    displayExoh[index] != '') {
                  _isWinner1 = true;
                }
              }
            }
          } else if (index + (size * 2) < (size * size)) {
            if (displayExoh[index] == displayExoh[index + size] &&
                displayExoh[index] == displayExoh[index + (size * 2)] &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            }
          } else if ((index - size) > 0 && (index + size) < (size * size)) {
            //หน้าหลัง
            if (displayExoh[index] == displayExoh[index + size] &&
                displayExoh[index] == displayExoh[index - size] &&
                displayExoh[index] != '') {
              _isWinner1 = true;
            }
          }
        }
      }

      if (_isWinner1) {
        if (!ohTurn) {
          _winner = "O";
        } else {
          _winner = "X";
        }
        showDialog();
      }
      update();
    }
  }

  void checkWinner3x3() {
    bool _isWinner = false;

    /// นอน
    if (displayExoh[0] == displayExoh[1] &&
        displayExoh[0] == displayExoh[2] &&
        displayExoh[0] != '') {
      _isWinner = true;
    } else if (displayExoh[3] == displayExoh[4] &&
        displayExoh[3] == displayExoh[5] &&
        displayExoh[3] != '') {
      _isWinner = true;
    } else if (displayExoh[6] == displayExoh[7] &&
        displayExoh[7] == displayExoh[8] &&
        displayExoh[6] != '') {
      _isWinner = true;
    }

    ///ตั้ง
    else if (displayExoh[0] == displayExoh[3] &&
        displayExoh[0] == displayExoh[6] &&
        displayExoh[0] != '') {
      _isWinner = true;
    } else if (displayExoh[1] == displayExoh[4] &&
        displayExoh[1] == displayExoh[7] &&
        displayExoh[1] != '') {
      _isWinner = true;
    } else if (displayExoh[2] == displayExoh[5] &&
        displayExoh[2] == displayExoh[8] &&
        displayExoh[2] != '') {
      _isWinner = true;
    } else if (displayExoh[0] == displayExoh[4] &&
        displayExoh[0] == displayExoh[8] &&
        displayExoh[0] != '') {
      _isWinner = true;
    } else if (displayExoh[2] == displayExoh[4] &&
        displayExoh[2] == displayExoh[6] &&
        displayExoh[2] != '') {
      _isWinner = true;
    }
    if (_isWinner) {
      if (!ohTurn) {
        _winner = "O";
      } else {
        _winner = "X";
      }
      showDialog();
    }
    update();
  }

  void showDialog() {
    _flagShowDialog = true;
    update();
  }

  void clearGridView() {
    setListDisplay();
    _ohTurn = false;
    _flagShowDialog = false;
    update();
  }
}








