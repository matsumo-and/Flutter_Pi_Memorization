import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_best_record.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_store.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pickerController.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_pi_memorization/view/pi_memorization/pi_question.dart';
import 'package:flutter_pi_memorization/view/pi_memorization/pi_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/pi_memorization/pi_mode.dart';
import 'pi_view_picker.dart';

class PiMemorizationHome extends ConsumerStatefulWidget {
  const PiMemorizationHome({Key? key}) : super(key: key);

  @override
  ConsumerState<PiMemorizationHome> createState() => PiMemorizationHomeState();
}

class PiMemorizationHomeState extends ConsumerState<PiMemorizationHome> {
  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(7));

  late ScrollController childController;

  @override
  void initState() {
    super.initState();
    childController = ScrollController();
  }

  @override
  void dispose() {
    childController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickerState = ref.watch(pickerProvider);
    final challengesState = ref.watch(piArchivementProvider);
    final bestRecordsList = ref.watch(piBestRecordsListProvider);
    final bestRecord =
        bestRecordsList.isEmpty ? 0 : bestRecordsList.last.bestRecord ?? 0;

    return Scaffold(
      appBar: const HomeAppBar(title: Text("円周率")),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                //円周率の各桁一覧表
                PiView(controller: childController),

                //Pickerで桁数を決定する
                PiViewPickerButton(
                  onControllerReset: () {
                    //桁数を変更したときにスクロール位置を最初に戻すs
                    if (childController.hasClients) childController.jumpTo(0);
                  },
                )
              ]),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: _padding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'モード選択',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            TappableCard(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: ((BuildContext context) =>
                              const PiQuestion(mode: PiMode.excersize))));
                },
                border:
                    const RoundedRectangleBorder(borderRadius: _borderRadius),
                height: 120,
                margin: _padding,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '練習モード',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            '挑戦回数${challengesState.practiceChallenges}回',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                        ),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/pi_index.svg',
                              width: 24,
                              height: 24,
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            Text(
                                '${pickerState.digitsFrom} ~ ${pickerState.digitsTo} 桁'),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 15),
            TappableCard(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: ((BuildContext context) =>
                              const PiQuestion(mode: PiMode.act))));
                },
                border:
                    const RoundedRectangleBorder(borderRadius: _borderRadius),
                margin: _padding,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '本番モード',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            '挑戦回数${challengesState.realChallenges}回',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '最高記録$bestRecord桁',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                )),

            //最後までスクロールできるようセーフサイズ分の高さを確保
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
