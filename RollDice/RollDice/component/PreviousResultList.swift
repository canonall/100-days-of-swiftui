//
//  PreviousResultList.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import SwiftUI

struct PreviousResultList: View {
    let diceRolls: [DiceRoll]
    
    var body: some View {
        Text("Previous results")
            .font(.title2)
            .bold()
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ScrollView {
            GeometryReader { proxy in
                VStack {
                    HStack(spacing: 0) {
                        Text("Result")
                            .frame(width: proxy.size.width * 0.5)
                            .foregroundColor(.black)
                        Text("Total")
                            .frame(width: proxy.size.width * 0.5)
                            .foregroundColor(.black)
                    }
                    
                    ForEach(diceRolls.prefix(10), id: \.id) { diceRoll in
                        HStack {
                            HStack {
                                ForEach(diceRoll.results, id: \.self) { result in
                                    Text("\(result)")
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                            .frame(width: proxy.size.width * 0.5, alignment: .center)
                            
                            
                            HStack {
                                Text("\(diceRoll.resultSum)")
                                    .foregroundColor(.black)
                                    .bold()
                            }
                            .frame(width: proxy.size.width * 0.5, alignment: .center)
                            
                        }
                        .padding(.vertical, 1)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}


struct PreviousResultList_Previews: PreviewProvider {
    static var previews: some View {
        PreviousResultList(diceRolls: [])
    }
}

////
////  PreviousResultList.swift
////  RollDice
////
////  Created by Can Önal on 12.11.22.
////
//
//import SwiftUI
//
//struct PreviousResultList: View {
//    let diceRolls: [DiceRoll]
//
//    var body: some View {
//        Text("Previous results")
//            .font(.title2)
//            .bold()
//            .foregroundColor(.black)
//            .padding()
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//        ScrollView {
//            GeometryReader { proxy in
//                VStack {
//                    ForEach(diceRolls.prefix(10), id: \.id) { diceRoll in
//                        HStack {
//                            HStack {
//                                Text("Result: ")
//                                    .foregroundColor(.black)
//                                ForEach(diceRoll.results, id: \.self) { result in
//                                    Text("\(result)")
//                                        .foregroundColor(.black)
//                                        .bold()
//                                }
//                            }
//                            .frame(width: proxy.size.width * 0.4, alignment: .leading)
//
//
//                            HStack {
//                                Text("Total: ")
//                                    .foregroundColor(.black)
//                                Text("\(diceRoll.resultSum)")
//                                    .foregroundColor(.black)
//                                    .bold()
//                            }
//                            .frame(width: proxy.size.width * 0.25, alignment: .leading)
//
//                        }
//                        .padding(.vertical, 1)
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//            }
//        }
//    }
//}
//
//struct PreviousResultList_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviousResultList(diceRolls: [])
//    }
//}
