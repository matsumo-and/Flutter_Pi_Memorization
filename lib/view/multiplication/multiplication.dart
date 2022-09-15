import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/model/exercise_course.dart';
import 'package:flutter_pi_memorization/view/multiplication/course_card.dart';

class Multiplication extends StatelessWidget {
  const Multiplication({Key? key}) : super(key: key);

  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('かけ算'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: _padding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '実戦コース',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          //本番用のかけ算コース
          const CourseCard(
            id: 1000,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: _padding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '演習コース',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          for (int i = 0; i < ExcersiseCourse.list().length; i++)
            CourseCard(
              id: ExcersiseCourse.list()[i].id,
            )
        ]),
      ),
    );
  }
}
