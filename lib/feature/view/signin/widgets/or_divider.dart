import 'package:flutter/cupertino.dart';
import 'package:mapsuygulama/product/utils/const/color_const.dart';


class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: ProjectColors().kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: ProjectColors().kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
