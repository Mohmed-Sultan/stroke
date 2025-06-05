import 'package:flutter/material.dart';

class BadResult extends StatelessWidget {
  const BadResult({super.key, required this.probability});

  final double probability;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/bad.png"),
          SizedBox(height: 15,),
          Row(
            children: [
              Text('High risk of stroke. Probability : '),
              Text("$probability")
            ],
          )
        ],
      ),
    );
  }
}
