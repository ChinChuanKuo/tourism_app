import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tourism_app/apis/apis.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/data/data.dart';
import 'package:tourism_app/models/models.dart';
import 'package:tourism_app/widgets/photo_selector.dart';
import 'package:tourism_app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String categoryId;
  bool traffic;
  bool location;
  TextEditingController textEditingController;
  List<User> users;
  GlobalKey<AnimatedListState> globalKey;
  List<TextEditingController> textId;
  List<TextEditingController> textName;
  List<TextEditingController> textCard;
  List<TextEditingController> textDay;
  List<bool> gender;
  List<bool> holder;
  List<bool> place;

  @override
  void initState() {
    categoryId = "0";
    traffic = false;
    location = false;
    textEditingController = new TextEditingController();
    users = [
      User(userid: "", username: "", idcard: "", birthday: "", showPlace: true)
    ];
    globalKey = GlobalKey<AnimatedListState>();
    textId = [TextEditingController()];
    textName = [TextEditingController()];
    textCard = [TextEditingController()];
    textDay = [TextEditingController()];
    gender = [false];
    holder = [false];
    place = [true];
    // TODO: implement initState
    super.initState();
  }

  void onTapGesture(String id) => setState(() => categoryId = id);

  void onTapMobilePhoto(Category category) => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        elevation: 14.0,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: PhotoSelector(category: category),
        ),
      );

  void onTapDesktopPhoto(Category category) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 14.0,
          child: Container(
            width: 600.0,
            height: 500.0,
            child: PhotoSelector(category: category),
          ),
        ),
      );

  void onChangedSwitch(bool value) => setState(() => traffic = value);

  void onPressedCheckBox(bool value) => setState(() => location = value);

  void onPressedClear(int index) {
    users.removeAt(index);
    globalKey.currentState.removeItem(
      index,
      (context, animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Interval(0.5, 1.0),
          ),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 1.0),
            ),
            axisAlignment: 0.0,
            child: null,
          ),
        );
      },
    );
    textId.removeAt(index);
    textName.removeAt(index);
    textCard.removeAt(index);
    textDay.removeAt(index);
    gender.remove(index);
    holder.remove(index);
    place.remove(index);
  }

  void onPressedGender(int index, bool showGender) => setState(
      () => {users[index].showGender = showGender, gender[index] = showGender});

  void onPressedPlace(int index, bool showPlace) => setState(
      () => {users[index].showPlace = showPlace, place[index] = showPlace});

  void onChangedId(String value, int index) async {
    if (value.length == 6) {
      final response = await http.get(
          Uri.http(APi.user[0]["url"], APi.user[0]["route"], {
            "userid": textId[index].text,
            "username": textName[index].text,
          }),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200)
        setState(() => textName[index].text = json.decode(response.body));
    }
  }

  Future<void> onChangedDay(String value, int index) async {
    if (value.length == 8) {
      final response = await http.get(
          Uri.http(APi.user[1]["url"], APi.user[1]["route"], {
            "birthday": textDay[index].text,
          }),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200)
        setState(() => holder[index] = json.decode(response.body) < 3);
      else
        setState(() => holder[index] = false);
    } else
      setState(() => holder[index] = false);
  }

  void onPressedPlus() {
    int index = users.length;
    users.insert(
        index,
        User(
            userid: "",
            username: "",
            idcard: "",
            birthday: "",
            showGender: false,
            showPlace: true));
    globalKey.currentState.insertItem(index);
    textId.add(TextEditingController());
    textName.add(TextEditingController());
    textCard.add(TextEditingController());
    textDay.add(TextEditingController());
    gender.add(false);
    holder.add(false);
    place.add(true);
  }

  Group parseGroup(String responseBody) =>
      Group.fromJson(json.decode(responseBody));

  Future<void> onPressedSure() async {
    final response = await http.post(
        Uri.http(
          APi.system[2]["url"],
          APi.system[2]["route"],
        ),
        body: {"licenses": textEditingController.text},
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final Group body = parseGroup(response.body);
      if (!body.showWarn) {
        int length = users.length;
        for (int i = 0; i < length; i++) onPressedClear(0);
        setState(() {
          categoryId = body.category;
          traffic = body.traffic;
          location = body.location;
        });
        for (int i = 0; i < body.items.length; i++) {
          String userid = body.items[i]["userid"],
              username = body.items[i]["username"],
              idcard = body.items[i]["idcard"],
              birthday = body.items[i]["birthday"];
          bool showGender = body.items[i]["showGender"],
              showHolder = body.items[i]["showHolder"],
              showPlace = body.items[i]["showPlace"];
          users.insert(
              i,
              User(
                  userid: userid,
                  username: username,
                  idcard: idcard,
                  birthday: birthday,
                  showGender: showGender,
                  showPlace: showPlace));
          globalKey.currentState.insertItem(i);
          TextEditingController useredit = new TextEditingController();
          useredit.text = userid;
          TextEditingController nameedit = new TextEditingController();
          nameedit.text = username;
          TextEditingController cardedit = new TextEditingController();
          cardedit.text = idcard;
          TextEditingController daysedit = new TextEditingController();
          daysedit.text = birthday;
          textId.add(useredit);
          textName.add(nameedit);
          textCard.add(cardedit);
          textDay.add(daysedit);
          gender.add(showGender);
          holder.add(showHolder);
          place.add(showPlace);
        }
      } else
        CustomSnackBar.showWidget(
          context,
          Duration(seconds: 5),
          Responsive.isMobile(context)
              ? SnackBarBehavior.fixed
              : SnackBarBehavior.floating,
          Colors.red,
          Row(children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8.0),
            Text(AppLocalizations.of(context).wrongMessageText)
          ]),
        );
      Navigator.pop(context);
    }
  }

  void onPressedMobileCloud() => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        elevation: 14.0,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: ClousCreate(
            editingController: textEditingController,
            onPressedSure: onPressedSure,
          ),
        ),
      );

  void onPressedDesktopCloud() => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 14.0,
          child: Container(
            width: 400.0,
            height: 350.0,
            child: ClousCreate(
              editingController: textEditingController,
              onPressedSure: onPressedSure,
            ),
          ),
        ),
      );

  void onPressedMoney() async {
    List<Map<String, dynamic>> items = [];
    for (int i = 0; i < users.length; i++) {
      items.add({
        "userid": textId[i].text,
        "username": textName[i].text,
        "idcard": textCard[i].text,
        "birthday": textDay[i].text,
        "showPlace": place[i],
      });
    }
    final response = await http.get(
        Uri.http(APi.system[0]["url"], APi.system[0]["route"], {
          "categoryId": categoryId,
          "traffic": traffic.toString(),
          "location": location.toString(),
          "items": json.encode(items)
        }),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context).totalText),
          content: Text(
            json.decode(response.body),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(AppLocalizations.of(context).closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  void onPressedCopy(String license) {
    Clipboard.setData(ClipboardData(text: license));
    Navigator.pop(context);
    CustomSnackBar.showWidget(
        context,
        Duration(seconds: 5),
        Responsive.isMobile(context)
            ? SnackBarBehavior.fixed
            : SnackBarBehavior.floating,
        Colors.green,
        Row(children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 8.0),
          Text(AppLocalizations.of(context).successCopyText)
        ]));
  }

  void showMobileLicense(String license) => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        elevation: 14.0,
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: CloudLicense(
            license: license,
            onPressedCopy: onPressedCopy,
          ),
        ),
      );

  void showDesktopLicense(String license) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          elevation: 14.0,
          child: Container(
            width: 400.0,
            height: 350.0,
            child: CloudLicense(
              license: license,
              onPressedCopy: onPressedCopy,
            ),
          ),
        ),
      );

  Status parseStatus(String responseBody) =>
      Status.fromJson(json.decode(responseBody));

  void onPressedSend() async {
    List<Map<String, dynamic>> items = [];
    for (int i = 0; i < users.length; i++) {
      items.add({
        "userid": textId[i].text,
        "username": textName[i].text,
        "idcard": textCard[i].text,
        "birthday": textDay[i].text,
        "showGender": gender[i],
        "showPlace": place[i],
      });
    }
    final response = await http
        .post(Uri.http(APi.system[1]["url"], APi.system[1]["route"]), body: {
      "categoryId": categoryId,
      "traffic": traffic.toString(),
      "location": location.toString(),
      "items": json.encode(items)
    }, headers: {
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      final Status body = parseStatus(response.body);
      if (!body.showWarn) {
        Responsive.isDesktop(context)
            ? showDesktopLicense(body.license)
            : showMobileLicense(body.license);
      }
      CustomSnackBar.showWidget(
          context,
          Duration(seconds: 5),
          Responsive.isMobile(context)
              ? SnackBarBehavior.fixed
              : SnackBarBehavior.floating,
          body.showWarn ? Colors.red : Colors.green,
          Row(children: [
            Icon(body.showWarn ? Icons.error : Icons.check,
                color: Colors.white),
            SizedBox(width: 8.0),
            Text(body.status)
          ]));
    } else
      CustomSnackBar.showWidget(
        context,
        Duration(seconds: 5),
        Responsive.isMobile(context)
            ? SnackBarBehavior.fixed
            : SnackBarBehavior.floating,
        Colors.red,
        Row(children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 8.0),
          Text(AppLocalizations.of(context).wrongMessageText)
        ]),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 65.0),
        child: CustomAppBar(),
      ),
      // ignore: missing_required_param
      body: Responsive(
        // ignore: missing_required_param
        mobile: MobileHomeView(
          categoryId: categoryId,
          onTapGesture: onTapGesture,
          onTapPhoto: onTapMobilePhoto,
          traffic: traffic,
          onChangedSwitch: onChangedSwitch,
          location: location,
          onPressedCheckBox: onPressedCheckBox,
          users: users,
          globalKey: globalKey,
          textId: textId,
          textName: textName,
          textCard: textCard,
          textDay: textDay,
          gender: gender,
          holder: holder,
          place: place,
          onPressedClear: onPressedClear,
          onChangedId: onChangedId,
          onChangedDay: onChangedDay,
          onPressedGender: onPressedGender,
          onPressedPlace: onPressedPlace,
          onPressedCloud: onPressedMobileCloud,
          onPressedMoney: onPressedMoney,
          onPressedSend: onPressedSend,
        ),
        // ignore: missing_required_param
        desktop: DesktopHomeView(
          categoryId: categoryId,
          onTapGesture: onTapGesture,
          onTapPhoto: onTapDesktopPhoto,
          traffic: traffic,
          onChangedSwitch: onChangedSwitch,
          location: location,
          onPressedCheckBox: onPressedCheckBox,
          users: users,
          globalKey: globalKey,
          textId: textId,
          textName: textName,
          textCard: textCard,
          textDay: textDay,
          gender: gender,
          holder: holder,
          place: place,
          onPressedClear: onPressedClear,
          onChangedId: onChangedId,
          onChangedDay: onChangedDay,
          onPressedGender: onPressedGender,
          onPressedPlace: onPressedPlace,
          onPressedCloud: onPressedDesktopCloud,
          onPressedMoney: onPressedMoney,
          onPressedSend: onPressedSend,
        ),
      ),
      floatingActionButtonLocation: isDesktop
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.person_add, size: 25.0),
        label: Text(
          AppLocalizations.of(context).newText,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        onPressed: onPressedPlus,
      ),
    );
  }
}

