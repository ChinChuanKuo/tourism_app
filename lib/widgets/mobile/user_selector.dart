import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/models/user_models.dart';
import 'package:tourism_app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MobileUserSelector extends StatelessWidget {
  final int index;
  final User user;
  final bool traffic;
  final TextEditingController textId;
  final TextEditingController textName;
  final TextEditingController textCard;
  final TextEditingController textDay;
  final bool showGender;
  final bool showHolder;
  final bool showPlace;
  final Function(int index) onPressed;
  final Function(String value, int index) onChangedId;
  final Function(String value, int index) onChangedDay;
  final Function(int index, bool showPlace) onPressedGender;
  final Function(int index, bool showPlace) onPressedPlace;

  const MobileUserSelector({
    Key key,
    @required this.index,
    @required this.user,
    @required this.traffic,
    @required this.textId,
    @required this.textName,
    @required this.textCard,
    @required this.textDay,
    @required this.showGender,
    @required this.showHolder,
    @required this.showPlace,
    @required this.onPressed,
    @required this.onChangedId,
    @required this.onChangedDay,
    @required this.onPressedGender,
    @required this.onPressedPlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectColor(bool newValue) =>
        newValue ? Palette.selectedIconColor : Palette.defaultIconColor;
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(top: 5.0)
          : const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          index == 0
              ? SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: missing_required_param
                    // ignore: deprecated_member_use
                    RaisedButton(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        AppLocalizations.of(context).deleteText,
                        style: TextStyle(
                          color: Palette.facebookBlue,
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onPressed: () => onPressed(index),
                    ),
                  ],
                ),
          Row(
            children: [
              Expanded(
                child: CustomInputBar(
                  text: AppLocalizations.of(context).officeText,
                  icon: Icons.person,
                  hintText:
                      '${AppLocalizations.of(context).enterHint} ${AppLocalizations.of(context).officeText}',
                  textInputType: TextInputType.number,
                  textEditingController: textId,
                  onChanged: (String value) => onChangedId(value, index),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                // ignore: missing_required_param
                child: CustomInputBar(
                  text: AppLocalizations.of(context).nameText,
                  icon: Icons.person,
                  hintText:
                      '${AppLocalizations.of(context).enterHint} ${AppLocalizations.of(context).nameText}',
                  textInputType: TextInputType.text,
                  textEditingController: textName,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                // ignore: missing_required_param
                child: CustomInputBar(
                  text: AppLocalizations.of(context).idcardText,
                  icon: Icons.person,
                  hintText:
                      '${AppLocalizations.of(context).enterHint} ${AppLocalizations.of(context).idcardText}',
                  textInputType: TextInputType.text,
                  textEditingController: textCard,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                // ignore: missing_required_param
                child: CustomInputBar(
                  text: AppLocalizations.of(context).birthdayText,
                  icon: Icons.person,
                  hintText:
                      '${AppLocalizations.of(context).enterHint} ${AppLocalizations.of(context).birthdayText}',
                  textInputType: TextInputType.number,
                  textEditingController: textDay,
                  onChanged: (String value) => onChangedDay(value, index),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleButton(
                            icon: showGender
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                            iconSize: 25.0,
                            iconColor: selectColor(showGender),
                            onPressed: () => onPressedGender(index, true),
                          ),
                          Text(
                            AppLocalizations.of(context).manText,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: selectColor(showGender),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CircleButton(
                            icon: !showGender
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                            iconSize: 25.0,
                            iconColor: selectColor(!showGender),
                            onPressed: () => onPressedGender(index, false),
                          ),
                          Text(
                            AppLocalizations.of(context).womanText,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: selectColor(!showGender),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              traffic && showHolder
                  ? Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleButton(
                                  icon: showPlace
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank,
                                  iconSize: 25.0,
                                  iconColor: selectColor(showPlace),
                                  onPressed: () => onPressedPlace(index, true),
                                ),
                                Text(
                                  AppLocalizations.of(context).seatText,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: selectColor(showPlace),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                CircleButton(
                                  icon: !showPlace
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank,
                                  iconSize: 25.0,
                                  iconColor: selectColor(!showPlace),
                                  onPressed: () => onPressedPlace(index, false),
                                ),
                                Text(
                                  AppLocalizations.of(context).unseatText,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: selectColor(!showPlace),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
