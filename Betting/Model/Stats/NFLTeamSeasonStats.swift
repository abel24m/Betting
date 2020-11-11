//
//  TeamSeasonStats.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

struct NFLTeamSeasonStats {
    var TeamName : String
    var AveragePointsPerGame : Double
    var AveragePointsAgainst : Double
    var AverageTimeOfPossesion : Int
    var RedZoneAttemptsPerGame : Double
    
    init() {
        AveragePointsPerGame = 0.0
        AveragePointsAgainst = 0.0
        AverageTimeOfPossesion = 0
        RedZoneAttemptsPerGame = 0.0
        TeamName = ""
    }
}
