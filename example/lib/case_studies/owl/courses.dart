import 'package:example/case_studies/owl/course_list_item.dart';
import 'package:example/case_studies/owl/logo/logo_widget.dart';
import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_palette/palette.dart';

class Courses extends StatelessWidget {
  const Courses({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Logo(logoSize: 125),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.topRight,
                child: Consumer(
                  builder: (context, ref, widget) {
                    ThemeNotifier theme = ref.watch(themeProvider);
                    return Icon(
                      Icons.account_circle_rounded,
                      size: 32,
                      color: theme.lightMode
                          ? theme.palette.primarySwatch.shade500
                              .foregroundColor()
                          : theme.palette.primarySwatch.dark.surface00dp
                              .foregroundColor(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const CourseListItem(
          'Geological Photos Of The Southwest',
          7,
          'https://cdn.pixabay.com/photo/2017/08/13/00/53/sand-2635875_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/11/18/19/07/happy-1836445__480.jpg',
        ),
        const SizedBox(height: 12),
        const CourseListItem(
          'Advanced Portraiture',
          18,
          'https://cdn.pixabay.com/photo/2016/11/29/05/46/young-woman-1867618__340.jpg',
          'https://cdn.pixabay.com/photo/2016/11/21/16/01/woman-1846127__480.jpg',
        ),
        const SizedBox(height: 12),
        const CourseListItem(
          'Monuments, Buildings, and Other Structures',
          12,
          'https://cdn.pixabay.com/photo/2019/10/17/13/31/vintage-4556913__480.jpg',
          'https://cdn.pixabay.com/photo/2017/08/07/14/15/portrait-2604283__480.jpg',
        ),
        const SizedBox(height: 12),
        const CourseListItem(
          'Photojournalism: Street Art',
          14,
          'https://cdn.pixabay.com/photo/2021/10/30/08/28/scooter-6753797__480.jpg',
          'https://cdn.pixabay.com/photo/2018/04/27/03/50/portrait-3353699__480.jpg',
        ),
        const SizedBox(height: 12),
        const CourseListItem(
          'Culinary Photography',
          15,
          'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590__480.jpg',
          'https://cdn.pixabay.com/photo/2018/04/04/10/11/woman-3289372__340.jpg',
        ),
        const SizedBox(height: 12),
        const CourseListItem(
          'The Micro Lens',
          3,
          'https://cdn.pixabay.com/photo/2016/04/16/12/50/chrysanthemum-1332994__480.jpg',
          'https://cdn.pixabay.com/photo/2018/02/16/14/38/portrait-3157821__480.jpg',
        ),
        const SizedBox(height: 125),
      ],
    );
  }
}
