//
//  Utils.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/04/22.
//

import Foundation

func toRupiah(number: Int64) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.numberStyle = .decimal
    let rupiah = "Rp. \(formatter.string(from: number as NSNumber) ?? "")"
    return rupiah
}

func toMMMdyyy(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "MMM d, yyyy"
    return df.string(from: date)
}

func toMMMyyy(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "MMM, yyyy"
    return df.string(from: date)
}
