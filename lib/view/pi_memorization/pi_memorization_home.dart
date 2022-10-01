import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pickerController.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'package:flutter_pi_memorization/view/multiplication/course_card.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_pi_memorization/view/pi_memorization/pi_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pi_view_picker.dart';

class PiMemorizationHome extends ConsumerWidget {
  const PiMemorizationHome({Key? key}) : super(key: key);

  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerState = ref.watch(pickerProvider);
    return Scaffold(
      appBar: const HomeAppBar(title: Text("円周率")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(children: const [
                //円周率の各桁一覧表
                PiView(),

                PiViewPickerButton(),
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
                height: 120,
                onTap: null,
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
                            '挑戦回数〇回',
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
                onTap: null,
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
                            '挑戦回数０回',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '最高記録10桁',
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
