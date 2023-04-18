//
//  HighlightGenerator.swift
//
//
//  Created by Ha Jong Myeong on 2023/04/19.
//

import Foundation

struct Quadrant {
    var position: Int
    var duration: Double
}

class HighlightGenerator {
    private var highlightQueue: [Quadrant]
    var currentIndex: Int
    private var onHighlightChanged: ((Int?) -> Void)?

    init(quadrants: [Quadrant]) {
        self.highlightQueue = quadrants
        self.currentIndex = 0
    }

    func start(onHighlightChanged: @escaping (Int?) -> Void) {
        self.onHighlightChanged = onHighlightChanged
        self.processNextQuadrant()
    }

    func processNextQuadrant() {
        guard currentIndex < highlightQueue.count else {
            onHighlightChanged?(nil)
            return
        }

        let quadrant = highlightQueue[currentIndex]
        onHighlightChanged?(quadrant.position)

        DispatchQueue.main.asyncAfter(deadline: .now() + quadrant.duration) { [weak self] in
            self?.currentIndex += 1
            self?.processNextQuadrant()
        }
    }
}

let quadrants = [
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 1, duration: 3.0),
                Quadrant(position: 3, duration: 3.0),
                Quadrant(position: 4, duration: 3.0),
                Quadrant(position: 1, duration: 3.0),
                Quadrant(position: 2, duration: 2.0),//16
                Quadrant(position: 3, duration: 3.0),
                Quadrant(position: 4, duration: 3.0),//22
                Quadrant(position: 1, duration: 3.0),
                Quadrant(position: 4, duration: 3.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 4, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
                Quadrant(position: 2, duration: 2.0),
                Quadrant(position: 3, duration: 2.0),
                Quadrant(position: 1, duration: 2.0),
            ]
