//
//  ListTransactionView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 07/04/22.
//

import SwiftUI

struct ItemTransactionView: View {
    
    @FetchRequest private var listDailyNecessities: FetchedResults<DailyNecessitiesEntity>
    
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.date, style: .date)
                Spacer()
                ContainerRelativeShape().padding(4).foregroundColor(.red).frame(width: 20, height: 20)
            }
            Divider()
            HStack {
                Text("Total :")
                Spacer()
                Text(toRupiah(number: transaction.totalIncome)).foregroundColor(.green)
                Spacer()
                Text(toRupiah(number: transaction.totalExpense)).foregroundColor(.red)
            }
            Divider()
            ForEach(listDailyNecessities) { dn in
                ItemDailyNecessitiesView(note: dn.note ?? "" , amount: String(dn.amount), type: dn.type ?? "" )
            }
            
        }
        .padding()
        .border(.black, width: 1)
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
        _listDailyNecessities = DailyNecessitiesRepository.getByTransactionPredicates(transaction: transaction)
    }
}
