import 'package:get/get.dart';
import 'package:sakinah/app/views/home_view.dart';
import 'package:sakinah/app/views/prayer_time_view.dart';
import 'package:sakinah/app/views/profile_view.dart';
import 'package:sakinah/app/views/qibla_view.dart';
import 'package:sakinah/app/views/quran_view/quran_listen_read_view.dart';
import 'package:sakinah/app/views/quran_view/quran_listen_view.dart';
import 'package:sakinah/app/views/quran_view/quran_read_view.dart';
import 'app_route.dart';

class AppPages {
  static final pages = [
    //GetPage(name: AppRoute.splash, page: () => const SplashView()),
    GetPage(name: AppRoute.home, page: () => HomeView()),
    GetPage(name: AppRoute.choosemode, page: () => ChooseModeView()), // Replace with actual QuranView
    GetPage(name: AppRoute.readquran, page: () => ReadQuranPage()),
    GetPage(name: AppRoute.listenQuran, page: () => ListenQuranPage()), // Replace with actual ListenQuranView
    GetPage(name: AppRoute.profile, page: () =>  ProfileView()),
    //GetPage(name: AppRoute.quran, page: () => const QuranView()),
    GetPage(name: AppRoute.prayerTimes, page: () =>  PrayerTimeView()),
    //GetPage(name: AppRoute.duaa, page: () => const DuaaView()),
    GetPage(name: AppRoute.qibla, page: () => QiblaView()),
    //GetPage(name: AppRoute.login, page: () => const LoginView()),
  ];
}
