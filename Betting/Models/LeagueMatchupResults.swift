//
//  LeagueMatchupResults.swift
//  Locks
//
//  Created by Abel Moreno on 11/14/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

protocol MatchUpResults {
    var HomeTeam : String {get set}
    var AwayTeam : String {get set}
    var Home_Percentage : Double {get}
    var Away_Percentage : Double {get}
}

struct NFLMatchUp : MatchUpResults {    
    var HomeTeam : String
    var AwayTeam : String
    var Home_ModelScore : Double
    var Away_ModelScore : Double
    var Home_Percentage : Double
    var Away_Percentage : Double
    var Winner : String
    var AvgPPG_Results: [String:Double]
    var AvgPA_Results: [String:Double]
    var AvgTOP_Results: [String:Double]
    var RedZone_Results: [String:Double]
    
    init() {
        HomeTeam = ""
        AwayTeam = ""
        Home_ModelScore = 0.0
        Away_ModelScore = 0.0
        Home_Percentage = 0.0
        Away_Percentage = 0.0
        Winner = ""
        AvgPPG_Results = [String:Double]()
        AvgPA_Results = [String:Double]()
        AvgTOP_Results = [String:Double]()
        RedZone_Results = [String:Double]()
        
    }
    
}

struct NBAMatchup {
    
}
