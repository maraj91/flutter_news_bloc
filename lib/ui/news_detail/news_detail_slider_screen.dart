import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter_block/data/model/news_list/news_list_main.dart';
import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/ui/utils/utility.dart';

import '../widget/app_widgets.dart';

class NewsDetailSliderScreen extends StatefulWidget {

  static const String id = "news_detail_slider_screen";
  List<Article> newsList = [];

  NewsDetailSliderScreen({required this.newsList,Key? key}) : super(key: key);

  @override
  State<NewsDetailSliderScreen> createState() => _NewsDetailSliderScreenState();
}

class _NewsDetailSliderScreenState extends State<NewsDetailSliderScreen> {

  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(context, context.resources.strings?.newsHome ?? ""),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
              child: PageView.builder(itemBuilder: (context, index) {
                return NewsPages(articleData: widget.newsList[index]);
              },
                itemCount: widget.newsList.length,
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                // physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  currentPage = value;
                },
              ),
            ),
          ),
          const Text("Swipe  view to left-right")
        ],
      ),
    );
  }
}

class NewsPages extends StatelessWidget {
  final Article articleData;
  const NewsPages({required this.articleData,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Top image view with bottom start text
          Stack(
            children: [
              Image.network(
                articleData.urlToImage,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(context.resources.drawable.imgError);
                },
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width - 16,
              ),
              Positioned(
                bottom: 10,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: context.resources.color.colorAccent.shade800,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      articleData.source?.name ?? "NA",
                      style: context.resources.style.whiteTextStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          //Space between widget
          AppWidgets.getDefaultSizedBox(context),
          //News title text
          Text(
            articleData.title,
            style: context.resources.style.headingTextStyle,
          ),
          //Space between widget
          AppWidgets.getDefaultSizedBox(context),
          //News description with 'Read more' text
          Container(
            alignment: AlignmentDirectional.topStart,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: articleData.description,
                style: context.resources.style.subHeadingTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: context.resources.strings?.textReadMore ?? "",
                      style: context.resources.style.linkTextStyle,
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Utility.launchURL(articleData.url);
                      }
                  ),
                ],
              ),
            ),
          ),
          //Space between widget
          AppWidgets.getDefaultSizedBox(context),
          //Author name
          Container(
            alignment: AlignmentDirectional.topStart,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: context.resources.strings?.newsAuthorTitle ?? "",
                style: context.resources.style.subHeadingTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: articleData.author,
                      style: context.resources.style.headingTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

