//
//  LeagueMatchupResults.swift
//  Locks
//
//  Created by Abel Moreno on 11/14/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

protocol MatchUpResults {
    var HomeTeam : String! {get set}
    var AwayTeam : String! {get set}
    var Home_MoneylinePercentage : Double! {get}
    var Away_MoneylinePercentage : Double! {get}
    var Home_SpreadPercentage : Double! {get}
    var Away_SpreadPercentage : Double! {get}
}

struct NFLMatchUp : MatchUpResults {
    var HomeTeam : String!
    var AwayTeam : String!
    var Home_moneylineScore : Double!
    var Away_moneylineScore : Double!
    var Home_MoneylinePercentage : Double!
    var Away_MoneylinePercentage : Double!
    var Home_SpreadScore : Double!
    var Away_SpreadScore : Double!
    var Home_SpreadPercentage : Double!
    var Away_SpreadPercentage : Double!
    var MoneylineWinner : String!
    var SpreadWinner : String!
    var PointSpread : Double!
    var OverUnder : Double!
    var AvgPPG_Results: [String:[Double]]!
    var AvgPA_Results: [String:[Double]]!
    var AvgTOP_Results: [String:[Double]]!
    var RedZone_Results: [String:[Double]]!
    var OppTOP_Results: [String:[Double]]!
    var PassComp_Results : [String:[Double]]!
    var ThirdDownPercent_Results : [String:[Double]]!
    var FourthDownPercent_Results : [String:[Double]]!
    var TakeawaysPG_Results : [String:[Double]]!
    var PassingYPG_Results : [String:[Double]]!
    var RushingYPG_Results : [String:[Double]]!
    
    init() {
        Home_moneylineScore = 0.0
        Away_moneylineScore = 0.0
        Home_SpreadScore = 0.0
        Away_SpreadScore = 0.0
    }
    
}

struct NCAAFMatchUp : MatchUpResults {
    var Home_SpreadPercentage: Double!
    
    var Away_SpreadPercentage: Double!
    
    var HomeTeam : String!
    var AwayTeam : String!
    var Home_ModelScore : Double!
    var Away_ModelScore : Double!
    var Home_MoneylinePercentage : Double!
    var Away_MoneylinePercentage : Double!
    var Winner : String!
    var AvgPPG_Results: [String:Double]!
    var AvgPA_Results: [String:Double]!
    var AvgTOP_Results : [String:Double]!
    var PassComp_Results: [String:Double]!
    var RushYardsPA_Results : [String:Double]!

    
}

struct NBAMatchup {
    
}
