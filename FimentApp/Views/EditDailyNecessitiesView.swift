//
//  EditDailyNecessitiesView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 10/04/22.
//

import SwiftUI

struct EditDailyNecessitiesView: View {
    
    @StateObject var dailyViewModel: DailyViewModel = DailyViewModel.shared
    @StateObject var transactionViewModel: TransactionViewModel = TransactionViewModel.shared
    var dailyNecessities: DailyNecessitiesEntity
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            Form(
                isShowDatePicker: $dailyViewModel.isShowDatePicker,
                note: $dailyViewModel.note,
                amount: $dailyViewModel.amount,
                selectedDate: $dailyViewModel.date,
                type: $dailyViewModel.type
            )
            .navigationTitle(Text("Edit "))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(
                    "Save",
                    action: {
                        let oldDailyNecessitiesAmount = dailyNecessities.amount
                        let oldDailyNecessitiesType = dailyNecessities.type
                        
                        dailyViewModel.update(dailyNecessities: dailyNecessities)
                        
                        let updatedDailyNecessities = dailyNecessities
                        
                        transactionViewModel.update(updatedDailyNecessities, oldDailyNecessitiesAmount, oldDailyNecessitiesType)
                        
                        presentationMode.wrappedValue.dismiss()
                    })
                .disabled(dailyViewModel.note.isEmpty)
                .disabled(dailyViewModel.amount.isEmpty)
            )
        }
        .padding()
        .onAppear {
            dailyViewModel.isShowDatePicker = false
            dailyViewModel.note = dailyNecessities.note ?? ""
            dailyViewModel.amount = "\(dailyNecessities.amount)"
            dailyViewModel.date = dailyNecessities.date ?? Date()
            dailyViewModel.type = dailyNecessities.type ?? ""
        }
    }
}

//struct EditDailyNecessitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDailyNecessitiesView()
//    }
//}
