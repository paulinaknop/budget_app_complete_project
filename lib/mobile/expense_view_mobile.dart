import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components.dart';
import '../view_model.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final double categoryWidth = MediaQuery.of(context).size.width;

    if (isLoading == true) {
      viewModelProvider.expensesStream();
      viewModelProvider.incomesStream();
      isLoading = false;
    }
    int totalExpense = 0;
    int totalIncome = 0;
    void calculate() {
      for (int i = 0; i < viewModelProvider.expensesAmount.length; i++) {
        totalExpense =
            totalExpense + int.parse(viewModelProvider.expensesAmount[i]);
      }
      for (int i = 0; i < viewModelProvider.incomesAmount.length; i++) {
        totalIncome =
            totalIncome + int.parse(viewModelProvider.incomesAmount[i]);
      }
    }

    calculate();
    int budgetLeft = totalIncome - totalExpense;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.black)),
                  child: CircleAvatar(
                    radius: 180.0,
                    backgroundColor: Colors.white,
                    child: Image(
                      height: 100.0,
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 50.0,
                minWidth: 200.0,
                color: Colors.black,
                child: OpenSans(
                  text: "Logout",
                  size: 20.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await viewModelProvider.logout();
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async => await launchUrl(
                        Uri.parse("https://www.twitter.com/tomcruise")),
                    icon: SvgPicture.asset(
                      "assets/instagram.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async => await launchUrl(
                        Uri.parse("https://www.twitter.com/tomcruise")),
                    icon: SvgPicture.asset(
                      "assets/twitter.svg",
                      color: Colors.black,
                      width: 35.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 30.0),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Poppins(
            text: "Dashboard",
            size: 20.0,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await viewModelProvider.reset();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 40.0),
            Column(
              children: [
                Container(
                  height: 240.0,
                  width: categoryWidth / 1.5,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Poppins(
                            text: "Budget left",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total Expense",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: "Total Income",
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          indent: 40.0,
                          endIndent: 40.0,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Poppins(
                            text: " $budgetLeft\$",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: " $totalExpense\$",
                            size: 14.0,
                            color: Colors.white,
                          ),
                          Poppins(
                            text: " $totalIncome\$",
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Add expense
                SizedBox(
                  height: 40.0,
                  width: 155.0,
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        OpenSans(
                          text: "Add Expense",
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await viewModelProvider.addExpense(context);
                    },
                    splashColor: Colors.grey,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(width: 10.0),
                //Add income
                SizedBox(
                  height: 40.0,
                  width: 155.0,
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        OpenSans(
                          text: "Add Income",
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      await viewModelProvider.addIncome(context);
                    },
                    splashColor: Colors.grey,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //expense list
                  Column(
                    children: [
                      OpenSans(
                        text: "Expenses",
                        size: 15.0,
                        color: Colors.black,
                      ),
                      Container(
                          padding: EdgeInsets.all(7.0),
                          height: 210,
                          width: 180.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.black)),
                          child: ListView.builder(
                            itemCount: viewModelProvider.expensesAmount.length,
                            itemBuilder: (BuildContext context, int index) {
                              return IncomeExpenseRowMobile(
                                text: viewModelProvider.expensesName[index],
                                amount: viewModelProvider.expensesAmount[index],
                              );
                            },
                          )),
                    ],
                  ),

                  //income list
                  Column(
                    children: [
                      OpenSans(
                        text: "Incomes",
                        size: 15.0,
                        color: Colors.black,
                      ),
                      Container(
                          padding: EdgeInsets.all(7.0),
                          height: 210,
                          width: 180.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.black)),
                          child: ListView.builder(
                            itemCount: viewModelProvider.incomesAmount.length,
                            itemBuilder: (BuildContext context, int index) {
                              return IncomeExpenseRowMobile(
                                text: viewModelProvider.incomesName[index],
                                amount: viewModelProvider.incomesAmount[index],
                              );
                            },
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
