import 'package:driver_app/screen/login_and_logout/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChoosePage extends StatefulWidget {
  const LanguageChoosePage({super.key});

  @override
  State<LanguageChoosePage> createState() => _LanguageChoosePageState();
}

class _LanguageChoosePageState extends State<LanguageChoosePage> {
  final List locale = [
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
      'flag': 'assets/images/us.png',
    },
    {
      'name': 'नेपाली',
      'locale': const Locale('nep', 'NPL'),
      'flag': 'assets/images/np.png',
    },
    {
      'name': 'हिन्दी',
      'locale': const Locale('hi', 'IN'),
      'flag': 'assets/images/in.png',
    },
    {
      'name': 'Arabic',
      'locale': const Locale('arb', 'ARB'),
      'flag': 'assets/images/ar.png',
    },
  ];

  Future<void> _saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/frame.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 370.h,
          width: 290.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  // boxShadow: ContainerBoxShadows.boxShadow,
                ),
                child: Text(
                  'Select Language',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final selectedLocale = locale[index]['locale'] as Locale;
                      await _saveLocale(
                          selectedLocale); // Save the selected language
                      Get.updateLocale(
                          selectedLocale); // Update the locale in the app

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => DriverLoginScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            locale[index]['flag'],
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 20),
                          Text(locale[index]['name']),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.blue,
                  );
                },
                itemCount: locale.length,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
