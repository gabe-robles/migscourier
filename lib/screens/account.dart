import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:migscourier/constants.dart';
import 'package:migscourier/models/rider.dart';
import 'package:migscourier/services/network/auth.dart';
import 'package:flutter/material.dart';
import 'package:migscourier/services/network/revenue.dart';
import 'package:migscourier/services/network/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatefulWidget {

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<UserData> userDataFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserData();
    });
  }

  getUserData() {
    final UserDataServices data = Provider.of<UserDataServices>(context, listen: false);
    setState(() {
      userDataFuture = data.getData();
    });
  }

  @override
  Widget build(BuildContext context) {

    final AuthServices _auth = Provider.of<AuthServices>(context);
    final RevenueServices _revenue = Provider.of<RevenueServices>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("Account", style: kH3),
        ),
        brightness: Brightness.dark,
      ),
      body: FutureBuilder<UserData>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {

            final UserData user = snapshot.data;

            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Card(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 92,
                            width: 92,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.center,
                                imageUrl: user.imageUrl ?? "",
                                placeholder: (context, placeholder) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorWidget: (context, error, _) {
                                  return Center(
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 22),
                          Text("${user.name}", style: kH3),
                          SizedBox(height: 8.0),
                          Text("${user.phone}", style: kH4),
                        ],
                      )
                  ),
                ),
                //Earnings
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.moneyBillWave),
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Earnings: ', style: TextStyle(fontSize: 14.0)),
                            SizedBox(width: 12.0),
                          ]
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("From: ${DateFormat("MMM dd, yyyy").format(_revenue.startDate).split(" ")[0]}"),
                          Text("To: ${DateFormat("MMM dd, yyyy").format(_revenue.endDate).split(" ")[0]}"),
                          Text("Tap to select date"),
                        ],
                      ),
                      trailing: Text(
                        _revenue.amount == null
                            || _revenue.amount < 1
                            ? "P 0.00"
                            : "P " + _revenue.amount.toStringAsFixed(2),
                      ),
                      onTap: () {
                        _revenue.selectDate(_scaffoldKey.currentContext);
                      },
                    ),
                  ),
                ),

                //About the App
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About this app", style: kBody),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: "Migs Courier",
                          applicationVersion: "${_auth.packageInfo.version}",
                          applicationLegalese: "©${DateTime.now().year} Migs",
                          applicationIcon: Container(
                            height: 60.0,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.first_page),
                      title: Text("Sign Out", style: kBody),
                      onTap: () async {
                        await _auth.signOut(_scaffoldKey.currentContext);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }

        }
      ),
    );
  }
}
