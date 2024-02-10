import 'package:re3aity/User/CustomDrawer/Drawer_Item.dart';

class DrawerItems {
  static final sections =
      DrawerItem(title: "الأقسام", imgSrc: "assets/icons/section.png");
  static final myReservation =
      DrawerItem(title: "حجوزاتي", imgSrc: "assets/icons/reservation.png");
  static final terms = DrawerItem(
      title: "الشروط والأحكام", imgSrc: "assets/icons/copyright.png");
  static final privacyPolicy = DrawerItem(
      title: "سياسة الخصوصية", imgSrc: "assets/icons/privacypolicy.png");
  static final logout =
      DrawerItem(title: "تسجيل الخروج", imgSrc: "assets/icons/logout.png");

  static final List<DrawerItem> all = [
    sections,
    myReservation,
    terms,
    privacyPolicy,
    logout,
  ];
}
