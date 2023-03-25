import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/send/widgets/account_dropdownbutton.dart';
import 'package:test_project/presentation/main/send/widgets/asset_dropdown.dart';
import 'package:test_project/presentation/main/send/widgets/custom_button.dart';
import 'package:test_project/presentation/main/send/widgets/custom_text_field.dart';
import 'package:test_project/presentation/main/send/widgets/widget_text_field.dart';

import 'package:test_project/presentation/widget/button.dart';

class SendFundScreen extends ConsumerStatefulWidget {
  const SendFundScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SendFundScreenState();
  }
}

class _SendFundScreenState extends ConsumerState<SendFundScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: DefaultTextStyle(
            style: GoogleFonts.inter(
                color: Colors.white,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Text(
                      'From',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter().copyWith(
                        color: const Color.fromRGBO(55, 203, 250, 1),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  AccountDropDownButton(
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Text(
                      'To',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter().copyWith(
                        color: const Color.fromRGBO(55, 203, 250, 1),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  CustomTextField(
                    height: 50,
                    hint: "Enter ENS",
                    isFilled: false,
                    suffix: Icons.qr_code_2_sharp,
                    radius: 40,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(height: 24),
                  WidgetTextField(
                    height: 50,
                    hint: "0",
                    width: MediaQuery.of(context).size.width,
                    child: AssetDropDown(
                      onTap: _showBottomScrollAssetsSheet,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Balance: 1.5',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(102, 99, 99, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'MAX',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
      bottomNavigationBar: DefaultTextStyle(
        style: GoogleFonts.inter(
            color: Colors.white,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomActionButton(
                label: "Back",
                buttonStyle: CustomButtonStyle.outlined,
              ),
              CustomActionButton(
                label: "Confirm",
                buttonStyle: CustomButtonStyle.filled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show all the assets available
  void _showBottomScrollAssetsSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: true,
      elevation: 3,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(31), topRight: Radius.circular(31))),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: .65,
            maxChildSize: 1,
            expand: false,
            snap: true,
            builder: (context, scrollController) {
              return DefaultTextStyle(
                style: GoogleFonts.inter(
                    color: Colors.white,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Select an asset',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter()
                                          .copyWith(fontSize: 20))
                                ],
                              ),
                              const SizedBox(height: 24),
                              CustomTextField(
                                height: 50,
                                hint: "Search",
                                icon: Icons.search,
                                radius: 40,
                                width: MediaQuery.of(context).size.width,
                                onValidatorString: "Enter a valid entry",
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Popular tokens',
                                style:
                                    GoogleFonts.inter().copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 18),

                              //list of assets

                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ListTile(
                                title: Text("Ether",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 17)),
                                subtitle: Text("ETH",
                                    style: GoogleFonts.inter()
                                        .copyWith(fontSize: 11)),
                                trailing: Text(
                                  "₹100,758.98",
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 15),
                                ),
                                leading: const Icon(
                                  Icons.circle,
                                  size: 45,
                                ),
                              )
                            ]),
                      ])),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
