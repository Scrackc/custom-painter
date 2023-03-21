import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/slideshow.dart';

class SlideShowScreen extends StatelessWidget {
   
  const SlideShowScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: MySlideShow()),
          Expanded(child: MySlideShow()),
        ],
      ),
    );
  }
}

class MySlideShow extends StatelessWidget {
  const MySlideShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlidesShow(
      primaryColor: Colors.red,
      bulletPrimary: 15,
      bulletSecondaty: 12,
      slides: [
         SvgPicture.asset('assets/svg/1.svg'),
         SvgPicture.asset('assets/svg/2.svg'),
         SvgPicture.asset('assets/svg/3.svg'),
         Text('Hola')
      ],
    );
  }
}