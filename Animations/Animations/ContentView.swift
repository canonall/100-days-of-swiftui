//
//  ContentView.swift
//  Animations
//
//  Created by Can Önal on 10.08.22.
//

import SwiftUI

struct ContentView: View {
    //@State private var animationAmount = 1.0 use for first and second example
    //@State private var animationAmount3 = 0.0 //third example
    //@State private var enabled = false //fourth
    //@State private var dragAmount = CGSize.zero //fifth
    
    //sixth
    let letters = Array("Shane Larkin")
    let letters2 = Array("Anadolu Efes")
    @State private var enabled2 = false
    @State private var enabledSubstring = false
    @State private var dragAmount2 = CGSize.zero
    
    //@State private var isShowingRed = false //seventh
    //@State private var isShowingRed2 = false //eighth
    
    var body: some View {
        //----------------------------------------------------------
        //  1
        //        Button("Tap me"){
        //            //animationAmount += 1
        //        }
        //        .padding(50)
        //        .background(.red)
        //        .foregroundColor(.white)
        //        .clipShape(Circle())
        //        .overlay(
        //            Circle()
        //            .stroke(.red)
        //            .scaleEffect(animationAmount)
        //            .opacity(2 - animationAmount)
        //            .animation(
        //                .easeInOut(duration: 1)
        //                .repeatForever(autoreverses: false),
        //                value: animationAmount)
        //        )
        //        .onAppear{
        //            animationAmount = 2
        //        }
        //----------------------------------------------------------
        //  2
        //        print(animationAmount)
        //        return VStack {
        //            Stepper("Scale amount", value: $animationAmount.animation(
        //                .easeInOut(duration: 1)
        //                .repeatCount(3, autoreverses: true)
        //            ), in: 1...10)
        //
        //            Spacer()
        //
        //            Button("Tap me") {
        //                animationAmount += 1
        //            }
        //            .padding(50)
        //            .background(.red)
        //            .foregroundColor(.white)
        //            .clipShape(Circle())
        //            .scaleEffect(animationAmount)
        //        }
        //----------------------------------------------------------
        //  3
        //explicit animation
        //        Button("Tap me") {
        //            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
        //                animationAmount3 += 360
        //            }
        //        }
        //        .padding(50)
        //        .background(.red)
        //        .foregroundColor(.white)
        //        .clipShape(Circle())
        //        .rotation3DEffect(.degrees(animationAmount3), axis: (x: 0, y: 1, z: 0))
        //----------------------------------------------------------
        //  4
        //        Button("Tap me") {
        //            enabled.toggle()
        //        }
        //        .frame(width: 200, height: 200)
        //        .background(enabled ? .blue : .red)
        //        .animation(nil, value: enabled)
        //        .foregroundColor(.white)
        //        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        //        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        //    }
        //----------------------------------------------------------
        //  5
        //        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        //            .frame(width: 300, height: 200)
        //            .clipShape(RoundedRectangle(cornerRadius: 10))
        //            .offset(dragAmount)
        //            .gesture(
        //                DragGesture()
        //                    .onChanged{ value in
        //                        dragAmount = value.translation
        //                    }
        //                    .onEnded { _ in
        //                        //explicit animation
        //                        withAnimation {
        //                            dragAmount = .zero
        //
        //                        }
        //                    }
        //            )
        //----------------------------------------------------------
          //6
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) { number in
                        Text(String(letters[number]))
                            .padding(5)
                            .font(.title)
                            .background(enabled2 ? .blue : .red)
                            .offset(dragAmount2)
                            .animation(
                                .default.delay(Double(number) / 20),
                                value: dragAmount2)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            enabledSubstring = false
                            dragAmount2 = value.translation
                        }
                        .onEnded { _ in
                            dragAmount2 = .zero
                            enabled2.toggle()
                            enabledSubstring.toggle()
                        }
                )
        
        HStack(spacing: 0){
            ForEach(0..<letters2.count) { number in
                Text(String(letters2[number]))
                    .padding(5)
                    .font(.body)
                    .background(enabledSubstring ? .green: .indigo)
                    .opacity(enabledSubstring ? 1 : 0)
                    .animation(.default.delay(Double(number) / 20), value: dragAmount2)
            }
        }
        
        //----------------------------------------------------------
        //  7
        //        VStack {
        //            Button("Tap me") {
        //                withAnimation {
        //                    isShowingRed.toggle()
        //                }
        //            }
        //            if(isShowingRed) {
        //                Rectangle()
        //                    .fill(.red)
        //                    .frame(width: 200, height: 200)
        //                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
        //            }
        //        }
        //----------------------------------------------------------
        //  8
        //        ZStack {
        //            Rectangle()
        //                .fill(.blue)
        //                .frame(width: 200, height: 200)
        //
        //            if isShowingRed2 {
        //                Rectangle()
        //                    .fill(.red)
        //                    .frame(width: 200, height: 200)
        //                    .transition(.pivot)
        //            }
        //        }
        //        .onTapGesture {
        //            withAnimation {
        //                isShowingRed2.toggle()
        //            }
        //        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
