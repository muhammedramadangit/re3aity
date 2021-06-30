
import 'package:lastre3ayty/Provider/Provider_Drawer/Provider_Drawer_Item.dart';

class ProviderDrawerItems {
  static final myReservation =
  ProviderDrawerItem(title: "حجوزاتي", imgSrc: "assets/icons/reservation.png");
  static final terms = ProviderDrawerItem(
      title: "الشروط والأحكام", imgSrc: "assets/icons/copyright.png");
  static final privacyPolicy = ProviderDrawerItem(
      title: "سياسة الخصوصية", imgSrc: "assets/icons/privacypolicy.png");
  static final logout =
  ProviderDrawerItem(title: "تسجيل الخروج", imgSrc: "assets/icons/logout.png");

  static final List<ProviderDrawerItem> all = [
    myReservation,
    terms,
    privacyPolicy,
    logout,
  ];
}
