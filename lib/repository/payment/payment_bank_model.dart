import 'package:get_it_demo/domain/model/bank_model.dart';

class PaymentBankModel{
  double billableAmount = 0.0;

  double totalBillAmount(int amount, int discount){
    double discountAmount = (amount * discount) / 100;
    billableAmount = amount - discountAmount;
    return billableAmount;
  }

  List<BankModel> getListOfBanks(){
    List<BankModel> bankList = [];
    for(int i=0; i<1000; i++){
      final bank = BankModel();
      bank.bankName = i.toString();
      bank.branchName = i.toString();
      bank.ifscCode = i.toString();
      bankList.add(bank);
    }
    return bankList;
  }
}