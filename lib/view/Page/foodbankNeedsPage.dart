import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/model/foodbank.dart';
import 'package:test_provider/view/widget/global_theme/general_appdrawer.dart';
import 'package:test_provider/viewmodel/foodbanksvm.dart';

class FoodbankNeedsPage extends StatefulWidget {
  const FoodbankNeedsPage({Key? key}) : super(key: key);

  @override
  State<FoodbankNeedsPage> createState() => _FoodbankNeedsPageState();
}

class _FoodbankNeedsPageState extends State<FoodbankNeedsPage> {
  final textController = TextEditingController();
  List<FoodBank> foodbanksByNeeds = [];
  Set<String> needs = {};

  @override
  void initState() {
    super.initState();
    Provider.of<FoodBankModel>(context, listen: false).foodbanksByNeeds.clear();
    Provider.of<FoodBankModel>(context, listen: false).needs.clear();
  }

  @override
  void didChangeDependencies() {
    foodbanksByNeeds =
        Provider.of<FoodBankModel>(context, listen: true).foodbanksByNeeds;
    needs = Provider.of<FoodBankModel>(context, listen: true).needs;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Donate Food"),
            ),
            drawer: const GeneralAppDrawer(),
            body: Column(children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 500,
                  child: _searchBar(),
                ),
              ),
              needs.isNotEmpty &&
                      Provider.of<FoodBankModel>(context, listen: true)
                              .status ==
                          1
                  ? Container(child: _dropdownmenu())
                  : Container(),
              foodbanksByNeeds.isNotEmpty &&
                      Provider.of<FoodBankModel>(context, listen: true)
                              .status ==
                          1
                  ? Expanded(child: _resultList())
                  : Expanded(child: Container()),
            ])));
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: TextField(
            controller: textController,
            maxLines: 1,
            onSubmitted: (value) {
              setState(() {
                textController.text = value;
              });
            },
          ),
        ),
        Expanded(
            flex: 2,
            child: TextButton(
                onPressed: () async {
                  setState(() {
                    print(textController.text);
                    foodbanksByNeeds.clear();
                    // needs.clear();
                  });

                  await Provider.of<FoodBankModel>(context, listen: false)
                      .getFoodBanksSearchFromApi(textController.text);
                  if (Provider.of<FoodBankModel>(context, listen: false)
                      .foodbanksByNeeds
                      .isNotEmpty) {
                    foodbanksByNeeds =
                        Provider.of<FoodBankModel>(context, listen: false)
                            .foodbanksByNeeds;
                  }
                },
                child: const Text("Search")))
      ],
    );
  }

  Widget _dropdownmenu() {
    return DropdownButton<String>(
        value: Provider.of<FoodBankModel>(context, listen: false).dropdownValue,
        items: Provider.of<FoodBankModel>(context, listen: true)
            .needs
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            Provider.of<FoodBankModel>(context, listen: false).dropdownValue =
                value!;
            Provider.of<FoodBankModel>(context, listen: false)
                .updatefoodbanksByNeeds();
          });
        });
  }

  Widget _resultList() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              flex: 1,
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Index",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
            Expanded(
              flex: 3,
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Foodbank name",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
            Expanded(
              flex: 3,
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
            Expanded(
              flex: 2,
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Phone no.",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Most needed food",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            )
          ],
        ),
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text((index + 1).toString()))),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text("${foodbanksByNeeds[index].name}"))),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          height: 150,
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child:
                                  Text("${foodbanksByNeeds[index].address}"))),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text("${foodbanksByNeeds[index].phone}"))),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                foodbanksByNeeds[index].closed
                                    ? "Closed"
                                    : "Open",
                                style: foodbanksByNeeds[index].closed
                                    ? const TextStyle(color: Colors.red)
                                    : const TextStyle(color: Colors.green),
                              ))),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "Cereal",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
              itemCount: foodbanksByNeeds.length),
        ),
      ],
    );
  }
}
