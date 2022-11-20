//
//  DiceViewModel.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import CoreHaptics
import Foundation

extension DiceScreen {
    @MainActor class ViewModel: ObservableObject {
        @Published var diceRolls = [DiceRoll]()
        @Published var currentResults: [Int?] = [nil, nil, nil]
        @Published var engine: CHHapticEngine?
        
        func loadResults() {
            do {
                let data = try Data(contentsOf: FileManager.documentsDirectory)
                diceRolls = try JSONDecoder().decode([DiceRoll].self, from: data)
            } catch {
                print("decode error")
                diceRolls = []
            }
        }
        
        private func saveResult() {
            var latestsRolls = [DiceRoll]()
            if diceRolls.count >= 10 {
                latestsRolls = Array(diceRolls[0..<10])
            } else {
                latestsRolls = diceRolls
            }
            
            do {
                let data = try JSONEncoder().encode(latestsRolls)
                try data.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
            } catch {
                print("encode error")
            }
        }
        
        func rollDice(diceCount: Int, sideCount: Int) {
            for roll in 0...(diceCount - 1) {
                currentResults[roll] = Int.random(in: 1...sideCount)
            }
            diceRolls.insert(DiceRoll(results: getUnwrappedResults(), resultSum: getUnwrappedResults().reduce(0, +)), at: 0)
            saveResult()
        }
        
        func resetDice(diceCount: Int) {
            currentResults = [nil, nil, nil]
        }
        
        private func getUnwrappedResults() -> [Int] {
            var unwrappedDiceRolls = [Int]()
            for diceRoll in currentResults {
                if let unwrappedDiceRoll = diceRoll {
                    unwrappedDiceRolls.append(unwrappedDiceRoll)
                }
            }
            return unwrappedDiceRolls
        }
        
        func prepareHaptics() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error creating the engine: \(error.localizedDescription)")
            }
        }
        
        func complexSuccess() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            var events = [CHHapticEvent]()
            
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 0.2)
            events.append(event)
            
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        }
        
    }
}
