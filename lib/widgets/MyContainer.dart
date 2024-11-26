import 'package:flutter/material.dart';

class myContainer extends StatelessWidget {
  const myContainer({super.key, required this.child, this.isBtn = false, this.function, this.margin, this.color});
  const myContainer.button({super.key, required this.child, this.isBtn = true, required this.function, this.margin, this.color});

  final EdgeInsets? margin;
  final Color? color;
  final VoidCallback? function;
  final bool isBtn;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: !isBtn ? const Alignment(0, -1) : const Alignment(-1.0, 0),
              end:!isBtn ? const Alignment(0, 0) : const Alignment(1.0, 0),
              colors: const <Color>[
                Color.fromRGBO(185, 235, 255, 1.0),
                Color.fromRGBO(145, 224, 255, 1.0),
                Color.fromRGBO(85, 206, 255, 1.0),
                Colors.lightBlueAccent,
              ]
          )
      ),
      child: !isBtn ? Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color?? const Color(0xFFF3F3F3),
        ),
        child: child,
      ) :
      ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color(0x00000000)),
              shadowColor: MaterialStatePropertyAll<Color>(Color(0x00000000))
          ),
          onPressed: function,
          child: child
      ),
    );
  }
}
