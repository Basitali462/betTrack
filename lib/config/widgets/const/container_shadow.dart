import 'package:flutter/cupertino.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';

List<BoxShadow> containerShadow = [
  BoxShadow(
      color: AppTheme.greyColor.withOpacity(0.5),
      offset: Offset(0.5, 0.5),
      blurRadius: 0
  ),
  BoxShadow(
      color: AppTheme.greyColor.withOpacity(0.5),
      offset: Offset(-0.5, -0.5),
      blurRadius: 0
  ),
];