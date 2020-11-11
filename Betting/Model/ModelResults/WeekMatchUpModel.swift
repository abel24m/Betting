//
//  WeekMatchUpModel.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

struct WeekMatchUpModel {
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
