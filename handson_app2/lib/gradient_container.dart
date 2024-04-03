import 'package:flutter/material.dart';

class StyledText extends StatelessWidget{
  const StyledText(this.text, {super.key});
  
  final String text;

  @override
  Widget build(context){
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 28),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(230, 212, 159, 159),
          Color.fromARGB(175, 125, 15, 15) 
      ])),
      child: Center(
        //child: StyledText("HAAAIIII"),
        child: Image.asset(
          'assets/images/dice-images/dice-3.png',
          width: 200,
        ),
      ),
    );
  }
}
