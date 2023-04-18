//
//  NoteGenerator.swift
//  Sound
//
//  Created by Ha Jong Myeong on 2023/04/13.
//
import Foundation

struct Composition: Identifiable, Hashable {
    static func == (lhs: Composition, rhs: Composition) -> Bool {
        return lhs.id == rhs.id
    }

    let name: String = UUID().uuidString
    let notes: [Note]
    var id = UUID()
}

struct Note: Identifiable, Hashable {
    let startTime: Double
    let id = UUID()
}

let defaultComposition: [Note] = [
    Note(startTime: 2.0),
    Note(startTime: 4.0),
    Note(startTime: 5.0),
    Note(startTime: 7.0),
    Note(startTime: 8.0),
    Note(startTime: 10.0),
    Note(startTime: 11.0),
    Note(startTime: 13.0),
    Note(startTime: 14.0),
    Note(startTime: 16.0),
    Note(startTime: 17.0),
    Note(startTime: 19.0),
    Note(startTime: 20.0),
    Note(startTime: 22.0),
    Note(startTime: 23.0),
    Note(startTime: 24.0),
    Note(startTime: 25.0),
    Note(startTime: 26.0),
    Note(startTime: 27.0),
    Note(startTime: 28.0),
    Note(startTime: 29.0),
    Note(startTime: 30.0),
    Note(startTime: 31.0),
    Note(startTime: 32.0),
    Note(startTime: 33.0),
    Note(startTime: 34.0),
    Note(startTime: 35.0),
    Note(startTime: 36.0),
    Note(startTime: 37.0),
    Note(startTime: 38.0),
    Note(startTime: 39.0),
    Note(startTime: 40.0),
    Note(startTime: 41.0),
    Note(startTime: 42.0),
    Note(startTime: 43.0),
    Note(startTime: 44.0),
    Note(startTime: 45.0),
    Note(startTime: 46.0),
    Note(startTime: 47.0),
    Note(startTime: 48.0),
    Note(startTime: 49.0),
    Note(startTime: 50.0),
    Note(startTime: 51.0),
    Note(startTime: 52.0)
]
