import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../gen/colors.gen.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String urls;
  const CustomNetworkImageWidget({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:urls,
      fit: BoxFit.cover,
      placeholder: (context, url) => 
      // customShimmer(),
          Container(
            padding: const EdgeInsets.all(14),
            color: AppColors.cF8F8F8,
           ),
      errorWidget: (context, string, url) =>  
      // customShimmer()
          // Image.asset(Assets.images.placeholderImage.path),
          Container(
            color: AppColors.cFFFFFF,
            ),
    );
  }
}


