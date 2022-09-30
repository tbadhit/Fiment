//
//  DailyNecessitiesRepository.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/09/22.
//

import CoreData
import SwiftUI

class DailyNecessitiesRepository {
    private let context: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        context = viewContext
    }
    
    private func save() {
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
}

extension DailyNecessitiesRepository {
    
    static func getByTransactionPredicates(transaction: Transaction) -> FetchRequest<DailyNecessitiesEntity> {
        return FetchRequest<DailyNecessitiesEntity>(sortDescriptors: [NSSortDescriptor(keyPath: \DailyNecessitiesEntity.date, ascending: false)], predicate: NSPredicate(format: "%K == %@", #keyPath(DailyNecessitiesEntity.transactions.date), transaction.date as CVarArg))
    }
    
    func getDailyNecessities() -> [DailyNecessitiesEntity] {
        let request: NSFetchRequest<DailyNecessitiesEntity> = DailyNecessitiesEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
            return []
        }
    }
    
    func addNewDailyNecessities(note: String, amount: Int64, date: Date, type: String, transactions: [TransactionEntity]) {
        let newDailyNecessities = DailyNecessitiesEntity(context: context)
        newDailyNecessities.note = note
        newDailyNecessities.amount = amount
        newDailyNecessities.date = date
        newDailyNecessities.type = type
        
        let transactionsFilterByDate = transactions.filter({
            toMMMdyyy(date: $0.date!) == toMMMdyyy(date: newDailyNecessities.date!)
        })
        
        
        if transactionsFilterByDate.isEmpty {
            let newTransaction = TransactionEntity(context: context)
            newTransaction.addToDailyNecessities(newDailyNecessities)
            newTransaction.date = newDailyNecessities.date
            if newDailyNecessities.type == "Income" {
                newTransaction.totalIncome += newDailyNecessities.amount
            } else if newDailyNecessities.type == "Expense" {
                newTransaction.totalExpense += newDailyNecessities.amount
            }
        }
        
        for transaction in transactionsFilterByDate {
            transaction.addToDailyNecessities(newDailyNecessities)
            if newDailyNecessities.type == "Income" {
                transaction.totalIncome += newDailyNecessities.amount
            } else if newDailyNecessities.type == "Expense" {
                transaction.totalExpense += newDailyNecessities.amount
            }
        }
        
        save()
    }
    
    func updateDailyNecessities(dailyNecessities: DailyNecessitiesEntity, newNote: String, newAmount: Int64, newDate: Date, newType: String) {
        dailyNecessities.note = newNote
        dailyNecessities.amount = newAmount
        dailyNecessities.date = newDate
        dailyNecessities.type = newType
        save()
    }
    
    func deleteDailyNecessities(dailyNecessities: DailyNecessitiesEntity) {
        context.delete(dailyNecessities)
        save()
    }
}
