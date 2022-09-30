//
//  AddDailyNecessitiesView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 08/04/22.
//

import SwiftUI

struct AddDailyNecessitiesView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @StateObject var viewModel: DailyViewModel = DailyViewModel.shared
    @StateObject var transactionViewModel: TransactionViewModel = TransactionViewModel.shared
    
    @State var date: Date = Date()
    var transaction: Transaction?
    
    var body: some View {
        if viewModel.isShowDatePicker {
            NavigationView {
                VStack {
                    Form(
                        isShowDatePicker: $viewModel.isShowDatePicker,
                        note: $viewModel.note,
                        amount: $viewModel.amount,
                        selectedDate: $viewModel.date,
                        type: $viewModel.type
                    )
                    .navigationTitle(Text("Add "))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Label("Back", systemImage: "chevron.backward")
                        },
                        trailing: Button("Done",
                                         action: {
                                             viewModel.addItem()
                                             transactionViewModel.getAllTransaction()
                                         })
                        .disabled(viewModel.note.isEmpty)
                        .disabled(viewModel.amount.isEmpty)
                    )
                    
                    Spacer()
                }
                .padding()
            }
        } else {
            VStack {
                Form(
                    isShowDatePicker: $viewModel.isShowDatePicker,
                    note: $viewModel.note,
                    amount: $viewModel.amount,
                    selectedDate: $date,
                    type: $viewModel.type
                )
                .navigationTitle(Text("Add "))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Done",
                                                     action: {
                    viewModel.addItem()
                    transactionViewModel.getAllTransaction()
                    presentationMode.wrappedValue.dismiss()
                })
                    .disabled(viewModel.note.isEmpty)
                    .disabled(viewModel.amount.isEmpty)
                )
                
                Spacer()
            }
            .padding()
            .onAppear {
                if let date = transaction?.date {
                    self.date = date
                }
                
            }
        }
    }
}

//struct AddDailyNecessitiesView_Previews: PreviewProvider {
//
//    static var tanggal: Date? = Date()
//    @ObservedObject var viewModel: DailyViewModel
//
//    static var previews: some View {
//        AddDailyNecessitiesView(viewModel: viewModel ,isShowDatePicker: false)
//    }
//}
