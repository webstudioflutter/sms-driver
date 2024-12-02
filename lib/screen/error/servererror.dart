import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServerError extends StatelessWidget {
  const ServerError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SvgPicture.asset(
          Assets.svgImages.blank,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