class MobileHomeView extends StatelessWidget {
  final String categoryId;
  final Function(String id) onTapGesture;
  final Function(Category category) onTapPhoto;
  final bool traffic;
  final Function(bool newValue) onChangedSwitch;
  final bool location;
  final Function(bool newValue) onPressedCheckBox;
  final List<User> users;
  final GlobalKey<AnimatedListState> globalKey;
  final List<TextEditingController> textId;
  final List<TextEditingController> textName;
  final List<TextEditingController> textCard;
  final List<TextEditingController> textDay;
  final List<bool> gender;
  final List<bool> holder;
  final List<bool> place;
  final Function(int index) onPressedClear;
  final Function(String value, int index) onChangedId;
  final Function(String value, int index) onChangedDay;
  final Function(int index, bool showPlace) onPressedGender;
  final Function(int index, bool showPlace) onPressedPlace;
  final Function onPressedCloud;
  final Function onPressedMoney;
  final Function onPressedSend;

  const MobileHomeView({
    Key key,
    @required this.categoryId,
    @required this.onTapGesture,
    @required this.onTapPhoto,
    @required this.traffic,
    @required this.onChangedSwitch,
    @required this.location,
    @required this.onPressedCheckBox,
    @required this.users,
    @required this.globalKey,
    @required this.textId,
    @required this.textName,
    @required this.textCard,
    @required this.textDay,
    @required this.gender,
    @required this.holder,
    @required this.place,
    @required this.onPressedClear,
    @required this.onChangedId,
    @required this.onChangedDay,
    @required this.onPressedGender,
    @required this.onPressedPlace,
    @required this.onPressedCloud,
    @required this.onPressedMoney,
    @required this.onPressedSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectColor(bool newValue) =>
        newValue ? Palette.selectedIconColor : Palette.defaultIconColor;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: Container(
            height: 200.0,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    //controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories(context).length,
                    itemBuilder: (BuildContext context, int index) {
                      final Category category = categories(context)[index];
                      return WidgetAnimator(
                        horizontal: true,
                        child: CategorySelector(
                          categoryId: categoryId,
                          onTapGesture: onTapGesture,
                          category: category,
                          onTapPhoto: onTapPhoto,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Row(
                children: [
                  Switch(
                    activeColor: Palette.selectedIconColor,
                    value: traffic,
                    onChanged: onChangedSwitch,
                  ),
                  Text(
                    traffic
                        ? AppLocalizations.of(context).rideText
                        : AppLocalizations.of(context).selfText,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: selectColor(traffic),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: traffic
                    ? Row(
                        children: [
                          Row(
                            children: [
                              CircleButton(
                                icon: location
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                iconSize: 25.0,
                                iconColor: selectColor(location),
                                onPressed: () => onPressedCheckBox(true),
                              ),
                              Text(
                                AppLocalizations.of(context).neihuText,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: selectColor(location),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              CircleButton(
                                icon: !location
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                iconSize: 25.0,
                                iconColor: selectColor(!location),
                                onPressed: () => onPressedCheckBox(false),
                              ),
                              Text(
                                AppLocalizations.of(context).linkouText,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: selectColor(!location),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : SizedBox.shrink(),
              ),
              Row(
                children: [
                  CircleButton(
                    boxColor: Colors.grey[200],
                    icon: Icons.cloud_download,
                    iconSize: 25.0,
                    iconColor: Palette.defaultIconColor,
                    onPressed: onPressedCloud,
                  ),
                  SizedBox(width: 7.5),
                  CircleButton(
                    boxColor: Colors.grey[200],
                    icon: Icons.attach_money,
                    iconSize: 25.0,
                    iconColor: Palette.defaultIconColor,
                    onPressed: onPressedMoney,
                  ),
                  SizedBox(width: 7.5),
                  CircleButton(
                    boxColor: Colors.grey[200],
                    icon: Icons.send,
                    iconSize: 25.0,
                    iconColor: Palette.defaultIconColor,
                    onPressed: onPressedSend,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedList(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            key: globalKey,
            initialItemCount: users.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              final User user = users[index];
              return ScaleTransition(
                scale: animation,
                child: MobileUserSelector(
                  index: index,
                  user: user,
                  traffic: traffic,
                  textId: textId[index],
                  textName: textName[index],
                  textCard: textCard[index],
                  textDay: textDay[index],
                  showGender: gender[index],
                  showHolder: holder[index],
                  showPlace: place[index],
                  onPressed: onPressedClear,
                  onChangedId: onChangedId,
                  onChangedDay: onChangedDay,
                  onPressedGender: onPressedGender,
                  onPressedPlace: onPressedPlace,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 65.0)
      ],
    );
  }
}

class DesktopHomeView extends StatelessWidget {
  final String categoryId;
  final Function(String id) onTapGesture;
  final Function(Category category) onTapPhoto;
  final bool traffic;
  final Function(bool newValue) onChangedSwitch;
  final bool location;
  final Function(bool newValue) onPressedCheckBox;
  final List<User> users;
  final GlobalKey<AnimatedListState> globalKey;
  final List<TextEditingController> textId;
  final List<TextEditingController> textName;
  final List<TextEditingController> textCard;
  final List<TextEditingController> textDay;
  final List<bool> gender;
  final List<bool> holder;
  final List<bool> place;
  final Function(int index) onPressedClear;
  final Function(String value, int index) onChangedId;
  final Function(String value, int index) onChangedDay;
  final Function(int index, bool showPlace) onPressedGender;
  final Function(int index, bool showPlace) onPressedPlace;
  final Function onPressedCloud;
  final Function onPressedMoney;
  final Function onPressedSend;

  const DesktopHomeView({
    Key key,
    @required this.categoryId,
    @required this.onTapGesture,
    @required this.onTapPhoto,
    @required this.traffic,
    @required this.onChangedSwitch,
    @required this.location,
    @required this.onPressedCheckBox,
    @required this.users,
    @required this.globalKey,
    @required this.textId,
    @required this.textName,
    @required this.textCard,
    @required this.textDay,
    @required this.gender,
    @required this.holder,
    @required this.place,
    @required this.onPressedClear,
    @required this.onChangedId,
    @required this.onChangedDay,
    @required this.onPressedGender,
    @required this.onPressedPlace,
    @required this.onPressedCloud,
    @required this.onPressedMoney,
    @required this.onPressedSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double maxWidth =
        screenSize.width * 0.45 >= 700.0 ? 700.0 : screenSize.width * 0.5;
    Color selectColor(bool newValue) =>
        newValue ? Palette.selectedIconColor : Palette.defaultIconColor;
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
              child: null,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Switch(
                          activeColor: Palette.selectedIconColor,
                          value: traffic,
                          onChanged: onChangedSwitch,
                        ),
                        Text(
                          traffic
                              ? AppLocalizations.of(context).rideText
                              : AppLocalizations.of(context).selfText,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: selectColor(traffic),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: traffic
                          ? Row(
                              children: [
                                Row(
                                  children: [
                                    CircleButton(
                                      icon: location
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      iconSize: 25.0,
                                      iconColor: selectColor(location),
                                      onPressed: () => onPressedCheckBox(true),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).neihuText,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: selectColor(location),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleButton(
                                      icon: !location
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      iconSize: 25.0,
                                      iconColor: selectColor(!location),
                                      onPressed: () => onPressedCheckBox(false),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).linkouText,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: selectColor(!location),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          : SizedBox.shrink(),
                    ),
                    Row(
                      children: [
                        CircleButton(
                          boxColor: Colors.grey[200],
                          icon: Icons.cloud_download,
                          iconSize: 25.0,
                          iconColor: Palette.defaultIconColor,
                          onPressed: onPressedCloud,
                        ),
                        SizedBox(width: 7.5),
                        CircleButton(
                          boxColor: Colors.grey[200],
                          icon: Icons.attach_money,
                          iconSize: 25.0,
                          iconColor: Palette.defaultIconColor,
                          onPressed: onPressedMoney,
                        ),
                        SizedBox(width: 7.5),
                        CircleButton(
                          boxColor: Colors.grey[200],
                          icon: Icons.send,
                          iconSize: 25.0,
                          iconColor: Palette.defaultIconColor,
                          onPressed: onPressedSend,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedList(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  key: globalKey,
                  initialItemCount: users.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    final User user = users[index];
                    return ScaleTransition(
                      scale: animation,
                      child: DesktopUserSelector(
                        index: index,
                        user: user,
                        traffic: traffic,
                        textId: textId[index],
                        textName: textName[index],
                        textCard: textCard[index],
                        textDay: textDay[index],
                        showGender: gender[index],
                        showHolder: holder[index],
                        showPlace: place[index],
                        onPressed: onPressedClear,
                        onChangedId: onChangedId,
                        onChangedDay: onChangedDay,
                        onPressedGender: onPressedGender,
                        onPressedPlace: onPressedPlace,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, top: 12.0, bottom: 12.0),
              child: CategoriesList(
                categoryId: categoryId,
                onTapGesture: onTapGesture,
                onTapPhoto: onTapPhoto,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
