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
  List<String> _bannedCountries = [];

  List<SelectCountry> _searchResults = [];

  List<SelectCountry> _countries = [];

  List<SelectCountry> _selectedCountries = [];

  final _searchController = TextEditingController();
  Future<List<BannedCountry>> getBannedCountries =
      DatabaseManager().getBannedCountries();

  @override
  void initState() {
    super.initState();

    DatabaseManager().getBannedCountries().then((value) {
      for (var bannedCountry in value) {
        var selectedCountry = SelectCountry.fromBannedCountry(bannedCountry);
        _selectedCountries.add(selectedCountry);
      }
      for (var country in countries) {
        _countries.add(SelectCountry(
          country: country,
          selected:
              _selectedCountries.any((element) => element.country == country),
        ));
      }
    });
  }

  void selectCountry(SelectCountry selectCountry) {
    setState(() {
      selectCountry.selected = !selectCountry.selected;
      if (selectCountry.selected) {
        DatabaseManager().addBannedCountry(selectCountry);
        // _selectedCountries.add(selectCountry);
      } else {
        removeCountry(selectCountry.country);
        // _selectedCountries.remove(selectCountry);
      }
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
                      for (var selectCountry in _countries) {
                        if (selectCountry.country
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          _searchResults.add(selectCountry);
                        }
                      }
                    }
                    setState(() {});
                  },
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        _searchResults.clear();
                        _searchController.clear();
                      });
                    },
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
                                      shrinkWrap: true,
                                      itemCount: _countries.length,
                                      itemBuilder: (context, index) {
                                        SelectCountry country =
                                            _countries[index];
                                        return CountryItem(
                                          country: country,
                                          selectCountry: selectCountry,
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _searchResults.length,
                                      itemBuilder: (context, index) {
                                        SelectCountry country =
                                            _searchResults[index];
                                        return CountryItem(
                                          country: country,
                                          selectCountry: selectCountry,
                                        );
                                      },
                                    ),
                            )
                          ],
                        );
                      }
                      return Container();
                    }),
              ),
              ElevatedButton(
                onPressed: () async {
                  await DatabaseManager().saveBannedCountries(countries);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
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
          const Text("Selected countries"),
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

class CountryItem extends StatefulWidget {
  const CountryItem({
    super.key,
    required this.country,
    required this.selectCountry,
  });

  final SelectCountry country;
  final Function(SelectCountry) selectCountry;

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomCheckbox(
        value: widget.country.selected,
      ),
      title: Text(widget.country.country),
      onTap: () {
        widget.selectCountry.call(widget.country);
      },
    );
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
