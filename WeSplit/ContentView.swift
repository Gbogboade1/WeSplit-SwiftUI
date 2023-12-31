//
//  ContentView.swift
//  WeSplit
//
//  Created by Ayomide Gbogboade on 29/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused:Bool
    
    let tipPercentages = [10,15,20,25,0]
    var totalPerPerson: Double{
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection;
        let grandTotal = checkAmount + tipValue;
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
     NavigationStack {
          Form {
         Section  {
             TextField("Check Amount", 
                       value: $checkAmount,
                       format: .currency(code: Locale.current.currency?.identifier ?? "USD")
             ).keyboardType(.decimalPad)
                 .focused($isAmountFocused)
             
             Picker("Number of people", selection: $numberOfPeople){
                 ForEach(2..<100){
                     Text("\($0) People")
                 }
             }.pickerStyle(.navigationLink)
             
             
         }
              
              Section("How much do you want to tip?"){
                
                  Picker("Tip Percentage", selection: $tipPercentage) {
                      ForEach(tipPercentages, id: \.self){
                          Text($0, format: .percent)
                      }
                  }.pickerStyle(.segmented)
              }
              Section(""){
                  Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
              }
              
              
          }.navigationTitle("WeSplit")
             .toolbar{
                 if(isAmountFocused){
                     Button("Done"){
                         isAmountFocused = false
                     }
                 }
             }
      
     
     }
    }
    
    
}

#Preview {
    ContentView()
}
