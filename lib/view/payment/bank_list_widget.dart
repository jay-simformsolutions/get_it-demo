import 'package:flutter/material.dart';
import 'package:get_it_demo/locator.dart';

import '../../repository/payment/payment_bank_model.dart';

class BankListWidget extends StatelessWidget {
  const BankListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: getIt.get<PaymentBankModel>().getListOfBanks().length,
          itemBuilder: (context, index) {
            return Text(
              'Bank List is ${getIt.get<PaymentBankModel>().getListOfBanks()[index].bankName}',
            );
          },
        ),
      ),
    );
  }
}
