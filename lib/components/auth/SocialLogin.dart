import 'package:flutter/material.dart';

import '../../theme/color.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text('HOẶC TIẾP TỤC VỚI', style: TextStyle(color: kTextColor.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 16)),

        const SizedBox(height: 25),

        Row(
          children: [

            const Spacer(),

            SizedBox(
                width: 43,
                height: 43,
                child: Image.asset(
                  'assets/images/gg.png',
                  width: double.infinity,
                  height: double.infinity,
                )
            ),

            const SizedBox(width: 30),

            SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/images/fb.png',
                  width: double.infinity,
                  height: double.infinity,
                )
            ),

            const Spacer()

          ],
        )

      ],
    );
  }
}
