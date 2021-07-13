//
//  ContentView.swift
//  LengthConvert
//
//  Created by user197801 on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    let units = ["meter","kilometer","mile","feet","yards"]
    let unitsDict = [0: "meter",1: "kilometer",2: "mile",3: "feet",4: "yards"]
    @State private var originalUnit = 0
    @State private var convertUnit = 0
    @State private var originalData = ""
    var convertedData: Double {
        let original = Double(originalData) ?? 0
        
        let converted = lengthConverter(unitsDict[originalUnit]!, unitsDict[convertUnit]!, original)
        
        return converted
    }
    
    func lengthConverter(_ unitFrom: String, _ unitTo: String, _ dataFrom: Double) -> Double {
        
        if unitFrom == "meter" {
            if unitTo == "kilometer" {
                return (dataFrom/1000)
            }
            if unitTo == "mile" {
                return (dataFrom/1609.34)
            }
            if unitTo == "feet" {
                return (dataFrom*3.28084)
            }
            if unitTo == "yards" {
                return (dataFrom*1.0936)
            }
        }
        
        if unitFrom == "kilometer" {
            if unitTo == "meter" {
                return (dataFrom*1000)
            }
            if unitTo == "mile" {
                return (dataFrom/1609.34*1000)
            }
            if unitTo == "feet" {
                return (dataFrom*3.28084*1000)
            }
            if unitTo == "yards" {
                return (dataFrom*1.0936*1000)
            }
        }
        
        if unitFrom == "mile" {
            if unitTo == "kilometer" {
                return (dataFrom*1.60934)
            }
            if unitTo == "meter" {
                return (dataFrom*1609.34)
            }
            if unitTo == "feet" {
                return (dataFrom*5280)
            }
            if unitTo == "yards" {
                return (dataFrom*1760)
            }
        }
        if unitFrom == "feet" {
            if unitTo == "kilometer" {
                return (dataFrom/3281)
            }
            if unitTo == "mile" {
                return (dataFrom/5280)
            }
            if unitTo == "meter" {
                return (dataFrom/3.281)
            }
            if unitTo == "yards" {
                return (dataFrom/3)
            }
        }
        
        if unitFrom == "yards" {
            if unitTo == "kilometer" {
                return (dataFrom/1094)
            }
            if unitTo == "mile" {
                return (dataFrom/1760)
            }
            if unitTo == "feet" {
                return (dataFrom*3)
            }
            if unitTo == "meter" {
                return (dataFrom/1.0936)
            }
        }
        
        return dataFrom
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Original Unit")){
                    Picker("", selection: $originalUnit) {
                        ForEach(0..<units.count) {
                            Text(unitsDict[$0]!)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Enter input")) {
                    TextField("0", text: $originalData)
                }
                Section(header: Text("Select Output Unit")){
                    Picker("", selection: $convertUnit) {
                        ForEach(0..<units.count) {
                            Text(unitsDict[$0]!)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output")) {
                    Text("\(convertedData, specifier: "%.2f")")
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
