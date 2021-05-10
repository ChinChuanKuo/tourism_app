import 'package:flutter/material.dart';
import 'package:tourism_app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClousCreate extends StatefulWidget {
  final TextEditingController editingController;
  final Function onPressedSure;

  const ClousCreate({
    Key key,
    @required this.editingController,
    @required this.onPressedSure,
  }) : super(key: key);

  @override
  _ClousCreateState createState() => _ClousCreateState();
}

class _ClousCreateState extends State<ClousCreate> {
  void onPressedCancel() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SheetTile(
          title: AppLocalizations.of(context).licensesText,
          onPressedCancel: onPressedCancel,
        ),
        SizedBox(height: 12.0),
        Expanded(
          child: ListTile(
            // ignore: missing_required_param
            title: CustomTextBar(
              hintText:
                  '${AppLocalizations.of(context).enterHint} ${AppLocalizations.of(context).licensesText}',
              icon: Icons.group,
              textEditingController: this.widget.editingController,
            ),
          ),
        ),
        SheetButton(
          icon: Icons.check,
          text: AppLocalizations.of(context).sureText,
          onPressed: this.widget.onPressedSure,
        ),
      ],
    );
  }
}
