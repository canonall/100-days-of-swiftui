//
//  ContentView.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import SwiftUI

struct DiceScreen: View {
    
    init() {
        /// for picker colors
        UISegmentedControl.appearance().selectedSegmentTintColor = .brown
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    @StateObject var viewModel = ViewModel()
    @State private var diceSelection = 1
    @State private var sideSelection = 6
    
    var numberOfDice = [1, 2, 3]
    var numberOfSide = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.brown
                
                VStack(alignment: .leading,spacing: 0) {
                    Text("Select the number of dice")
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding([.horizontal, .top])
                    
                    Picker("Select the number of dice", selection: $diceSelection) {
                        ForEach(numberOfDice, id: \.self) {
                            Text("\($0)")
                                .foregroundColor(.black)
                        }
                    }
                    .onChange(of: diceSelection, perform: { _ in
                        viewModel.resetDice(diceCount: diceSelection)
                    })
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Text("Select the number of sides")
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding([.horizontal,.top])
                    
                    Picker("Select the number of sides", selection: $sideSelection) {
                        ForEach(numberOfSide, id: \.self) {
                            Text("\($0)")
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    HStack(alignment: .center) {
                        ForEach(0...diceSelection - 1, id: \.self) { dice in
                            DiceView(diceResult: viewModel.currentResults[dice])
                        }
                        .padding(.horizontal, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .animation(.easeIn, value: diceSelection)
                    
                    PreviousResultList(diceRolls: viewModel.diceRolls)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .padding(.bottom)
                
                ZStack {
                    Text("Roll!")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.top)
                }
                .shadow(radius: 10)
                .frame(width: proxy.size.width, height: 80, alignment: .top)
                .background(Color(UIColor.brown))
                .onTapGesture {
                    withAnimation {
                        viewModel.complexSuccess()
                        viewModel.rollDice(diceCount: diceSelection, sideCount: sideSelection)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            viewModel.prepareHaptics()
            viewModel.loadResults()
        }
    }
}

struct DiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiceScreen()
    }
}
