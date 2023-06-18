import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/view/widget/global_theme/general_appdrawer.dart';
import 'package:test_provider/viewmodel/foodbanksvm.dart';

class FoodbankPage extends StatefulWidget {
  const FoodbankPage({Key? key}) : super(key: key);

  @override
  State<FoodbankPage> createState() => _FoodbankPageState();
}

class _FoodbankPageState extends State<FoodbankPage>
    with TickerProviderStateMixin {
  Future<void> getFoodBankModel() async {
    await Provider.of<FoodBankModel>(context, listen: false)
        .getFoodBanksFromApi();
  }

  late AnimationController isjustloadingcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFoodBankModel();
    isjustloadingcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    isjustloadingcontroller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Foodbank"),
          ),
          drawer: const GeneralAppDrawer(),
          body: context.watch<FoodBankModel>().foodbanks.isEmpty
              ? Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 10,
                        value: isjustloadingcontroller.value,
                      )),
                )
              : Column(
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
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text((index + 1).toString()))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                      height: 100,
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                              "${context.watch<FoodBankModel>().foodbanks[index].name}"))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                      height: 150,
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                              "${context.watch<FoodBankModel>().foodbanks[index].address}"))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                      height: 100,
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text(
                                              "${context.watch<FoodBankModel>().foodbanks[index].phone}"))),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 100,
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text(
                                            context
                                                    .watch<FoodBankModel>()
                                                    .foodbanks[index]
                                                    .closed
                                                ? "Closed"
                                                : "Open",
                                            style: context
                                                    .watch<FoodBankModel>()
                                                    .foodbanks[index]
                                                    .closed
                                                ? const TextStyle(
                                                    color: Colors.red)
                                                : const TextStyle(
                                                    color: Colors.green),
                                          ))),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        "Cereal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      )),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.black,
                              ),
                          itemCount:
                              context.watch<FoodBankModel>().foodbanks.length),
                    ),
                  ],
                )),
    );
  }
}
