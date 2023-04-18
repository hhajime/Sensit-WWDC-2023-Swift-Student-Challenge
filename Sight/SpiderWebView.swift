import SwiftUI

struct SpiderWeb: Identifiable {
    let id = UUID()
    var position: CGPoint
}

struct SpiderWebView: View {
    @State private var spiderWebs: [SpiderWeb] = []
    
    private func createSpiderWeb(size: CGSize) {
        let x = CGFloat.random(in: 0...size.width)
        let startPosition = CGPoint(x: x, y: 0) // Starts on Top
        let spiderWeb = SpiderWeb(position: startPosition)
        
        spiderWebs.append(spiderWeb)
    }
    
    private func fallAnimation() -> Animation {
        Animation.linear(duration: 5)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(spiderWebs) { spiderWeb in
                    Image("spiderweb")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .position(spiderWeb.position)
                        .onAppear {
                            withAnimation(fallAnimation()) {
                                if let index = spiderWebs.firstIndex(where: { $0.id == spiderWeb.id }) {
                                    spiderWebs[index].position.y = geometry.size.height + 100 // Falling to bottom
                                }
                            }
                        }
                        .animation(fallAnimation(), value: spiderWeb.position)
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    createSpiderWeb(size: geometry.size)
                }
            }
        }
    }
}
