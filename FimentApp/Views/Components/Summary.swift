//
//  Summary.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 09/04/22.
//

import SwiftUI

struct Summary: View {
    var title: String
    var amount: String
    var color: Color?
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(amount).foregroundColor(color)
        }
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary(title: "", amount: "")
    }
}

struct SummaryView: View {
    var balance: String
    var income: String
    var expense: String
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Summary
            Summary(title: "Balance :", amount: balance)
            Divider()
            Summary(title: "Income :", amount: income, color: .green)
            Divider()
            Summary(title: "Expense :", amount: expense, color: .red)
            Divider()
            
            Text("My Transaction")
                .font(.title2)
                .bold()
                .padding(.vertical)
            
        }
        .padding(.top, 5)
    }
}
