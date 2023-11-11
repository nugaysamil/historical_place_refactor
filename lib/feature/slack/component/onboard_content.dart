import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.descripton,
  });

  final String imageUrl;
  final String title;
  final String descripton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Lottie.network(
            height: 200,
            width: 200,
            imageUrl,
          ),
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 16),
        Text(
          descripton,
          textAlign: TextAlign.center,
        ),
        Spacer()
      ],
    );
  }
}