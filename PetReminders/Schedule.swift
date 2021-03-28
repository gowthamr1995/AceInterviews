//
//  Schedule.swift
//  PetReminders
//
//  Created by Mac Mini on 26/03/2021.
//

import Foundation

struct Interviewer{
    var companyName: String
    private var rounds: [Round]
    
    mutating func addRound(rounds: [Round]){
    // sort
        self.rounds.append(contentsOf: rounds)
        self.rounds.sort { $0.startTime < $1.startTime }
    }
}

struct Round{
    var startTime: Date
    var duration: TimeInterval
}
