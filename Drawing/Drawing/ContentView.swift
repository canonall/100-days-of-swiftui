//
//  ContentView.swift
//  Drawing
//
//  Created by Can Önal on 24.08.22.
//

import SwiftUI

//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}
//
//struct Arch: Shape {
//    let startAngle: Angle
//    let endAngle: Angle
//    let clockwise: Bool
//
//    func path(in rect: CGRect) -> Path {
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        var path = Path()
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
//
//        return path
//    }
//}
//------------------------------------------------------------------
//struct Flower: Shape {
//    var petalOffset = -20.0
//    var pedalWidth = 100.0
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
//
//            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: pedalWidth, height: rect.width / 2))
//            let rotatedPetal = originalPetal.applying(position)
//
//            path.addPath(rotatedPetal)
//        }
//
//        return path
//    }
//}
//------------------------------------------------------------------

//struct Trepezoid: Shape {
//    var insetAmount: Double
//
//    var animatableData: Double {
//        get { insetAmount }
//        set { insetAmount = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: 0, y: rect.maxY))
//        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
//
//        return path
//    }
//}
//------------------------------------------------------------------

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double>{
    get {
        AnimatablePair(Double(rows), Double(columns))
    }
    set {
        rows = Int(newValue.first)
        columns = Int(newValue.second)
    }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if(row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct ContentView: View {
    //    @State private var petalOffset = -20.0
    //    @State private var petalWidth = 100.0
    
    //@State private var amount = 0.0
    
    //@State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        //        Path { path in
        //            path.move(to: CGPoint(x: 200, y: 100))
        //            path.addLine(to: CGPoint(x: 100, y: 300))
        //            path.addLine(to: CGPoint(x: 300, y: 300))
        //            path.addLine(to: CGPoint(x: 200, y: 100))
        //        }
        //        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        
        //        Triangle()
        //            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        //            .frame(width: 300, height: 300)
        
        //        Arch(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
        //            .stroke(.blue, lineWidth: 10)
        //            .frame(width: 300, height: 300)
        //------------------------------------------------------------------
        
        //        VStack {
        //            Flower(petalOffset: petalOffset, pedalWidth: petalWidth)
        //                .fill(.red, style: FillStyle(eoFill: true))
        //
        //            Text("Offset")
        //            Slider(value: $petalOffset, in: -40...40)
        //                .padding([.horizontal, .bottom])
        //
        //            Text("Width")
        //            Slider(value: $petalWidth, in: 0...100)
        //                .padding(.horizontal)
        //        }
        //------------------------------------------------------------------
        
        //        VStack {
        //            Image("PaulHudson")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 200, height: 200)
        //                .saturation(amount)
        //                .blur(radius: (1 - amount) * 20 )
        //
        //            Slider(value: $amount)
        //                .padding()
        //        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(.black)
        //        .ignoresSafeArea()
        //------------------------------------------------------------------
        
        //        Trepezoid(insetAmount: insetAmount)
        //            .frame(width: 200, height: 100)
        //            .onTapGesture {
        //                withAnimation{
        //                    insetAmount = Double.random(in: 10...90)
        //                }
        //            }
        
        
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
