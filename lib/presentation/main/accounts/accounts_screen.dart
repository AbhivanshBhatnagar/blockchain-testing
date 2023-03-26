import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:test_project/presentation/main/accounts/widgets/account_card.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AccountsScreenState();
  }
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
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
      backgroundColor: const Color(0xFF28809E),
      body: SafeArea(
          child: DefaultTextStyle(
        style: GoogleFonts.inter(
            color: Colors.white,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Text('Total Value',
                textAlign: TextAlign.left,
                style: GoogleFonts.inter().copyWith(fontSize: 20)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$",
                  style: GoogleFonts.inter().copyWith(fontSize: 45, height: 1),
                ),
                McCountingText(
                  begin: 0,
                  end: double.parse("257.420"),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter().copyWith(fontSize: 45),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: size.height * .7,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color.fromRGBO(15, 14, 14, 1),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {},
                        color: const Color(0xFF28809E),
                        child: const Text("Send"),
                      ),
                      IconButton(
                          onPressed: () => _showBottomScrollSheet(
                              _buildCreateAccountWidget(), .3, .3),
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return const CustomAccountDetailsCard();
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 12);
                          },
                          itemCount: 5))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _showBottomScrollSheet(Widget body, initialChildSize, maxChildSize) {
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
              expand: false,
              snap: false,
              minChildSize: 0,
              initialChildSize: initialChildSize,
              maxChildSize: maxChildSize,
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
                          body,
                        ])),
                      )
                    ],
                  ),
                );
              });
        });
  }
}

Widget _buildCreateAccountWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/monkey.png"),
          ),
          Positioned(
              right: -8,
              bottom: 2,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: const Color(0xFF222529)),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 15,
                ),
              ))
        ],
      ),
      const SizedBox(height: 24),
      Text(
        'Account 23',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
      const SizedBox(height: 24),
      MaterialButton(
        minWidth: 148,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {},
        color: const Color(0xFF28809E),
        child: const Text("Create"),
      ),
    ],
  );
}
