//
//  ContentView.swift
//  WeSplit
//
//  Created by user197801 on 6/13/21.
//

import SwiftUI

struct ContentView: View {
   
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 20
    
    let tipPercentages = [0, 10, 15, 20, 25, 30]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipAmount = orderAmount / 100 * tipSelection
        let totalAmount = orderAmount + tipAmount
        return totalAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeople) ?? 0 + 2)
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("0", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How many people?")) {
                    TextField("2", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")
                            .multilineTextAlignment(.leading)
                            ){
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                           Text("\($0)%")
                        }
//                        ForEach(0..<tipPercentages.count) {
//                            Text("\(tipPercentages[$0])%")
//                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount for the check:")) {
                    let total = Text("$\(grandTotal, specifier: "%.2f")")
                    switch tipPercentage {
                    case 0:
                        total
                        .foregroundColor(.red)
                        .listRowBackground(Color(red: 1, green: 242/255, blue: 241/255))
                    case 10:
                        total
                        .foregroundColor(.green)
                        .listRowBackground(Color(red: 214/255, green: 1, blue: 121/255))
                    case 15:
                        total
                        .foregroundColor(.blue)
                        .listRowBackground(Color(red: 189/255, green: 213/255, blue: 234/255))
                    case 20:
                        total
                        .foregroundColor(.purple)
                        .listRowBackground(Color(red: 248/255, green: 247/255, blue: 254/255))
                    case 25:
                        total
                        .foregroundColor(.yellow)
                        .listRowBackground(Color(red: 96/255 , green: 105/255, blue: 92/255))
                    default:
                        total
                        .foregroundColor(.orange)
                        .listRowBackground(Color(red: 214/255 , green: 249/255, blue: 221/255))
                    }
                }
                
                
                Section(header: Text("Amount per person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("We Split")  //it in the end of Form ? Why?
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
