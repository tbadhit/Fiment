//
//  Transaction.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/09/22.
//

import CoreData

struct Transaction {
    let transactionEntity: TransactionEntity
    
    var id: NSManagedObjectID {
        return transactionEntity.objectID
    }
    
    var date: Date {
        return transactionEntity.date ?? Date.now
    }
    
    var totalExpense: Int64 {
        return transactionEntity.totalExpense
    }
    
    var totalIncome: Int64 {
        return transactionEntity.totalIncome
    }
    
    var dailyNecessities: NSSet {
        return transactionEntity.dailyNecessities ?? NSSet()
    }
}

