import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawbug829/common_widget/custom_app_bar.dart';
import 'package:lawbug829/common_widget/custom_button.dart';
import 'package:lawbug829/constants/text_font_style.dart';
import 'package:lawbug829/gen/assets.gen.dart';
import 'package:lawbug829/gen/colors.gen.dart';
import 'package:lawbug829/helpers/all_routes.dart';
import 'package:lawbug829/helpers/navigation_service.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/helpers/ui_helpers.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _controller = TextEditingController();

  final Dio _dio = Dio();
  List<dynamic> _suggestions = [];
  double? _lat;
  double? _lng;

  final String googleApiKey = 'AIzaSyDmNO0nvvAkkxk6rYBDQEfVXVQPB9rKlsk';

  void fetchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }

    const url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      final response = await _dio.get(url, queryParameters: {
        'input': input,
        'key': googleApiKey,
        'types': 'geocode',
        'components': 'country:bd'
      });

      if (response.statusCode == 200) {
        setState(() {
          _suggestions = response.data['predictions'];
        });
      }
    } catch (e) {
      log('Autocomplete Error: $e');
    }
  }

  void fetchLatLng(String placeId) async {
    const url = 'https://maps.googleapis.com/maps/api/place/details/json';

    try {
      final response = await _dio.get(url, queryParameters: {
        'place_id': placeId,
        'key': googleApiKey,
      });

      if (response.statusCode == 200) {
        final location = response.data['result']['geometry']['location'];
        setState(() {
          _lat = location['lat'];
          _lng = location['lng'];
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Location: $_lat, $_lng')),
        // );
      }
    } catch (e) {
      log('Place Details Error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _dio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Search Location',
            style: TextFontStyle.headline20c212B36stylepoppinsW500),
        leading: GestureDetector(
          onTap: () {
            NavigationService.goBack();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SvgPicture.asset(
              Assets.icons.arrowBackLawbug,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: 1.w,
              color: AppColors.cDFE3E8,
            ),
            UIHelper.verticalSpace(13.h),

            ///===================== Search Location ==============================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controller,
                    textInputAction: TextInputAction.done,
                    onChanged: fetchSuggestions,
                    cursorColor: AppColors.c000000,
                    cursorRadius: Radius.circular(8.r),
                    decoration: InputDecoration(
                      hintText: 'Search with location, Zip code',
                      hintStyle: TextFontStyle.headline20c212B36stylepoppinsW500
                          .copyWith(color: AppColors.c919EAB, fontSize: 14.sp),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: SvgPicture.asset(
                          Assets.icons.searchLawbug,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.c1D192B.withOpacity(0.01.r),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.c1D192B.withOpacity(0.01.r),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.c1D192B.withOpacity(0.01.r),
                        ),
                      ),
                      fillColor: AppColors.c1D192B.withOpacity(0.05.r),
                      filled: true,
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.deepOrangeAccent,
                              ),
                              onPressed: () {
                                _controller.clear();
                                _suggestions.clear();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                  UIHelper.verticalSpace(23.h),
                  Text(
                    'Suggestions',
                    style: TextFontStyle.headline20c212B36stylepoppinsW500
                        .copyWith(fontSize: 16.sp, color: AppColors.c919EAB),
                  ),
                  SizedBox(
                    height: 300
                        .h, // Or use MediaQuery.of(context).size.height * 0.4
                    child: _suggestions.isEmpty
                        ? const Center(
                            child: Text(
                              'No Suggestion Place',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _suggestions.length,
                            itemBuilder: (context, index) {
                              final item = _suggestions[index];
                              return ListTile(
                                leading: const Icon(Icons.location_on),
                                title: Text(item['description']),
                                onTap: () {
                                  _controller.text = item['description'];
                                  fetchLatLng(item['place_id']);
                                },
                              );
                            },
                          ),
                  ),
                  UIHelper.verticalSpace(163.h),
                  customeButton(
                    name: 'Confirm',
                    context: context,
                    onCallBack: () {
                      if (_controller.text.isEmpty) {
                        ToastUtil.showShortToast(
                            'Please Select the Place first');
                      } else {
                        NavigationService.navigateToWithArgs(
                            Routes.cuerrentLocationScreen,
                            {"lat": _lat, 'lng': _lng});
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIntro() {
    return Column(
      children: [
        Image.asset(
          Assets.images.recentSearchImage.path,
          width: 172.w,
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          'Recent searches',
          style: TextFontStyle.headline20c212B36stylepoppinsW500,
        ),
        UIHelper.verticalSpace(16.h),
        Text(
          'Your recent searches will appear here,\n so you can easily run your favorite\n searches',
          style: TextFontStyle.headline16c919EABstylepoppinsW400
              .copyWith(height: 1.5.h),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
