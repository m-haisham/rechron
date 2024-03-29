// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:rechron_core/rechron_core.dart' as _i1;

const data = <String, dynamic>{
  'name': 'en',
  'skip': {
    'about',
    'ad',
    'and',
    'at',
    'by',
    'just',
    'm',
    'nd',
    'of',
    'on',
    'rd',
    'st',
    'th',
    'the'
  },
  'tokenMap': {
    'decade': _i1.TokenType.keyDecade,
    'decades': _i1.TokenType.keyDecade,
    'year': _i1.TokenType.keyYear,
    'yr': _i1.TokenType.keyYear,
    'years': _i1.TokenType.keyYear,
    'mo': _i1.TokenType.keyMonth,
    'month': _i1.TokenType.keyMonth,
    'months': _i1.TokenType.keyMonth,
    'week': _i1.TokenType.keyWeek,
    'wk': _i1.TokenType.keyWeek,
    'w': _i1.TokenType.keyWeek,
    'weeks': _i1.TokenType.keyWeek,
    'day': _i1.TokenType.keyDay,
    'd': _i1.TokenType.keyDay,
    'days': _i1.TokenType.keyDay,
    'hour': _i1.TokenType.keyHour,
    'hr': _i1.TokenType.keyHour,
    'h': _i1.TokenType.keyHour,
    'hours': _i1.TokenType.keyHour,
    'hrs': _i1.TokenType.keyHour,
    'min': _i1.TokenType.keyMinute,
    'minute': _i1.TokenType.keyMinute,
    'm': _i1.TokenType.keyMinute,
    'minutes': _i1.TokenType.keyMinute,
    'mins': _i1.TokenType.keyMinute,
    'sec': _i1.TokenType.keySecond,
    'second': _i1.TokenType.keySecond,
    's': _i1.TokenType.keySecond,
    'seconds': _i1.TokenType.keySecond,
    'secs': _i1.TokenType.keySecond,
    'ago': _i1.TokenType.keyAgo,
    'in': _i1.TokenType.keyIn,
    'from': _i1.TokenType.plus
  },
  'relativeType': {
    'day before yesterday': '2 day ago',
    'this minute': '0 minute ago',
    'last decade': '1 decade ago',
    'this decade': '1 decade ago',
    'next decade': 'in 1 decade',
    'this month': '0 month ago',
    'last month': '1 month ago',
    'next month': 'in 1 month',
    'this hour': '0 hour ago',
    'this week': '0 week ago',
    'this year': '0 year ago',
    'yesterday': '1 day ago',
    'last week': '1 week ago',
    'last year': '1 year ago',
    'next week': 'in 1 week',
    'next year': 'in 1 year',
    'tomorrow': 'in 1 day',
    'this mo': '0 month ago',
    'this wk': '0 week ago',
    'this yr': '0 year ago',
    'last mo': '1 month ago',
    'last wk': '1 week ago',
    'last yr': '1 year ago',
    'next mo': 'in 1 month',
    'next wk': 'in 1 week',
    'next yr': 'in 1 year',
    'today': '0 day ago',
    'now': '0 second ago'
  },
  'relativeTypeRegex': {
    r'in (\d+) decades?': r'in \1 decade',
    r'(\d+) decades? ago': r'\1 decade ago'
  },
  'simplifications': {
    'an': '1',
    'a': '1',
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
    'ten': '10',
    'eleven': '11',
    'twelve': '12'
  },
  'simplificationsRegex': {
    r'less than 1 minute ago': r'45 second ago',
    r'(\d+)h(\d+)m?': r'\1:\2',
    r'(?:12\s+)?noon': r'12:00',
    r'(?:12\s+)?midnight': r'00:00'
  },
  'localeSpecific': {
    'en-001': {'name': 'en-001'},
    'en-150': {'name': 'en-150'},
    'en-AG': {'name': 'en-AG'},
    'en-AI': {'name': 'en-AI'},
    'en-AS': {'name': 'en-AS'},
    'en-AT': {'name': 'en-AT'},
    'en-AU': {
      'name': 'en-AU',
      'tokenMap': {'h': _i1.TokenType.keyHour}
    },
    'en-BB': {'name': 'en-BB'},
    'en-BE': {'name': 'en-BE'},
    'en-BI': {'name': 'en-BI'},
    'en-BM': {'name': 'en-BM'},
    'en-BS': {'name': 'en-BS'},
    'en-BW': {'name': 'en-BW'},
    'en-BZ': {'name': 'en-BZ'},
    'en-CA': {'name': 'en-CA'},
    'en-CC': {'name': 'en-CC'},
    'en-CH': {'name': 'en-CH'},
    'en-CK': {'name': 'en-CK'},
    'en-CM': {'name': 'en-CM'},
    'en-CX': {'name': 'en-CX'},
    'en-CY': {'name': 'en-CY'},
    'en-DE': {'name': 'en-DE'},
    'en-DG': {'name': 'en-DG'},
    'en-DK': {'name': 'en-DK'},
    'en-DM': {'name': 'en-DM'},
    'en-ER': {'name': 'en-ER'},
    'en-FI': {'name': 'en-FI'},
    'en-FJ': {'name': 'en-FJ'},
    'en-FK': {'name': 'en-FK'},
    'en-FM': {'name': 'en-FM'},
    'en-GB': {'name': 'en-GB'},
    'en-GD': {'name': 'en-GD'},
    'en-GG': {'name': 'en-GG'},
    'en-GH': {'name': 'en-GH'},
    'en-GI': {'name': 'en-GI'},
    'en-GM': {'name': 'en-GM'},
    'en-GU': {'name': 'en-GU'},
    'en-GY': {'name': 'en-GY'},
    'en-HK': {'name': 'en-HK'},
    'en-IE': {'name': 'en-IE'},
    'en-IL': {'name': 'en-IL'},
    'en-IM': {'name': 'en-IM'},
    'en-IN': {'name': 'en-IN'},
    'en-IO': {'name': 'en-IO'},
    'en-JE': {'name': 'en-JE'},
    'en-JM': {'name': 'en-JM'},
    'en-KE': {'name': 'en-KE'},
    'en-KI': {'name': 'en-KI'},
    'en-KN': {'name': 'en-KN'},
    'en-KY': {'name': 'en-KY'},
    'en-LC': {'name': 'en-LC'},
    'en-LR': {'name': 'en-LR'},
    'en-LS': {'name': 'en-LS'},
    'en-MG': {'name': 'en-MG'},
    'en-MH': {'name': 'en-MH'},
    'en-MO': {'name': 'en-MO'},
    'en-MP': {'name': 'en-MP'},
    'en-MS': {'name': 'en-MS'},
    'en-MT': {'name': 'en-MT'},
    'en-MU': {'name': 'en-MU'},
    'en-MW': {'name': 'en-MW'},
    'en-MY': {'name': 'en-MY'},
    'en-NA': {'name': 'en-NA'},
    'en-NF': {'name': 'en-NF'},
    'en-NG': {'name': 'en-NG'},
    'en-NL': {'name': 'en-NL'},
    'en-NR': {'name': 'en-NR'},
    'en-NU': {'name': 'en-NU'},
    'en-NZ': {'name': 'en-NZ'},
    'en-PG': {'name': 'en-PG'},
    'en-PH': {'name': 'en-PH'},
    'en-PK': {'name': 'en-PK'},
    'en-PN': {'name': 'en-PN'},
    'en-PR': {'name': 'en-PR'},
    'en-PW': {'name': 'en-PW'},
    'en-RW': {'name': 'en-RW'},
    'en-SB': {'name': 'en-SB'},
    'en-SC': {'name': 'en-SC'},
    'en-SD': {'name': 'en-SD'},
    'en-SE': {'name': 'en-SE'},
    'en-SG': {
      'name': 'en-SG',
      'tokenMap': {'mth': _i1.TokenType.keyMonth},
      'relativeType': {
        'this mth': '0 month ago',
        'last mth': '1 month ago',
        'next mth': 'in 1 month'
      }
    },
    'en-SH': {'name': 'en-SH'},
    'en-SI': {'name': 'en-SI'},
    'en-SL': {'name': 'en-SL'},
    'en-SS': {'name': 'en-SS'},
    'en-SX': {'name': 'en-SX'},
    'en-SZ': {'name': 'en-SZ'},
    'en-TC': {'name': 'en-TC'},
    'en-TK': {'name': 'en-TK'},
    'en-TO': {'name': 'en-TO'},
    'en-TT': {'name': 'en-TT'},
    'en-TV': {'name': 'en-TV'},
    'en-TZ': {'name': 'en-TZ'},
    'en-UG': {'name': 'en-UG'},
    'en-UM': {'name': 'en-UM'},
    'en-VC': {'name': 'en-VC'},
    'en-VG': {'name': 'en-VG'},
    'en-VI': {'name': 'en-VI'},
    'en-VU': {'name': 'en-VU'},
    'en-WS': {'name': 'en-WS'},
    'en-ZA': {'name': 'en-ZA'},
    'en-ZM': {'name': 'en-ZM'},
    'en-ZW': {'name': 'en-ZW'}
  }
};
