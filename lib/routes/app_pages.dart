import 'package:get/get.dart';
import 'package:sakinah/app/bindings/auth_binding.dart';
import 'package:sakinah/app/bindings/duaa_binding.dart';
import 'package:sakinah/app/bindings/initial_binding.dart';
import 'package:sakinah/app/bindings/prayers_bindings.dart';
import 'package:sakinah/app/bindings/profile_binding.dart';
import 'package:sakinah/app/bindings/quran_bindings.dart';
import 'package:sakinah/app/views/auth_views/login_view.dart';
import 'package:sakinah/app/views/auth_views/verify_email_view.dart';
import 'package:sakinah/app/views/duaa_view.dart';
import 'package:sakinah/app/views/home_view.dart';
import 'package:sakinah/app/views/onboarding_view.dart';
import 'package:sakinah/app/views/prayer_time_view.dart';
import 'package:sakinah/app/views/profile_view.dart';
import 'package:sakinah/app/views/qibla_view.dart';
import 'package:sakinah/app/views/quran_view/now_playing_view.dart';
import 'package:sakinah/app/views/quran_view/quran_listen_read_view.dart';
import 'package:sakinah/app/views/quran_view/quran_listen_view.dart';
import 'package:sakinah/app/views/quran_view/quran_read_view.dart';
import 'app_route.dart';

class AppPages {
  static final pages = [
    //GetPage(name: AppRoute.splash, page: () => const SplashView()),
    GetPage(name: AppRoute.home, page: () => HomeView()),
    GetPage(name: AppRoute.choosemode, page: () => ChooseModeView()), // Replace with actual QuranView
    GetPage(name: AppRoute.readquran, page: () => ReadQuranPage() , binding: QuranBindings()),
    GetPage(name: AppRoute.listenQuran, page: () => ListenQuranPage()), // Replace with actual ListenQuranView
    GetPage(name: AppRoute.profile, page: () =>  ProfileView() , binding: ProfileBinding()),
    GetPage(name: AppRoute.prayerTimes, page: () =>  PrayerTimeView(), binding: PrayersBindings()),
    GetPage(name: AppRoute.duaa, page: () => DuaaView(), binding: DuaaBinding()),
    GetPage(name: AppRoute.qibla, page: () => QiblaView()),
    GetPage(name: AppRoute.login, page: () =>  LoginView()),
    GetPage(name: AppRoute.onboarding, page: () => const OnboardingView()),
    GetPage(name: AppRoute.verifyEmail, page: () => VerifyEmailView()), // Uncomment if you have a VerifyEmailView
    GetPage(name: AppRoute.nowplaying, page: () => NowPlayingView(), binding: QuranBindings()),
  ];
}
