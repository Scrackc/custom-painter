import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidesShow extends StatelessWidget {
  final List<Widget> slides;
  final bool topIndicator;
  final Color primaryColor;
  final Color secondaryColor;
  final double bulletPrimary;
  final double bulletSecondaty;

  const SlidesShow(
      {super.key,
      required this.slides,
      this.topIndicator = false,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey,
      this.bulletPrimary = 12,
      this.bulletSecondaty = 12});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideshowModel>(context).primaryColor = primaryColor;
              Provider.of<_SlideshowModel>(context).secondaryColor =
                  secondaryColor;
              Provider.of<_SlideshowModel>(context).bulletPrimary =
                  bulletPrimary;
              Provider.of<_SlideshowModel>(context).bulletSecondary =
                  bulletSecondaty;

              return _CreateScructSlideshow(
                  topIndicator: topIndicator, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CreateScructSlideshow extends StatelessWidget {
  const _CreateScructSlideshow({
    super.key,
    required this.topIndicator,
    required this.slides,
  });

  final bool topIndicator;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (topIndicator) _Dots(length: slides.length),
        Expanded(child: _Slides(slides)),
        if (!topIndicator) _Dots(length: slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int length;

  const _Dots({required this.length});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (index) => _Dot(index))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);
  

  @override
  Widget build(BuildContext context) {
    final slideProvider = Provider.of<_SlideshowModel>(context);
    double size = 0;
    Color color;

    if(slideProvider.currentPage >= index - 0.5 && (slideProvider.currentPage <= index + 0.5)){
      size = slideProvider.bulletPrimary;
      color = slideProvider.primaryColor;
    }else{
      size = slideProvider.bulletSecondary;
      color = slideProvider.secondaryColor;
    }
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page ?? 0;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        itemBuilder: (context, index) {
          return _Slide(slide: widget.slides[index]);
        },
        itemCount: widget.slides.length,
        controller: pageViewController,
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide({
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _bulletPrimary = 12;
  double _bulletSecondary = 12;

  double get currentPage => _currentPage;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;
  set primaryColor(Color value) {
    _primaryColor = value;
  }

  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color value) {
    _secondaryColor = value;
  }

  double get bulletPrimary => _bulletPrimary;
  set bulletPrimary(double value) {
    _bulletPrimary = value;
  }

  double get bulletSecondary => _bulletSecondary;
  set bulletSecondary(double value) {
    _bulletSecondary = value;
  }
}
