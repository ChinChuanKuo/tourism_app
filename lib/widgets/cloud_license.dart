import 'package:flutter/material.dart';
import 'package:tourism_app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CloudLicense extends StatefulWidget {
  final String license;
  final Function(String value) onPressedCopy;

  const CloudLicense({
    Key key,
    @required this.license,
    @required this.onPressedCopy,
  }) : super(key: key);

  @override
  _CloudLicenseState createState() => _CloudLicenseState();
}

class _CloudLicenseState extends State<CloudLicense> {
  void onPressedCancel() => Navigator.pop(context);

  /*void onPressed() =>
      Clipboard.setData(ClipboardData(text: this.widget.license));*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SheetTile(
          title: AppLocalizations.of(context).licensesText,
          onPressedCancel: onPressedCancel,
        ),
        SizedBox(height: 12.0),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Text(
              this.widget.license,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox.shrink()),
        SheetButton(
          icon: Icons.copy,
          text: AppLocalizations.of(context).copyText,
          onPressed: () => this.widget.onPressedCopy(this.widget.license),
        ),
      ],
    );
  }
}
