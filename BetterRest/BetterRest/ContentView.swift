//
//  ContentView.swift
//  BetterRest
//
//  Created by user197801 on 6/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var idealBedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0)*60*60
        let minute = (components.minute ?? 0)*60
        var time: String = ""
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            time = formatter.string(from: sleepTime)
        } catch {
            
        }
        
        return time
    }
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep:")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%.4g") hours")
                    }
                }
                Section(header: Text("Daily coffee intake:")
                            ) {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(2..<22) {
                            Text("\($0-1) cups")
                        }
                    }
                }
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Daily coffee intake")
//                        .font(.headline)
//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        Text("\(coffeeAmount) cups")
//                    }
//                }
                
                VStack(alignment: .center, spacing: 0) {
                    Text("Your ideal bed time is: \(idealBedTime)")
                        .font(.title2)
                }
                
            
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK!")))
            }
            .navigationBarTitle("Better Rest")
//            .navigationBarItems(trailing: Button(action: calculateBedtime) {
//                Text("Calculate")
//            })
        }
        
    }
    
//    func calculateBedtime() {
//        let model = SleepCalculator()
//        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//        let hour = (components.hour ?? 0)*60*60
//        let minute = (components.minute ?? 0)*60
//        do {
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            let formatter = DateFormatter()
//            formatter.timeStyle = .short
//
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bed time is:"
//        } catch {
//
//        }
//
//        showingAlert = true
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
