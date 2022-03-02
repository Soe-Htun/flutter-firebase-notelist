import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => 
  {
    'en_US': {
      'note': 'Note List',
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
    'bur_MY': {
      'note': 'အကြွေးစာရင်း',
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