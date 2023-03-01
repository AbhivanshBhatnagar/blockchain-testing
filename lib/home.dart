import 'dart:async';
import 'dart:developer';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'constants.dart';
import 'package:test_project/lend_borrow_screen.dart';
import 'package:test_project/request.dart';
import 'package:test_project/send.dart';
import 'package:test_project/swap.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue1 = 'Ethereum Mainnet';
    String dropdownValue2 = 'View more accounts';

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    var s = MediaQuery.of(context).size;
    var height = s.height;
    var width = s.width;

    List<Widget> _widgetOptions = <Widget>[
      Container(),
      Container(),
      Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(47, 137, 166, 1),
                border: Border.all(
                    width: 1, color: const Color.fromRGBO(36, 41, 47, 1)),
                borderRadius: const BorderRadius.all(Radius.circular(18)),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '\$76.67',
                                  style: Constants.h2poppinsStyle,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Account Name',
                                    style: Constants.h5poppinsStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '0xffaskdpsa',
                                        style: Constants.h7poppinsStyle,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.copy,
                                        size: 10.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '+%7.09',
                            style: Constants.h5poppinsStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.03,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          color: const Color.fromRGBO(36, 41, 47, 1)),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: const Color.fromRGBO(34, 37, 41, 1),

                            value: dropdownValue2,
                            // Step 4.
                            items: <String>[
                              'View more accounts',
                              'Cat',
                              'Tiger',
                              'Lion'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Constants.h5poppinsStyle,
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue1 = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
                height: 78,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 21,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.credit_card), text: "Add Funds"),
                    SizedBox(
                      width: 62,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.arrow_upward), text: "Send"),
                    SizedBox(
                      width: 62,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.arrow_downward), text: "Recieve"),
                    SizedBox(
                      width: 62,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.arrow_downward), text: "Swap"),
                    SizedBox(
                      width: 62,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.arrow_downward), text: "Lend"),
                    SizedBox(
                      width: 62,
                    ),
                    IconWithContainerAndText(
                        icon: Icon(Icons.arrow_downward), text: "Borrow"),
                    SizedBox(
                      width: 62,
                    ),
                  ],
                )),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.05,
              width: width,
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorColor: Color.fromRGBO(55, 203, 250, 1),
                // indicatorWeight: 0.000001,
                controller: _tabController,
                tabs: [
                  Tab(text: 'Tokens'),
                  Tab(text: 'NFTs'),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              height: height * 0.3,
              width: width,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ListViewItemForTokens(
                          name: 'Ethereum',
                          amt: '1 ETH',
                          rate: '0.000',
                          percentage: '5.55',
                        ),
                        ListViewItemForTokens(
                          name: 'Uniswap',
                          amt: '1 UNI',
                          rate: '0.000',
                          percentage: '5.55',
                        ),
                        ListViewItemForTokens(
                          name: 'Tether',
                          amt: '1 TH',
                          rate: '0.000',
                          percentage: '5.55',
                        ),
                      ]),
                    ),
                  ),
                  Text(
                    "Bye",
                    style: Constants.h4poppinsStyle,
                  ),
                ],
              ),
            ),
          ])),
      Container(),
      Container(),
    ];

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 260.0,
              child: DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage('assets/pfp.png')),
                            Container(
                              height: 20.0,
                              width: 70.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Switch',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[350],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF797676)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Account name',
                          style: Constants.h5poppinsStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '0xx.....ab3',
                          style: Constants.h5poppinsStyle,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF797676)),
                                ),
                                Text(
                                  ' 1',
                                  style: Constants.h5poppinsStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Following',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF797676)),
                                ),
                                Text(
                                  ' 1',
                                  style: Constants.h5poppinsStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Search',
                        style: Constants.h4poppinsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.chat, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Chat',
                        style: Constants.h4poppinsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.wallet, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Wallet',
                        style: Constants.h4poppinsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Notifications',
                        style: Constants.h4poppinsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.white),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Settings',
                        style: Constants.h4poppinsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 16, 19, 18),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 50.0,
          leading: Builder(
            builder: (context) => Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: CircleAvatar(
                      backgroundImage: AssetImage('assets/pfp.png')),
                )),
              ],
            ),
          ),

          // leading: CircleAvatar(),
          backgroundColor: Color.fromRGBO(17, 16, 19, 1),
          title: Row(
            children: [
              SizedBox(
                width: width * 0.15,
              ),
              Container(
                height: height * 0.02,
                width: width * 0.44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color.fromRGBO(34, 37, 41, 1),

                    value: dropdownValue1,
                    // Step 4.
                    items: <String>['Ethereum Mainnet', 'Cat', 'Tiger', 'Lion']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Constants.h5poppinsStyle,
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.13,
              ),
              Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor:
            const Color.fromRGBO(17, 16, 19, 1), // <-- This works for fixed
        selectedItemColor: const Color.fromRGBO(47, 137, 166, 1),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}

class ListViewItemForTokens extends StatelessWidget {
  final String name;
  final String amt;
  final String rate;
  final String percentage;
  ListViewItemForTokens(
      {required this.name,
      required this.amt,
      required this.rate,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_bitcoin,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Constants.h3poppinsStyle,
                  ),
                  Text(
                    amt,
                    style: Constants.h5poppinsStyle,
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.currency_rupee,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rate,
                    style: Constants.h4poppinsStyle,
                  ),
                  Text(
                    '$percentage%',
                    style: Constants.h6poppinsStyleGreaterWeight,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class IconWithContainerAndText extends StatelessWidget {
  final Icon icon;
  final String text;
  IconWithContainerAndText({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(47, 137, 166, 1),
            border: Border.all(
                width: 1, color: const Color.fromRGBO(36, 41, 47, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: icon,
        ),
        Text(
          text,
          style: Constants.h6poppinsStyleGreaterWeight,
        ),
      ],
    );
  }
}




// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     // DynamicLinkHandler.initDynamicLinks(context, FirebaseDynamicLinks.instance);
//     // DynamicLinkHandler().initUniLinks();
//     // TODO: implement initState
//     super.initState();
//   }

//   EncryptedSharedPreferences encryptedSharedPreferences =
//       EncryptedSharedPreferences();
//   List<DropdownMenuItem<String>> networks = [
//     DropdownMenuItem(child: Text("Ethereum Mainnet"), value: "ETH"),
//     DropdownMenuItem(child: Text("Goerli Testnet"), value: "GOERLI"),
//   ];
//   String selectedValue2 = "ETH";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(17, 16, 19, 1),
//       body: MyNavigationBar(),
//       // body: Center(
//       //   child: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     children: [
//       //       ElevatedButton(
//       //           onPressed: () {
//       //             Navigator.push(context,
//       //                 MaterialPageRoute(builder: (context) => SendScreen()));
//       //           },
//       //           child: Text("Send")),
//       //       ElevatedButton(
//       //           onPressed: () {
//       //             bottomSheet(context);
//       //           },
//       //           child: Text("Recieve")),
//       //       ElevatedButton(
//       //           onPressed: () {
//       //             Navigator.push(context,
//       //                 MaterialPageRoute(builder: (context) => SwapScreen()));
//       //           },
//       //           child: Text("Swap")),
//       //       ElevatedButton(
//       //           onPressed: () {
//       //             Navigator.push(
//       //                 context,
//       //                 MaterialPageRoute(
//       //                     builder: (context) => LendBorrowScreen()));
//       //           },
//       //           child: Text("Lend/Borrow")),
//       //       // ElevatedButton(
//       //       //     onPressed: () {
//       //       //       setState(() {
//       //       //         encryptedSharedPreferences.clear();
//       //       //         encryptedSharedPreferences.reload();
//       //       //       });
//       //       //     },
//       //       //     child: Text("LogOut")),
//       //     ],
//       //   ),
//       // ),
//     );
//   }

//   Future<dynamic> bottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//         useSafeArea: true,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) => Container(
//               // height: 200,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text("Recieve"),
//                   DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                           value: selectedValue2,
//                           items: networks,
//                           onChanged: (String? value) {
//                             setState(() {
//                               selectedValue2 = value.toString();
//                             });
//                             log(value.toString());
//                           })),
//                   QrImage(
//                     data: Constants.address,
//                     size: 150,
//                     backgroundColor: Colors.white,
//                     // foregroundColor: Colors.pinkAccent,
//                     errorStateBuilder: (cxt, err) {
//                       return const Center(
//                         child: Text(
//                           "Uh oh! Something went wrong...",
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     },
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(Constants.address),
//                       IconButton(
//                         onPressed: () {
//                           Clipboard.setData(
//                                   ClipboardData(text: Constants.address))
//                               .then((_) {
//                             Fluttertoast.showToast(msg: "Copied to Clipboard");
//                           });
//                         },
//                         icon: Icon(Icons.copy),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => RequestScreen()));
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(Icons.request_quote),
//                             Text("Request payment")
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [Icon(Icons.share), Text("Share Address")],
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//         context: context);
//   }
// }
