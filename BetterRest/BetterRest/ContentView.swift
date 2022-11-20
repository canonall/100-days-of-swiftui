//
//  ContentView.swift
//  BetterRest
//
//  Created by Can Önal on 31.07.22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpDate = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var sleepTime = defaultWakeUpTime
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUpDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep?")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount){
                        ForEach(1...20, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
//                    Stepper(
//                        coffeeAmount==1 ? "1 cup" : "\(coffeeAmount) cups",
//                        value: $coffeeAmount,
//                        in: 1...20,
//                        step: 1)
                }
                
                Section {
                    Text("Recommended bedtime")
                        .font(.headline)
                    
                    Text("\(calculateBedTime().formatted(date: .omitted, time: .shortened))")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> Date{
        do {
            let wakeUpData = getHourAndMinute()
            
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let predictionResult = try model.prediction(
                wake: Double(wakeUpData.hour + wakeUpData.minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount))
            
            //predictionResult is in seconds, so we need date
            let sleepTime = wakeUpDate - predictionResult.actualSleep
            return sleepTime
        } catch {
            return wakeUpDate
        }
    }
    
    func getHourAndMinute() -> (hour: Int, minute: Int){
        let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUpDate)
        let hour = (component.hour ?? 0) * 60 * 60
        let minute = (component.minute ?? 0) * 60
        return (hour, minute)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
