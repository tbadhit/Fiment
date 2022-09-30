//
//  DailyView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 07/04/22.
//

import SwiftUI

struct DailyView: View {
    
    @StateObject var transactionViewModel = TransactionViewModel.shared
    
    @State var selectedTransaction: Transaction?
    
    var body: some View {
        List {
            // MARK: Summary
            SummaryView(
                balance: toRupiah(number: transactionViewModel.balance),
                income: toRupiah(number: transactionViewModel.income),
                expense: toRupiah(number: transactionViewModel.expense)
            )
            
            // MARK: List Transaction
            ForEach(transactionViewModel.transactions, id: \.id) {transaction in
                Button(action: {
                    transactionViewModel.isDetailListTransaction.toggle()
                    self.selectedTransaction = transaction
                }) {
                    ItemTransactionView(transaction: transaction)
                }
            }
            
        }
        
        // MARK: List detail sheet
        .sheet(isPresented: $transactionViewModel.isDetailListTransaction) {
            if let transaction = self.selectedTransaction {
                DetailListTransactionView(transaction: transaction)
            }
        }
        
        .navigationBarTitleDisplayMode(.automatic)
        
        
        .onAppear{
            transactionViewModel.getAllTransaction()
            for i in transactionViewModel.transactions {
                print("Transaksi :\(i)")
            }
        }
    }
}

//struct DailyView_Previews: PreviewProvider {
//    static var t: TransactionEntity = TransactionEntity()
//    static var previews: some View {
//        DailyView(selectedTransaction: t)
//    }
//}
