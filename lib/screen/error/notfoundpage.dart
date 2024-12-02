import 'package:driver_app/core/utils/asset_provider.dart';
import 'package:driver_app/core/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgImages.page_not_found,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            ResponsiveText(
              "nodata",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
