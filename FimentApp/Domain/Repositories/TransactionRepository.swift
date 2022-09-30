//
//  TransactionRepository.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/09/22.
//

import CoreData

class TransactionRepository {
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

extension TransactionRepository {
    
    func getTransactions() -> [TransactionEntity] {
        let request: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func getTransactionById(_ id: NSManagedObjectID) -> TransactionEntity? {
        do {
            return try context.existingObject(with: id) as? TransactionEntity
        } catch {
            print(error)
            return nil
        }
    }
    
    func updateIncomeTransaction(transaction: TransactionEntity, newTotalIncome: Int64) {
        transaction.totalIncome = newTotalIncome
        save()
    }
    
    func updateExpenseTransaction(transaction: TransactionEntity, newTotalExpense: Int64) {
        transaction.totalExpense = newTotalExpense
        save()
    }
    
    func deleteTransaction(transaction: TransactionEntity) {
        context.delete(transaction)
        save()
    }
}


