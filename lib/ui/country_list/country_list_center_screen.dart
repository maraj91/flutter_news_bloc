import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/countries/country_bloc.dart';
import '../../data/model/countries/CountryListMain.dart';
import '../../res/app_context_extension.dart';
import '../../ui/widget/app_widgets.dart';

class CountryListCenterScreen extends StatefulWidget {
  static const String id = "country_list_center_screen";

  String selectedCountry;

  CountryListCenterScreen({required this.selectedCountry, Key? key})
      : super(key: key);

  @override
  State<CountryListCenterScreen> createState() =>
      _CountryListCenterScreenState();
}

class _CountryListCenterScreenState extends State<CountryListCenterScreen> {
  late CountryBloc _countryBloc;
  final double runSpacing = 2;
  final double spacing = 2;
  final columns = 3;
  final TextEditingController _searchTextEditController =
      TextEditingController();
  late List<Data> _countryData;
  late List<Data> _filterCountryData = [];

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
      appBar: AppWidgets.getAppBarWithSingleIcon(context, "Select Country", () {
        Navigator.pop(context, widget.selectedCountry);
      }, const Icon(Icons.done_outline_sharp)),
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
              _countryData = state.data.data ?? [];
              if(_filterCountryData.isEmpty) {
                _filterCountryData = _countryData;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AppWidgets.getDefaultSizedBox(context),
                    TextField(
                        controller: _searchTextEditController,
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintText: 'Search Country...',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel_outlined),
                              color: Colors.grey,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _searchTextEditController.clear();
                                _filterCountryData = _countryData;
                              },
                            )
                        )
                    ),
                    AppWidgets.getDefaultSizedBox(context),
                    Expanded(child: _countryGridView()),
                  ],
                ),
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

  Widget _countryGridView() {
    final w = (MediaQuery.of(context).size.width) / columns - (spacing * columns) - 1;
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: List.generate(_filterCountryData.length, (index) {
          return SizedBox(
            width: w,
            height: w,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedCountry = _filterCountryData[index].code!;
                    if (kDebugMode) {
                      print(
                          "Selected Country -->> ${_filterCountryData[index].name}");
                    }
                  });
                },
                child: _countriesListItem(_filterCountryData[index], index,w)),
          );
        }),
      ),
    );
  }

  Widget _countriesListItem(Data countries, int index, double width) {
    return Stack(
      children: [
        Card(
          elevation: 8,
          child: GridTile(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4.0,
                      color: countries.code == widget.selectedCountry ? context.resources.color.countrySelectionBorderColor :context.resources.color.colorBG,
                    ),
                  ),
                  child: SvgPicture.network(
                    countries.flag ?? "",
                    height: width,
                    fit: BoxFit.scaleDown,
                    placeholderBuilder: (BuildContext context) => Container(
                      height: width,
                      width: width,
                      child: Center(
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: context.resources.color.countryBottomLabel,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        countries.name ?? "NA",
                        style: context.resources.style.whiteTextSmallStyle,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        countries.code == widget.selectedCountry
            ? _setSelectedView()
            : Container()
      ],
    );
  }

  _setSelectedView() {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.check_sharp,
          color: context.resources.color.countrySelectionBorderColor,
        ),
      ),
    );
  }

  _runFilter(String value) {
    List<Data>? result = [];
    if (value.isEmpty) {
      result = _countryData;
    } else {
      result = _countryData
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _filterCountryData = result!;
    });
  }
}
