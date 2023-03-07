import 'dart:math';
import 'package:flutter/material.dart';

class AnimacionesScreen extends StatelessWidget {
  const AnimacionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({super.key});

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    // rotacion = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(controller); Lineal
    rotacion = Tween(begin: 0.0, end: 2.0 * pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    opacidad = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0,
          0.25, // 1/4 del total de la duracion establecida en el controlador (Duration) por eso es .25
          curve: Curves.easeInOut,
        ),
      ),
    );
    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.75,
          1.0, // 1/4 del total de la duracion establecida en el controlador (Duration) por eso es .25
          curve: Curves.easeOut,
        ),
      ),
    );

    moverDerecha = Tween( begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceOut),
    );

    agrandar =Tween(begin: 0.0, end: 2.0).animate(
       CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.addListener(() {
      // print('status: ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        // controller.reverse();
        controller.reset();
      }
    });

    // controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Play / reproduccion
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangulo(),
      builder: (context, child) {
        // print('opacidad: ${opacidad.value}'); Nos podemos vasar en el valor de la animacion (cuando llega a su valor mas alto) para saber su estado. (Status termina al mismo tiempo por lo cual no nos podemos basar en el)
        return Transform.translate(
          offset: Offset(moverDerecha.value, 0),
          child: Transform.rotate(
              angle: rotacion.value,
              child: Opacity(
                opacity: opacidad.value - opacidadOut.value,
                child: Transform.scale(
                  scale: agrandar.value,
                  child: child,
                ),
              )),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  const _Rectangulo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
