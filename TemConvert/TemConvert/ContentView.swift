//
//  ContentView.swift
//  TemConvert
//
//  Created by user197801 on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    let units = ["Celcius","Fahrenheit","Kevin"]
    let unitsDict = [0: "Celcius",1: "Fahrenheit",2: "Kevin"]
    @State private var originalUnitKey = 0
    @State private var originalData = ""
    @State private var convertUnitKey = 0
    var convertedData : Double {
        let original = Double(originalData) ?? 0
        print("from\(unitsDict[originalUnitKey]!)")
        print("to\(unitsDict[convertUnitKey]!)")
        let converted = convertTemp(unitsDict[originalUnitKey]!, original, unitsDict[convertUnitKey]!)
        
        return converted
    }
    
    func convertTemp(_ unitFrom: String,_ dataFrom: Double, _ unitTo: String) -> Double {
        
        if unitFrom == "Celcius" {
            if unitTo == "Fahrenheit" {
                return ((dataFrom*9/5) + 32)
            }
            
            if unitTo == "Kevin" {
                return (dataFrom + 273.15)
            }
        }
        
        if unitFrom == "Fahrenheit" {
            if unitTo == "Celcius" {
                return ((dataFrom-32)*5/9)
            }
            
            if unitTo == "Kevin" {
                return ((dataFrom-32)*5/9+273.15)
            }
        }
        
        if unitFrom == "Kevin" {
            if unitTo == "Celcius" {
                return (dataFrom-273.15)
            }
            if unitTo == "Fahrenheit" {
                return ((dataFrom - 273.15)*9/5 + 32)
            }
        }
        
        return dataFrom
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Original Unit")
                            .multilineTextAlignment(.leading)
                    ){
                    Picker("Unit select", selection: $originalUnitKey) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Original Value")) {
                    TextField("0", text: $originalData)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Select Unit Convert To")
                            .multilineTextAlignment(.leading)
                    ){
                    Picker("Unit select", selection: $convertUnitKey) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted Value")) {
                    Text("\(convertedData, specifier: "%.f")")
                }
                
            }
            .navigationBarTitle("Temperature Convert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
