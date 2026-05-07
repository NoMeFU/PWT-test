import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../gen/colors.gen.dart';

class ProfileNetworkImageWidget extends StatelessWidget {
  final String urls;
  const ProfileNetworkImageWidget({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:"$urls/$urls",
      fit: BoxFit.cover,
      placeholder: (context, url) => 
      // customShimmer(),
          Container(
            color: AppColors.cFFFFFF,

             ),
      errorWidget: (context, string, url) =>  
      // customShimmer()
          // Image.asset(Assets.images.placeholderImage.path),
          Container(
            color: AppColors.cFFFFFF, // child: const Icon(Icons.error),
            ),
    );
  }
}
