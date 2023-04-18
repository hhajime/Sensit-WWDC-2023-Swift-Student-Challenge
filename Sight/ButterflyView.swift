//
//  ButterflyView.swift
//  
//
//  Created by Ha Jong Myeong on 2023/04/3.
//

import SwiftUI

struct Butterfly: View {
    var progress: Double
    var color: Color
    
    var body: some View {
        Group {
            if progress < 0.333 {
                Image("flap1")
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(color)
            } else if progress < 0.666 {
                Image("flap2")
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(color)
            } else {
                Image("flap3")
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(color)
            }
        }
    }
}

struct Butterflies: View {
    @State private var butterflyCount = 30
    @State private var butterflies: [CGPoint] = []
    @State private var butterflyColors: [Color] = []
    @State private var touchLocation: CGPoint?
    @State private var progress: Double = 0
    
    let pastelColors: [Color] = [
        Color(red: 255/255, green: 179/255, blue: 186/255),
        Color(red: 248/255, green: 200/255, blue: 220/255),
        Color(red: 255/255, green: 110/255, blue: 78/255),
        Color(red: 255/255, green: 157/255, blue: 135/255),
        Color(red: 255/255, green: 191/255, blue: 176/255)
    ]
    
    func randomPosition(around point: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = CGFloat.random(in: 0...2 * .pi)
        let distance = CGFloat.random(in: 0...radius)
        let x = point.x + distance * cos(angle)
        let y = point.y + distance * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
    func moveButterfly(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...2)) {
            withAnimation(Animation.easeOut(duration: 5)) {
                butterflies[index] = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            }
            moveButterfly(index: index)
        }
    }
    
    var body: some View {
        
        ZStack {
            ForEach(butterflies.indices, id: \.self) { index in
                Butterfly(progress: progress, color: butterflyColors[index])
                    .frame(width: 50, height: 50)
                    .position(butterflies[index])
                    .onAppear {
                        moveButterfly(index: index)
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    touchLocation = value.location
                    withAnimation(Animation.easeOut(duration: 5.0)) {
                        for index in butterflies.indices {
                            butterflies[index] = randomPosition(around: touchLocation!, radius: 200)
                        }
                    }
                }
                .onEnded { _ in
                    touchLocation = nil
                    
                    for index in butterflies.indices {
                        moveButterfly(index: index)
                    }
                }
        )
        .onAppear {
                    for _ in 0..<butterflyCount {
                        butterflies.append(CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height)))
                        butterflyColors.append(pastelColors.randomElement()!)
                    }
                    withAnimation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: false)) {
                        progress = 2.0
                    }
                }
    }
}
