import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/nft/nft_screen.dart';
import 'package:test_project/presentation/main/nft_details/widgets/chip_button.dart';

class NFTDetailsScreen extends ConsumerWidget {
  const NFTDetailsScreen({super.key, this.collection});
  final NFTCollectionModel? collection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: size.height * .3,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Opacity(
                opacity: .6,
                child: Image.asset(
                  "assets/${collection!.image}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  DefaultTextStyle(
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${collection!.name} #${collection!.id}',
                                style: GoogleFonts.poppins()
                                    .copyWith(fontSize: 24),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.info_outline_rounded,
                                    size: 14,
                                    color: Color(0xFF37CBFA),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222529),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description:',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins()
                                    .copyWith(fontSize: 20),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${collection!.description}",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 348,
                          height: 142,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222529),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Network',
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Contract Address',
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Token Id',
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Send',
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChipButton(
                              label: "Send",
                              onPressed: () {},
                            ),
                            ChipButton(
                              label: "Share",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChipButton(
                                label: "View on opensea", onPressed: () {}),
                            ChipButton(
                                label: "View on explorer", onPressed: () {})
                          ],
                        )
                      ],
                    ),
                  ),
                ]))),
          )
        ],
      ),
    );
  }
}
