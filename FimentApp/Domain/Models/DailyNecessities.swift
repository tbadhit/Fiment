//
//  DailyNecessities.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/09/22.
//

import Foundation
import CoreData

struct DailyNecessities {
    
    let dailyNecessities: DailyNecessitiesEntity
    
    var id: NSManagedObjectID {
        return dailyNecessities.objectID
    }
    
    var amount: Int64 {
        return dailyNecessities.amount
    }
    
    var date: Date {
        return dailyNecessities.date ?? Date.now
    }
    
    var note: String {
        return dailyNecessities.note ?? ""
    }
    
    var type: String {
        return dailyNecessities.type ?? ""
    }
    
    var transactions: TransactionEntity {
        return dailyNecessities.transactions ?? TransactionEntity()
    }
}
