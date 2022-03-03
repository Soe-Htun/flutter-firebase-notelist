import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => 
  {
    'en_US': {
      'note': 'Note List',
      'search' : 'Search ....',
      'name': 'Enter Name',
      'amount': 'Enter Amount',
      'addNote': 'Add Note',
      'updateNote': 'Edit Note',

      'success': 'Success',
      'addSuccess': 'Successfully Added',
      'updateSuccess': 'Successfully updated',
      'deleteSuccess': 'Successfully deleted',

      'delete': 'Note Delete',
      'sure': 'Are you sure to delete',
      'cancel': 'Cancel',
      'confirm': 'Confirm'
    },
    'my_MM': {
      'note': 'အကြွေးစာရင်း',
      'search' : 'ရှာပါ ....',
      'name': 'နာမည်‌ ရေးပါ',
      'amount': 'အကြွေးပမာဏ ရေးပါ',
      'addNote': 'အသစ် မှတ်ရန်',
      'updateNote': 'ပြန် ပြင်ရန်',

      'success': 'အောင်မြင်သည်',
      'addSuccess': 'အသစ် မှတ်ပြီးပါပြီ',
      'updateSuccess': 'ပြင် ပြီးပါပြီ',
      'deleteSuccess': 'ဖျက် ပြီးပါပြီ',

      'delete': 'ဖျက်မည်',
      'sure': 'ဖျက်မာ သေချာလား',
      'cancel': 'မဖျက်ဘူး',
      'confirm': 'ဖျက်မည်'
    }
  };
}

// abstract class AppTranslation {
//   static Map<String, Map<String, String>> translationKeys = {
//     "en_US": enUS,
//     "bur_MY": bur
//   };
// }

// final Map<String, String> enUS = {
//   'note': 'Note List',
//   'name': 'Enter Name',
//   'amount': 'Enter Amount',
//   'addNote': 'Add Note',
//   'updateNote': 'Edit Note',

//   'success': 'Success',
//   'addSuccess': 'Successfully Added',
//   'updateSuccess': 'Successfully updated',
//   'deleteSuccess': 'Successfully deleted',

//   'delete': 'Note Delete',
//   'sure': 'Are you sure to delete',
//   'cancel': 'Cancel',
//   'confirm': 'Confirm'
// };

// final Map<String, String> bur = {
//   'note': 'အကြွေးစာရင်း',
//   'name': 'နာမည်‌ ရေးပါ',
//   'amount': 'အကြွေးပမာဏ ရေးပါ',
//   'addNote': 'အသစ် မှတ်ရန်',
//   'updateNote': 'ပြန် ပြင်ရန်',

//   'success': 'အောင်မြင်သည်',
//   'addSuccess': 'အသစ် မှတ်ပြီးပါပြီ',
//   'updateSuccess': 'ပြင် ပြီးပါပြီ',
//   'deleteSuccess': 'ဖျက် ပြီးပါပြီ',

//   'delete': 'ဖျက်မည်',
//   'sure': 'ဖျက်မာ သေချာလား',
//   'cancel': 'မဖျက်ဘူး',
//   'confirm': 'ဖျက်မည်'
// };