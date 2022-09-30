//
//  MainView.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 07/04/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var dailyViewModel = DailyViewModel.shared
    
    var body: some View {
        NavigationView {
            TabView {
                DailyView().tabItem {
                    Label("Daily", systemImage: "calendar")
                }
                MonthlyView().tabItem {
                    Label("Monthly", systemImage: "calendar.circle")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Fiment")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dailyViewModel.isNewData.toggle()
                        dailyViewModel.setShowDatePicker(data: true)
                    }, label: {
                        Text("Add")
                    })
                }
                
            }
            
            // MARK: Add sheet
            .sheet(isPresented: $dailyViewModel.isNewData) {
                AddDailyNecessitiesView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
