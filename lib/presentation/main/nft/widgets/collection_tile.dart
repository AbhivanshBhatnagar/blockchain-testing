import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/presentation/main/nft/nft_screen.dart';

class NFTCollectionTile extends ConsumerWidget {
  const NFTCollectionTile({super.key, this.collection, this.onPressed});

  final NFTCollectionModel? collection;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Opacity(
            opacity: .3,
            child: Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/${collection!.image}'),
                  fit: BoxFit.fitWidth),
            )),
          ),
          Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/${collection!.image}'),
                    fit: BoxFit.fitWidth),
              ))
        ],
      ),
    );
  }
}
