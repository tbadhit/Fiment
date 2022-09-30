//
//  MonthlyView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 07/04/22.
//

import SwiftUI

struct MonthlyView: View {
    @StateObject var transactionViewModel = TransactionViewModel.shared
    
    var body: some View {
            List {
                // MARK: Summary
                SummaryView(
                    balance: toRupiah(number: transactionViewModel.balance),
                    income: toRupiah(number: transactionViewModel.income),
                    expense: toRupiah(number: transactionViewModel.expense)
                )
                
                // MARK: List transaction monthly (Data Dummy)
                ItemTransactionMonthly(date: "April 2022", income: "Rp. 1.000.000", expense: "Rp. 10.000")
                ItemTransactionMonthly(date: "March 2022", income: "Rp. 1.000.000", expense: "Rp. 900.000")
            }
        
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
    }
}

struct ItemTransactionMonthly: View {
    var date: String
    var income: String
    var expense: String
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(date)
                .font(.system(size: 15))
            Spacer()
            Text(income)
                .font(.system(size: 15))
                .foregroundColor(.green)
            Spacer()
            Text(expense)
                .font(.system(size: 15)).foregroundColor(.red)
        }
    }
}
