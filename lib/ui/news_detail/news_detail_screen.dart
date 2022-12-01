import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/model/news_list/news_list_main.dart';
import '../../res/app_context_extension.dart';
import '../../ui/utils/utility.dart';

import '../widget/app_widgets.dart';

class NewsDetailScreen extends StatefulWidget {

  static const String id = "news_detail_screen";
  final Article articleData;

  const NewsDetailScreen({required this.articleData, Key? key}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(context, context.resources.strings?.newsDetails ?? ""),
      body: Padding(
        padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Top image view with bottom start text
              Stack(
                children: [
                  Image.network(
                    widget.articleData.urlToImage,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/img_error.png');
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
                          widget.articleData.source?.name ?? "NA",
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
                widget.articleData.title,
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
                    text: widget.articleData.description,
                    style: context.resources.style.subHeadingTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                          text: context.resources.strings?.textReadMore ?? "",
                          style: context.resources.style.linkTextStyle,
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Utility.launchURL(widget.articleData.url);
                            if (kDebugMode) {
                              print("Click on read more: ${widget.articleData.url}");
                            }
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
                          text: widget.articleData.author.isEmpty ? context.resources.strings!.textNoAuthor : widget.articleData.author,
                          style: context.resources.style.headingTextStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
