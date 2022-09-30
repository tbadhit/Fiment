//
//  ItemDailyNecessitiesView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 09/04/22.
//

import SwiftUI

struct ItemDailyNecessitiesView: View {
    var note: String
    var amount: String
    var type: String
    var body: some View {
        HStack {
            Text(note).font(.system(size: 16))
            Spacer()
            Text(toRupiah(number: Int64(amount)!)).font(.system(size: 16)).foregroundColor(type == "Income" ? .green : .red)
        }
    }
}

struct ItemDailyNecessitiesView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemDailyNecessitiesView(note: "", amount: "", type: "")
    }
}
