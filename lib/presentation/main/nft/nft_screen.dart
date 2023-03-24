import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/main/nft/widgets/collection_tile.dart';
import 'package:test_project/presentation/nft_details/nft_details_screen.dart';

class NFTCollectionModel {
  final String? image;
  final String? name;
  final int? id;
  final String? description;

  const NFTCollectionModel({this.description, this.id, this.image, this.name});
}

const items = <NFTCollectionModel>[
  NFTCollectionModel(
      name: "Dino",
      id: 2238,
      image: "dino.png",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the"),
  NFTCollectionModel(
      name: "Dino 3",
      id: 2238,
      image: "dino_1.png",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the"),
  NFTCollectionModel(
      name: "Dino Pink",
      id: 2138,
      image: "dino_2.png",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the"),
  NFTCollectionModel(
      name: "Dino G",
      id: 1138,
      image: "dino_3.png",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the"),
  NFTCollectionModel(
      name: "Dinox",
      id: 2448,
      image: "dino_4.png",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the")
];

class NFTScreen extends ConsumerWidget {
  const NFTScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(
                    "Kaiji Kinz Collection",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 24),
                  )
                ],
              ),
              SizedBox(height: size.height * .05),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 163,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return NFTCollectionTile(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => NFTDetailsScreen(
                                    collection: items.elementAt(index)))),
                        collection: items.elementAt(index));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
