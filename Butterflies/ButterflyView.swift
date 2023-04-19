//
//  ButterflyView.swift
//  Sensia
//
//  Created by Ha Jong Myeong on 2023/04/3.
//

import SwiftUI

struct Butterfly: View {
    var progress: Double
    var position: CGPoint
    var screenSize: CGSize
    
    @Environment(\.imageCache) private var cache: ImageCache
    
    func gradientColor() -> Color {
        let xRatio = position.x / screenSize.width
        let yRatio = position.y / screenSize.height
        let hue = (xRatio + yRatio) / 2.0
        return Color(hue: hue - 0.5, saturation: 0.8, brightness: 1.0)
    }
    
    var body: some View {
        let imageName: String
        
        if progress < 0.333 {
            imageName = "flap1"
        } else if progress >= 0.333 && progress < 0.666 {
            imageName = "flap2"
        } else {
            imageName = "flap3"
        }
        
        return Group {
            if let image = cache[imageName] {
                image
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(gradientColor())
            }
        }
    }
    
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = ImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

class ImageCache {
    private var cache: [String: Image] = [:]
    
    subscript(_ key: String) -> Image? {
        get {
            cache[key]
        }
        set {
            cache[key] = newValue
        }
    }
    
    init() {
        for imageName in ["flap1", "flap2", "flap3"] {
            cache[imageName] = Image(imageName)
        }
    }
}

struct Butterflies: View {
    @State private var butterflyCount = 75
    @State private var butterflies: [(CGPoint, Double)] = []
    @State private var touchLocation: CGPoint?
    @State private var timer: Timer?
    
    func randomPosition(around point: CGPoint, radius: CGFloat) -> CGPoint {
        let angle = CGFloat.random(in: 0...2 * .pi)
        let distance = CGFloat.random(in: 0...radius)
        let x = point.x + distance * cos(angle)
        let y = point.y + distance * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
    func moveButterfly(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...2)) {
            withAnimation(Animation.easeOut(duration: 7.5)) {
                let newPosition = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                butterflies[index] = (newPosition, butterflies[index].1)
            }
            moveButterfly(index: index)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func butterflySize() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 25 : 50
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<butterflies.count, id: \.self) { index in
                    Butterfly(progress: butterflies[index].1, position: butterflies[index].0, screenSize: geometry.size)
                        .frame(width: butterflySize(), height: butterflySize())
                        .position(butterflies[index].0)
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
                                let newPosition = randomPosition(around: touchLocation!, radius: 200)
                                butterflies[index] = (newPosition, butterflies[index].1)
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
                    let position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    let progress = Double.random(in: 0...1)
                    butterflies.append((position, progress))
                }
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    for index in butterflies.indices {
                        butterflies[index].1 += 0.333
                        if butterflies[index].1 >= 1.0 {
                            butterflies[index].1 = 0
                        }
                    }
                }
            }
            .onDisappear{
                stopTimer()
            }
        }
    }
}
