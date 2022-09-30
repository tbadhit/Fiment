//
//  DailyViewModel.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/04/22.
//

import SwiftUI
import CoreData

class DailyViewModel: ObservableObject {
    
    static let shared = DailyViewModel()
    
    private let dailyNecessitiesRepository: DailyNecessitiesRepository = DailyNecessitiesRepository()
    private let transactionRepository: TransactionRepository = TransactionRepository()
    
    @Published var dailyNecessities: [DailyNecessities] = []
    
    @Published var note: String = ""
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var type: String = "Income"
    
    @Published var isNewData: Bool = false
    @Published var isShowDatePicker: Bool = false
    
    func setShowDatePicker(data: Bool) {
        isShowDatePicker = data
    }
    
    func addItem() {
        
        guard let amount = Int64(amount) else {return}
        
        dailyNecessitiesRepository.addNewDailyNecessities(
            note: note,
            amount: amount,
            date: date,
            type: type,
            transactions: transactionRepository.getTransactions())
        
        if self.isShowDatePicker {
            self.isNewData.toggle()
        }
        self.note = ""
        self.amount = ""
        self.type = "Income"
        
    }
    
    func update(dailyNecessities: DailyNecessitiesEntity) {
        guard let amount = Int64(amount) else {return}
        
        dailyNecessitiesRepository.updateDailyNecessities(
            dailyNecessities: dailyNecessities,
            newNote: note,
            newAmount: amount,
            newDate: date,
            newType: type)
        
        if self.isShowDatePicker {
            self.isNewData.toggle()
        }
        self.note = ""
        self.amount = ""
        self.type = "Income"
    }
    
    func delete(_ item: DailyNecessitiesEntity) {
        dailyNecessitiesRepository.deleteDailyNecessities(dailyNecessities: item)
    }
}
