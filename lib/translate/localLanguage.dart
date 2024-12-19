import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'message': 'Welcome to my home.',
          'title': 'Flutter Language - Localization',
          'sub': 'Subscribe Now',
          'changelang': 'Change Language',
          'Quick_Access': 'Quick Access',
          'info': 'General Information',
        },
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
          'message': 'मेरे घर में आपका स्वागत है।',
          'title': 'स्पंदन भाषा - स्थानीयकरण',
          'subscribe': 'अब सदस्यता लें',
          'changelang': 'भाषा बदलें',
          'Quick_Access': 'Quick Access',
          'info': 'General Information',
        },
        'nep_NPL': {
          'hello': 'नमस्ते संसार',
          'message': 'मेरो घरमा स्वागत छ।',
          'title': 'फ्लटर भाषा - स्थानीयकरण',
          'subscribe': 'अब सदस्यता लिनुहोस्',
          'changelang': 'भाषा परिवर्तन गर्नुहोस्',
          'Quick_Access': 'द्रुत पहुँच',
          'info': 'सामान्य जानकारी'
        },
        'arb_ARB': {
          'hello': 'مرحبا بالعالم',
          'message': 'مرحبا بكم في بيتي',
          'title': 'لغة الرفرفة - التوطين',
          'subscribe': 'اشترك الآن',
          'changelang': 'تغيير اللغة',
          'Quick_Access': 'Quick Access',
          'info': 'General Information',
        }
      };
}
