//
//  TeamsStats.swift
//  Locks
//
//  Created by Abel Moreno on 11/14/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

//This file is used to store structs of sports teams.
//The struct will be used to create matchups.

struct NFLTeam {
    var Team : String
    var Name : String
    var AveragePointsPerGame : Double
    var AveragePointsAgainst : Double
    var AverageTimeOfPossesion : Int
    var RedZoneAttemptsPerGame : Double
    
    init(team: String) {
        AveragePointsPerGame = 0.0
        AveragePointsAgainst = 0.0
        AverageTimeOfPossesion = 0
        RedZoneAttemptsPerGame = 0.0
        Name = ""
        Team = team
    }
}

struct NCAAFTeam {
    var Team : String
    var Name : String
    var AveragePointsPerGame : Double
    var AveragePointsAgainst : Double
    var AverageTimeOfPossesion : Int
    var PassingCompletionPercentage : Double
    var RushingYardsPerAttempt : Double
    
    init(team: String) {
        AveragePointsAgainst = 0.0
        AveragePointsPerGame = 0.0
        AverageTimeOfPossesion = 0
        PassingCompletionPercentage = 0.0
        RushingYardsPerAttempt = 0.0
        Name = ""
        Team = team
    }
}

struct BasketballTeam {
    
}

struct BaseballTeam{
    
}


