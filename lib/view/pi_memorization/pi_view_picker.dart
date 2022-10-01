import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pickerController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PiViewPickerButton extends StatelessWidget {
  const PiViewPickerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: InkWell(
        onTap: (() {
          showCupertinoModalPopup(
              barrierDismissible: false,
              context: context,
              builder: (context) => const PiViewPicker());
        }),
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        child: Ink(
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/pi_index.svg',
                    width: 24,
                    height: 24,
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Consumer(builder: (context, ref, _) {
                    final int digitsFrom = ref.watch(pickerProvider).digitsFrom;
                    final int digitsTo = ref.watch(pickerProvider).digitsTo;
                    return Text('$digitsFrom ~ $digitsTo');
                  }),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PiViewPicker extends ConsumerStatefulWidget {
  const PiViewPicker({Key? key}) : super(key: key);

  @override
  ConsumerState<PiViewPicker> createState() => PiViewPickerState();
}

class PiViewPickerState extends ConsumerState<PiViewPicker> {
  static final List<int> optionListFrom =
      List.generate(20, (index) => index * 50 + 1);
  static final List<int> optionListTo =
      List.generate(20, (index) => (index + 1) * 50);

  static late FixedExtentScrollController controllerFrom;
  static late FixedExtentScrollController controllerTo;

  @override
  void initState() {
    super.initState();

    controllerFrom = FixedExtentScrollController();
    controllerTo = FixedExtentScrollController();

    //Stateの桁数までPickerの初期値を移動させる
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pickerState = ref.watch(pickerProvider);
      controllerFrom.jumpToItem(optionListFrom.indexOf(pickerState.digitsFrom));
      controllerTo.jumpToItem(optionListTo.indexOf(pickerState.digitsTo));
    });
  }

  @override
  void dispose() {
    controllerFrom.dispose();
    controllerTo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル')),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () {
                      ref.read(pickerProvider.notifier).set(
                            digitsFrom:
                                optionListFrom[controllerFrom.selectedItem],
                            digitsTo: optionListTo[controllerTo.selectedItem],
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('適用')),
              ),
            ],
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: controllerFrom,
                        itemExtent: 32.0,
                        onSelectedItemChanged: (_) {
                          //FromがToより大きくなったらToのポジションを変える
                          if (controllerFrom.selectedItem >
                              controllerTo.selectedItem) {
                            controllerTo
                                .jumpToItem(controllerFrom.selectedItem);
                          }
                        },
                        children: List<Widget>.generate(optionListFrom.length,
                            (int index) {
                          return Center(
                            child: Text(optionListFrom[index].toString()),
                          );
                        })),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: controllerTo,
                        itemExtent: 32.0,
                        onSelectedItemChanged: (_) {
                          //ToがFromより小さくなったらFromのポジションを変える
                          if (controllerFrom.selectedItem >
                              controllerTo.selectedItem) {
                            controllerFrom
                                .jumpToItem(controllerTo.selectedItem);
                          }
                        },
                        children: List<Widget>.generate(optionListTo.length,
                            (int index) {
                          return Center(
                            child: Text(optionListTo[index].toString()),
                          );
                        })),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
