import 'package:flutter/material.dart';
import 'package:tourism_app/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Category> categories(BuildContext context) => [
      Category(
          id: '0',
          title: AppLocalizations.of(context).firstText,
          imageUrl: "assets/images/horse.png"),
      Category(
          id: '1',
          title: AppLocalizations.of(context).secondText,
          imageUrl: "assets/images/six.png"),
    ];
