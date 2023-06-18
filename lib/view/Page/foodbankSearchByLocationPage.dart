import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/model/foodbank.dart';
import 'package:test_provider/view/widget/global_theme/general_appdrawer.dart';
import 'package:test_provider/viewmodel/foodbanksvm.dart';

class FoodbankSearchByLocationPage extends StatefulWidget {
  const FoodbankSearchByLocationPage({Key? key}) : super(key: key);

  @override
  State<FoodbankSearchByLocationPage> createState() =>
      _FoodbankSearchByLocationPageState();
}

class _FoodbankSearchByLocationPageState
    extends State<FoodbankSearchByLocationPage> {
  final textController = TextEditingController();
  List<FoodBank> foodbanksByLocation = [];

  @override
  void initState() {
    super.initState();
    Provider.of<FoodBankModel>(context, listen: false)
        .foodbanksByLocation
        .clear();
  }

  @override
  void didChangeDependencies() {
    foodbanksByLocation;
    Provider.of<FoodBankModel>(context, listen: true).foodbanksByLocation;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Foodbank Search By Location"),
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
              foodbanksByLocation.isNotEmpty
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
                    foodbanksByLocation.clear();
                  });

                  await Provider.of<FoodBankModel>(context, listen: false)
                      .getFoodBanksSearchFromApi(textController.text);
                  if (Provider.of<FoodBankModel>(context, listen: false)
                      .foodbanksByLocation
                      .isNotEmpty) {
                    foodbanksByLocation =
                        Provider.of<FoodBankModel>(context, listen: false)
                            .foodbanksByLocation;
                  }
                },
                child: const Text("Search")))
      ],
    );
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
                              child:
                                  Text("${foodbanksByLocation[index].name}"))),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          height: 150,
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                  "${foodbanksByLocation[index].address}"))),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child:
                                  Text("${foodbanksByLocation[index].phone}"))),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 100,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                foodbanksByLocation[index].closed
                                    ? "Closed"
                                    : "Open",
                                style: foodbanksByLocation[index].closed
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
              itemCount: foodbanksByLocation.length),
        ),
      ],
    );
  }
}
