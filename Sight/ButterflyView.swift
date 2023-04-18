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
    @State private var draggedQuadrant: Int?
    @State private var currentQuadrant: Int?
    @State private var highlightedQuadrant: Int?
    @State private var timer: Timer?
    @State private var greenHighlightDuration: TimeInterval = 0
    let highlightGenerator = HighlightGenerator(quadrants: quadrants)
    
    let pastelColors: [Color] = [
        Color(red: 255/255, green: 179/255, blue: 186/255),
        Color(red: 248/255, green: 200/255, blue: 220/255),
        Color(red: 255/255, green: 110/255, blue: 78/255),
        Color(red: 255/255, green: 157/255, blue: 135/255),
        Color(red: 255/255, green: 191/255, blue: 176/255)
    ]
    
    func quadrant(from point: CGPoint) -> Int? {
        let midX = UIScreen.main.bounds.width / 2
        let midY = UIScreen.main.bounds.height / 2
        
        if point.x < midX && point.y < midY {
            return 1
        } else if point.x >= midX && point.y < midY {
            return 2
        } else if point.x < midX && point.y >= midY {
            return 3
        } else if point.x >= midX && point.y >= midY {
            return 4
        }
        
        return nil
    }
    
    var quadrantOverlay: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height))
                path.move(to: CGPoint(x: 0, y: UIScreen.main.bounds.height / 2))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height / 2))
            }
            
            if let quadrant = currentQuadrant {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: quadrant == 1 || quadrant == 3 ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width * 3 / 4, y: quadrant < 3 ? UIScreen.main.bounds.height / 4 : UIScreen.main.bounds.height * 3 / 4))
            }
            if let draggedQuadrant = draggedQuadrant {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.yellow.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: draggedQuadrant == 1 || draggedQuadrant == 3 ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width * 3 / 4, y: draggedQuadrant < 3 ? UIScreen.main.bounds.height / 4 : UIScreen.main.bounds.height * 3 / 4))
            }
            
            if let highlightedQuadrant = highlightedQuadrant, highlightedQuadrant != draggedQuadrant {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: highlightedQuadrant == 1 || highlightedQuadrant == 3 ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width * 3 / 4, y: highlightedQuadrant < 3 ? UIScreen.main.bounds.height / 4 : UIScreen.main.bounds.height * 3 / 4))
            } else if let highlightedQuadrant = highlightedQuadrant, highlightedQuadrant == draggedQuadrant {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.green.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                    .position(CGPoint(x: highlightedQuadrant == 1 || highlightedQuadrant == 3 ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width * 3 / 4, y: highlightedQuadrant < 3 ? UIScreen.main.bounds.height / 4 : UIScreen.main.bounds.height * 3 / 4))
            }
            
        }
    }
    
    
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
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if highlightedQuadrant == draggedQuadrant {
                greenHighlightDuration += 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View {
        
        ZStack {
            let formattedGreenHighlightDuration = String(format: "%.0f", greenHighlightDuration)
            Text("\(formattedGreenHighlightDuration) / 125")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
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
        .overlay(quadrantOverlay)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    touchLocation = value.location
                    draggedQuadrant = quadrant(from: touchLocation!) // Update the current quadrant
                    
                    withAnimation(Animation.easeOut(duration: 5.0)) {
                        for index in butterflies.indices {
                            butterflies[index] = randomPosition(around: touchLocation!, radius: 200)
                        }
                    }
                }
                .onEnded { _ in
                    touchLocation = nil
                    draggedQuadrant = nil // Clear the current quadrant
                    
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
            
            highlightGenerator.start { newQuadrant in
                highlightedQuadrant = newQuadrant
            }
            startTimer()
        }
        .onDisappear{
            stopTimer()
        }
    }
}
