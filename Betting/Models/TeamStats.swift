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
    var TimeOfPossession : Int
    var OpponentTimeOfPossession : Int
    var RedZoneAttemptsPerGame : Double
    var PassingCompletionPercentage : Double
    var ThirdDownPercentage : Double
    var FourthDownPercentage : Double
    var TakeawaysPerGame : Double
    var PassingYardsPerGame : Double
    var RushingYardsPerGame : Double
    
    init(team: String) {
        AveragePointsPerGame = 0.0
        AveragePointsAgainst = 0.0
        TimeOfPossession = 0
        OpponentTimeOfPossession = 0
        RedZoneAttemptsPerGame = 0.0
        PassingCompletionPercentage = 0.0
        ThirdDownPercentage = 0.0
        FourthDownPercentage = 0.0
        TakeawaysPerGame = 0.0
        PassingYardsPerGame = 0.0
        RushingYardsPerGame = 0.0
        Name = ""
        Team = team
    }
}

struct NCAAFTeam {
    var Team : String
    var Name : String
    var AveragePointsPerGame : Double
    var AveragePointsAgainst : Double
    var TimeOfPossession : Int
    var OpponentTimeOfPossession : Int
    var PassingCompletionPercentage : Double
    var RushingYardsPerAttempt : Double
    
    init(team: String) {
        AveragePointsAgainst = 0.0
        AveragePointsPerGame = 0.0
        TimeOfPossession = 0
        OpponentTimeOfPossession = 0
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


