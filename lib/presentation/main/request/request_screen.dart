import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/request/widgets/text_field.dart';
import 'package:test_project/presentation/main/request/widgets/token_dialog_picker.dart';
import 'package:test_project/presentation/widget/button.dart';

class RequestFundScreen extends ConsumerStatefulWidget {
  const RequestFundScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RequestFundScreenState();
  }
}

class _RequestFundScreenState extends ConsumerState<RequestFundScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                floating: true,
                backgroundColor: Colors.transparent,
                forceElevated: innerBoxIsScrolled,
                title: const Text(
                  "Request",
                ),
                titleTextStyle: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700),
              )
            ];
          },
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Choose an asset to request',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    const SizedBox(height: 34),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomDropDownShowSheet(
                            onClick: _showBottomScrollAssetsSheet,
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: 56,
                          child: CustomTextField(
                            controller: _amountController,
                            hint: "Amount",
                            onValidatorString: "Amount is Required",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.5),
                    CustomButton(
                      onClick: () => {},
                      title: "Reset",
                      titleColor: const Color(0xFF2C83A0),
                      color: const Color(0xFF222529),
                    ),
                    const SizedBox(height: 18),
                    CustomButton(
                      onClick: _showBottomScrollConfirmationSheet,
                      title: "Confirm",
                    ),
                  ],
                ),
              ),
            ),
          )),
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
                                  style: GoogleFonts.inter()
                                      .copyWith(fontSize: 16),
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
        });
  }

  void _showBottomScrollConfirmationSheet() {
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 70,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                              )),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close)),
                          ),
                          const SizedBox(height: 24),
                          const Icon(Icons.share, size: 37),
                          const SizedBox(height: 4),
                          Text(
                            'Send Link',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter().copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Your request link is ready to send!',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter().copyWith(
                              color: const Color.fromRGBO(175, 169, 169, 1),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Send this link to a friend, and it will ask them to send 0.1 GoerliETH',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter().copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'https://avex.app.link/send/0xaC6Ec72eFbC6dc09E36AaA946b3Dd6C41D275169@5?value=le17',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter().copyWith(
                                color: const Color.fromRGBO(55, 203, 250, 1),
                                fontSize: 14),
                          ),
                          const Spacer(),
                          CustomButton(title: "Send Link", onClick: () {})
                        ]),
                  ),
                );
              });
        });
  }
}
