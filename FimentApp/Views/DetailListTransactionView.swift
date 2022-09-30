//
//  DetailListTransactionView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 08/04/22.
//

import SwiftUI

struct DetailListTransactionView: View {
    
    @StateObject var dailyViewModel: DailyViewModel = DailyViewModel.shared
    @StateObject var transactionViewModel: TransactionViewModel = TransactionViewModel.shared
    @FetchRequest private var listDailyNecessities: FetchedResults<DailyNecessitiesEntity>
    
    var transaction: Transaction
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Total :")
                    Spacer()
                    Text(toRupiah(number: Int64(transaction.totalIncome) )).foregroundColor(.green)
                    Spacer()
                    Text(toRupiah(number: Int64(transaction.totalExpense) )).foregroundColor(.red)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(listDailyNecessities) {data in
                        NavigationLink(destination: EditDailyNecessitiesView(dailyNecessities: data)) {
                            ItemDailyNecessitiesView(note: data.note ?? "" , amount: String(data.amount), type: data.type ?? "" )
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
            }
            .navigationTitle(Text(transaction.date, style: .date))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Hi",systemImage: "chevron.backward")
                },
                
                trailing: NavigationLink(destination: AddDailyNecessitiesView(date:transaction.date, transaction: transaction)) {
                    Text("Add")
                }.simultaneousGesture(TapGesture().onEnded({
                    dailyViewModel.setShowDatePicker(data: false)
                }))
            )
            
            .padding(.top, 30)
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let itemDailyNecessities = listDailyNecessities[index]
            if itemDailyNecessities.type == "Income" {
                let newTotalIncome = transaction.totalIncome - itemDailyNecessities.amount
                transactionViewModel.updateTotalIncome(transaction: transaction, newTotalIncome: newTotalIncome)
            } else {
                let newTotalExpense = transaction.totalExpense - itemDailyNecessities.amount
                transactionViewModel.updateTotalExpense(transaction: transaction, newTotalExpense: newTotalExpense)
            }
            dailyViewModel.delete(itemDailyNecessities)
            if listDailyNecessities.isEmpty {
                transactionViewModel.delete(transaction)
                transactionViewModel.getAllTransaction()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
        _listDailyNecessities = DailyNecessitiesRepository.getByTransactionPredicates(transaction: transaction)
    }
}
