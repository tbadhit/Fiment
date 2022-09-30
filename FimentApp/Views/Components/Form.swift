//
//  Form.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 08/04/22.
//

import SwiftUI

struct Form: View {
    
    @Binding var isShowDatePicker: Bool
    
    @Binding var note: String
    @Binding var amount: String
    @Binding var selectedDate: Date
    @Binding var type: String
    
    var types: [String] = ["Income", "Expense"]
    
    var body: some View {
        VStack {
            //MARK: create name field
            TextField(
                "Enter Note",
                text:$note
            )
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(5)
            .disableAutocorrection(true)
            .padding(.bottom, 16)
            
            //MARK: email field
            TextField(
                "Enter Amount",
                text: $amount
            )
            .keyboardType(.numberPad)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(5)
            .keyboardType(.numberPad)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.bottom, 16)
            
            //MARK: Date Picker
            isShowDatePicker ? DatePicker(
                "Date :",
                selection: $selectedDate,
                displayedComponents: .date
            ).padding(.bottom,16) : nil
            
            //MARK: SEGMENTED CONTROL
            Picker("Text",selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
            
        }
    }
}

struct Form_Previews: PreviewProvider {
    @State static var note: String = ""
    @State static var amount: String = ""
    @State static var selectedDate: Date = Date()
    @State static var type: String = ""
    @State static var a: Bool = false
    static var previews: some View {
        Form(isShowDatePicker: $a ,note: $note, amount: $amount, selectedDate: $selectedDate, type: $type)
    }
}
