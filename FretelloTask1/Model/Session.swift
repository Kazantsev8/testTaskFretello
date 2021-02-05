//
//  Session.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 28.01.2021.
//

import Foundation

typealias mainSession = [Session]

struct Session: Codable {
    let name: String?
    let practicedOnDate: String?
    let exercises: [Exercise]?
}

struct Exercise: Codable, Comparable {
    
    let exerciseId: String
    let name: String?
    let practicedAtBpm: Int?
    
    static func < (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.exerciseId < rhs.exerciseId
    }
    
}



