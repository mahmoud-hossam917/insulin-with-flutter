import 'package:flutter/cupertino.dart';
import 'package:insulin/cubit/cubit.dart';

AppCubit? cubit;
Widget MyText(text, color, fontSize, fontWeight) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
  );
}

const DOSE = 'http://smartinsulin-001-site1.itempurl.com/api/doses';
const userDoses =
    'http://smartinsulin-001-site1.itempurl.com/api/doses/?userid=5';
