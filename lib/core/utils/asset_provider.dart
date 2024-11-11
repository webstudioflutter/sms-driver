// ignore_for_file: non_constant_identifier_names

import '../constants/constant_path.dart';

class _AssetsImagesGen {
  const _AssetsImagesGen();

  String get Logo => '$kImagesPath/Logo.png';
  String get Profile => '$kImagesPath/profile.png';
}

class _AssetsSvgImagesGen {
  _AssetsSvgImagesGen();

  String get page_not_found => '$kSvgImagesPath/page_not_found.svg';
  String get blank => '$kSvgImagesPath/blank.svg';
  String get classes => '$kSvgImagesPath/class.svg';
  String get user => '$kSvgImagesPath/user.svg';
  String get home2 => '$kSvgImagesPath/home-2.svg';
  String get searchnormal => '$kSvgImagesPath/search-normal.svg';
  String get notification => '$kSvgImagesPath/notification.svg';
  String get notification2 => '$kSvgImagesPath/notification2.svg';
  String get location => '$kSvgImagesPath/location.svg';

  String get scheduledmaintenance =>
      '$kSvgImagesPath/scheduled-maintenance.svg';
  String get Component3 => '$kSvgImagesPath/Component3.svg';

  ///For Quick Access
  String get attendance => '$kSvgImagesPath/attendance.svg';
  String get fuel => '$kSvgImagesPath/fuel.svg';
  String get report => '$kSvgImagesPath/report.svg';
  String get servicing => '$kSvgImagesPath/servicing.svg';
  String get billupload => '$kSvgImagesPath/bill-upload.svg';
  String get studentlist => '$kSvgImagesPath/student-list.svg';
  String get notificationcopy => '$kSvgImagesPath/notificationcopy.svg';
  String get user2 => '$kSvgImagesPath/user2.svg';
  String get homecopy => '$kSvgImagesPath/homecopy.svg';
  String get Component4 => '$kSvgImagesPath/Component 4.svg';
}

class Assets {
  Assets._();
  static const images = _AssetsImagesGen();
  static var svgImages = _AssetsSvgImagesGen();
}
