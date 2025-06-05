import 'package:flutter/material.dart';

class GoodResult extends StatelessWidget {
  const GoodResult({super.key, required this.probability});

  final double probability;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/good_result.png"),
          SizedBox(height: 15,),
          Row(
            children: [
              Text('Low risk of stroke. Probability : '),
              Text("$probability")
            ],
          )
        ],
      ),
    );
  }
}
