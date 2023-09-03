import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/constants/constants.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/db/models/banned_countries.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';
import 'package:flutter_card_scanner/widgets/custom_textfield.dart';

class SelectBannedCountriesView extends StatefulWidget {
  const SelectBannedCountriesView({Key? key}) : super(key: key);

  @override
  State<SelectBannedCountriesView> createState() =>
      _SelectBannedCountriesViewState();
}

class _SelectBannedCountriesViewState extends State<SelectBannedCountriesView> {
  List<String> _searchResults = [];

  List<String> _allCountries = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _allCountries.addAll(countries);
  }

  void addCountry(String country) {
    setState(() {
      DatabaseManager().addBannedCountry(country);
    });
  }

  void removeCountry(String country) {
    setState(() {
      DatabaseManager().removeBannedCountry(country);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Text('Select banned countries')),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormTextField(
                  label: "Search...",
                  controller: _searchController,
                  onChanged: (String? value) {
                    _searchResults.clear();
                    if (value != null && value.length > 3) {
                      for (var country in _allCountries) {
                        if (country
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          _searchResults.add(country);
                        }
                      }
                    }
                    setState(() {});
                  },
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _searchResults.clear();
                              _searchController.clear();
                            });
                          },
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<BannedCountry>>(
                    stream: DatabaseManager().watchBannedCountries(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active &&
                          snapshot.hasData) {
                        List<BannedCountry> bannedCountries = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BannedCountriesChips(
                              bannedCountries: bannedCountries,
                              removeCountry: removeCountry,
                            ),
                            Expanded(
                              child: _searchResults.isEmpty
                                  ? ListView.builder(
                                      key: const PageStorageKey(0),
                                      shrinkWrap: true,
                                      itemCount: _allCountries.length,
                                      itemBuilder: (context, index) {
                                        String country = _allCountries[index];
                                        return CountryItem(
                                          country: country,
                                          addCountry: addCountry,
                                          selected: bannedCountries.any(
                                              (element) =>
                                                  element.country == country),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      key: const PageStorageKey(1),
                                      shrinkWrap: true,
                                      itemCount: _searchResults.length,
                                      itemBuilder: (context, index) {
                                        String country = _searchResults[index];
                                        return CountryItem(
                                          country: country,
                                          addCountry: addCountry,
                                          selected: bannedCountries.any(
                                              (element) =>
                                                  element.country == country),
                                        );
                                      },
                                    ),
                            )
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}

class BannedCountriesChips extends StatelessWidget {
  const BannedCountriesChips({
    super.key,
    required this.bannedCountries,
    required this.removeCountry,
  });

  final List<BannedCountry> bannedCountries;
  final Function(String) removeCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Banned countries"),
          Wrap(
            children: bannedCountries
                .map((bannedCountry) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Chip(
                        label: Text(bannedCountry.country),
                        deleteIcon: const Icon(Icons.clear),
                        onDeleted: () {
                          removeCountry(bannedCountry.country);
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem({
    super.key,
    required this.country,
    required this.addCountry,
    this.selected = false,
  });

  final String country;
  final Function(String) addCountry;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
        stream: DatabaseManager().watchCollection(),
        builder: (context, snapshot) {
          return ListTile(
            leading: CustomCheckbox(
              value: selected,
            ),
            title: Text(country),
            onTap: () {
              addCountry.call(country);
            },
          );
        });
  }
}

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    Key? key,
    required this.value,
  }) : super(key: key);

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 24.0,
            width: 24.0,
            decoration: BoxDecoration(
              color: value ? AppColor.checkboxFill : Colors.transparent,
              border: Border.all(
                  width: 1.0,
                  color: value ? AppColor.checkboxFill : AppColor.fieldBorder),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Center(
              child: value
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectCountry {
  String country;
  bool selected;

  SelectCountry({
    required this.country,
    this.selected = false,
  });

  static SelectCountry fromBannedCountry(BannedCountry bannedCountry) {
    return SelectCountry(country: bannedCountry.country, selected: true);
  }
}
