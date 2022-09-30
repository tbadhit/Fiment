//
//  TransactionViewModel.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/09/22.
//

import CoreData

class TransactionViewModel: ObservableObject {
    
    static let shared = TransactionViewModel()
    
    private var transactionRepository: TransactionRepository = TransactionRepository()
    
    @Published var transactions: [Transaction] = []
    @Published var listMonthlyTransaction: [MonthlyTransaction] = []
    @Published var isDetailListTransaction: Bool = false
    
    func getAllTransaction() {
        transactions = transactionRepository.getTransactions().map(Transaction.init)
    }
    
    func getTransactionByMonth() -> MonthlyTransaction {
        let dateFormatter = DateFormatter()
        let today = Date()
        let currentCalendar = Calendar.current
        let yearComponents: DateComponents = currentCalendar.dateComponents([.year], from: today)
        let currentYear = Int(yearComponents.year ?? 0)

        var monthlyTransaction = MonthlyTransaction(date: Date(), income: 0, expense: 0)
        for months in 0..<12 {
            for transaction in transactions {
                let monthYear = "\(dateFormatter.monthSymbols[months]) \(currentYear)"
                
                if toMMMyyy(date: transaction.date) == monthYear {
                    monthlyTransaction.date = transaction.date
                    monthlyTransaction.income += transaction.totalIncome
                    monthlyTransaction.expense += transaction.totalExpense
                }
            }
        }
        
        listMonthlyTransaction.append(monthlyTransaction)
        
        return monthlyTransaction
    }
    
    func updateTotalIncome(transaction: Transaction, newTotalIncome: Int64) {
        
        let existingTransaction = transactionRepository.getTransactionById(transaction.id)
        
        if let existingTransaction = existingTransaction {
            transactionRepository.updateIncomeTransaction(transaction: existingTransaction, newTotalIncome: newTotalIncome)
        }
    }
    
    func updateTotalExpense(transaction: Transaction, newTotalExpense: Int64) {
        
        let existingTransaction = transactionRepository.getTransactionById(transaction.id)
        
        if let existingTransaction = existingTransaction {
            transactionRepository.updateExpenseTransaction(transaction: existingTransaction, newTotalExpense: newTotalExpense)
        }
    }
    
    func update(_ updatedDailyNecessities: DailyNecessitiesEntity, _ oldDailyNecessitiesAmount: Int64, _ oldDailyNecessitiesType: String?) {
        
        guard let transaction = updatedDailyNecessities.transactions.map(Transaction.init) else {return}
        
        if oldDailyNecessitiesType == "Income" {
            if updatedDailyNecessities.type == "Expense" {
                let newTotalIncome = transaction.totalIncome - updatedDailyNecessities.amount
                let newTotalExpense = transaction.totalExpense + updatedDailyNecessities.amount
                updateTotalIncome(transaction: transaction, newTotalIncome: newTotalIncome)
                updateTotalExpense(transaction: transaction, newTotalExpense: newTotalExpense)
            } else {
                let newTotalIncome = (transaction.totalIncome + updatedDailyNecessities.amount) - oldDailyNecessitiesAmount
                updateTotalIncome(transaction: transaction, newTotalIncome: newTotalIncome)
            }
        } else {
            if updatedDailyNecessities.type == "Income" {
                let newTotalExpense = transaction.totalExpense - updatedDailyNecessities.amount
                let newTotalIncome = transaction.totalIncome + updatedDailyNecessities.amount
                updateTotalExpense(transaction: transaction, newTotalExpense: newTotalExpense)
                updateTotalIncome(transaction: transaction, newTotalIncome: newTotalIncome)
            } else {
                let newTotalExpense = (transaction.totalExpense + updatedDailyNecessities.amount) - oldDailyNecessitiesAmount
                updateTotalExpense(transaction: transaction, newTotalExpense: newTotalExpense)
            }
        }
    }
    
    
    func delete(_ item: Transaction) {
        let existingTransaction = transactionRepository.getTransactionById(item.id)
        
        if let existingTransaction = existingTransaction {
            transactionRepository.deleteTransaction(transaction: existingTransaction)
        }
    }
}

extension TransactionViewModel {
    
    var balance: Int64 {
        var total: Int64 = 0
        for i in transactions {
            total += i.totalIncome - i.totalExpense
        }
        return total
    }
    
    var income: Int64 {
        var total: Int64 = 0
        for i in transactions.filter({toMMMyyy(date: $0.date) == toMMMyyy(date: Date())}) {
            total += i.totalIncome
        }
        return total
    }
    
    var expense: Int64 {
        var total: Int64 = 0
        for i in transactions.filter({toMMMyyy(date: $0.date) == toMMMyyy(date: Date())}) {
            total += i.totalExpense
        }
        return total
    }
    
}
