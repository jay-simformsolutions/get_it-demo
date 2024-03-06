import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it_demo/const.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/payment/payment_bank_model.dart';
import 'package:get_it_demo/view/home_view_widget.dart';

class PayBillWidget extends StatefulWidget {
  const PayBillWidget({super.key});

  @override
  State<PayBillWidget> createState() => _PayBillWidgetState();
}

class _PayBillWidgetState extends State<PayBillWidget> {
  @override
  void initState() {
    super.initState();
    if (!getIt.hasScope(Const.payBillScope)) {
      getIt.pushNewScope(
        scopeName: Const.payBillScope,
        dispose: () {
          debugPrint('Dispose paybill scope');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:
                    getIt.get<PaymentBankModel>().getListOfBanks().length,
                itemBuilder: (context, index) {
                  final bank =
                      getIt.get<PaymentBankModel>().getListOfBanks()[index];

                  return Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bank Name is ${bank.bankName}'),
                          Text('Bank Name is ${bank.ifscCode}'),
                          Text('Bank Name is ${bank.branchName}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                _showDialogOfPaymentWidget(
                    context, getIt.get<PaymentBankModel>().billableAmount);
              },
              child: const Text('PayBill'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogOfPaymentWidget(BuildContext context, double amount) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Payment Dialog',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text('Are you sure you want to pay $amount'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      getIt.popScopesTill(Const.paymentScope);
                      /// Also called dispose it we provide at the time of registration
                      // getIt.reset(dispose: true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomeViewWidget()),
                        (route) => false,
                      );
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
              ],
            ),
          ],
        );
      },
    );
  }
}
