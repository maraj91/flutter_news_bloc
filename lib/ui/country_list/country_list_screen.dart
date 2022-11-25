import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_flutter_block/block/countries/country_bloc.dart';
import 'package:news_flutter_block/data/model/countries/CountryListMain.dart';
import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/ui/widget/app_widgets.dart';

class CountryListScreen extends StatefulWidget {
  static const String id = "country_list_screen";

  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late CountryBloc _countryBloc;
  int selectedPos = 2;

  @override
  void initState() {
    _countryBloc = BlocProvider.of(context);
    _countryBloc.add(CountriesFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorBG,
      appBar: AppWidgets.getAppBar(context, "Select Country"),
      body: BlocConsumer<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryInitial) {
            return AppWidgets.getCenterLoadingView();
          } else if (state is CountryError) {
            return AppWidgets.getBuildNoResult(
                context, "Error on countries data load");
          } else if (state is CountryDataLoaded) {
            if (state.data.data == null) {
              return AppWidgets.getBuildNoResult(
                  context, "Error on countries data load");
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _countryGridView(state.data.data ?? []),
              );
            }
          } else {
            return AppWidgets.getBuildNoResult(
                context, "Error on countries data load");
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _countryGridView(List<Data> countries) {
    return Center(
      child: GridView.builder(
        itemCount: countries.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery
              .of(context)
              .size
              .width /
              (MediaQuery
                  .of(context)
                  .size
                  .height / 1.75),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPos = index;
                });
              }, child: _countriesListItem(countries[index], index)
          );
        },
      ),
    );
  }

  Widget _countriesListItem(Data countries, int index) {
    return Stack(
      children: [
        Card(
          child: GridTile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppWidgets.getDefaultSizedBox(context),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: context.resources.color.colorAccent.shade800,
                    ),
                  ),
                  child: SvgPicture.network(
                    countries.flag ?? "",
                    height: 40,
                    fit: BoxFit.fill,
                    placeholderBuilder: (BuildContext context) =>
                        Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: context.resources.color.colorAppbarTitle,
                            ),
                          ),
                        ),
                  ),
                ),
                AppWidgets.getDefaultSizedBox(context),
                Container(
                  color: context.resources.color.colorAccent.shade800,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          countries.name ?? "NA",
                          style: context.resources.style.whiteTextSmallStyle,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
        index == selectedPos ? _setSelectedView(selectedPos) : Container()
      ],
    );
  }

  _setSelectedView(int selectedPos) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.check_circle,
          color: context.resources.color.colorAccent.shade800,
        ),
      ),
    );
  }
}
