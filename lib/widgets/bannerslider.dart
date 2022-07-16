import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';
import 'package:nike/data/models/banner.dart';
import 'package:nike/widgets/imageloadingservice.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<BannerEntity> banners;
  BannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) => _Slider(
                    banner: banners[index],
                  )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 5,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4,
                    radius: 5,
                    dotWidth: 20,
                    dotHeight: 3.5,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: LightThemeColors.primaryTextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final BannerEntity banner;
  const _Slider({
    Key? key,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ImageLoadingService(
        imageUrl: banner.imageUrl,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
