import 'package:flutter/material.dart';
import 'package:get_it_demo/const.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/view/payment/bank_list_widget.dart';
import 'package:get_it_demo/repository/payment/payment_bank_model.dart';
import 'package:get_it_demo/view/payment/pay_bill.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late TextEditingController amount;
  late TextEditingController discountAmount;

  @override
  void initState() {
    super.initState();
    if (!getIt.hasScope(Const.paymentScope)) {
      getIt.pushNewScope(
        scopeName: Const.paymentScope,
        init: (getIt) => getIt.registerLazySingleton(() => PaymentBankModel()),
        dispose: () {
          debugPrint('Dispose is called from the payment screen');
          amount.dispose();
          discountAmount.dispose();
        },
      );
    }
    amount = TextEditingController();
    discountAmount = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  labelText: 'Enter Discount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: discountAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Discount',
                  labelText: 'Enter Discount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  getIt.get<PaymentBankModel>().totalBillAmount(
                        int.parse(amount.text),
                        int.parse(discountAmount.text),
                      );
                  setState(() {});
                },
                child: const Text('Generate Bill'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Total Bill is ${getIt.get<PaymentBankModel>().billableAmount}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PayBillWidget(),
                    ),
                  );
                },
                child: const Text('Pay Bill'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BankListWidget(),
                    ),
                  );
                },
                child: const Text('Get List of Bank Widget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
