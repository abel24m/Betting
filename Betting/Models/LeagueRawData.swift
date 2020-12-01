//
//  LeagueRawData.swift
//  Locks
//
//  Created by Abel Moreno on 11/14/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

//This file is gonna be used to store the struct objects being used to parse the json files coming through our api.

/*
 This Struct is not complete with all the possible variables that comes
 from the api get call
 */
struct NFL_TeamSeasonRawData: Decodable {
    let SeasonType: Int
    let Season: Int
    let Team: String
    let Score: Int
    let OpponentScore: Int
    let TotalScore: Int
    let TimeOfPossession: String
    let FirstDowns: Int
    let FirstDownsByRushing: Int
    let FirstDownsByPassing: Int
    let FirstDownsByPenalty: Int
    let OffensivePlays: Int
    let OffensiveYards: Int
    let OffensiveYardsPerPlay: Double
    let Touchdowns: Int
    let RushingAttempts: Int
    let RushingYards: Int
    let RushingYardsPerAttempt: Double
    let RushingTouchdowns: Int
    let PassingAttempts: Int
    let PassingCompletions: Int
    let PassingYards: Int
    let PassingTouchdowns: Int
    let PassingInterceptions: Int
    let PassingYardsPerAttempt: Double
    let PassingYardsPerCompletion: Double
    let CompletionPercentage: Double
    let PasserRating: Double
    let ThirdDownAttempts: Int
    let ThirdDownConversions: Int
    let ThirdDownPercentage:Double
    let FourthDownAttempts: Int
    let FourthDownConversions: Int
    let FourthDownPercentage: Double
    let RedZoneAttempts: Int
    let RedZoneConversions: Int
    let GoalToGoAttempts: Int
    let GoalToGoConversions: Int
    let Fumbles: Int
    let Takeaways: Int
//    let TeamName: String
    let Games: Int
    let TeamSeasonID: Int
    let OpponentTimeOfPossession: String
    let TeamID: Int
}

struct NFL_TeamRawData : Decodable{
    let Key: String
    let FullName: String
}

struct NFL_WeeklyMatchUpRawData: Decodable {
    let GameKey: String?
    let Date: String?
    let AwayTeam : String?
    let HomeTeam : String?
    let Status: String?
    let PointSpread : Double?
    let OverUnder : Double?
}

struct NCAAF_TeamSeasonRawData : Decodable{
    let Season: Int
    let Name: String
    let Team: String
    let Wins: Int
    let Losses: Int
    let PointsFor: Int
    let PointsAgainst: Int
    let TimeOfPossessionMinutes: Int
    let TimeOfPossessionSeconds: Int
    let PassingCompletionPercentage: Double
    let RushingYardsPerAttempt: Double
}

struct NCAAF_WeeklyMatchUpRawData : Decodable{
    let Status: String
    let HomeTeam: String
    let AwayTeam: String
    let Channel: String
}

struct NCAAB_TeamSeasonRawData: Decodable{
    let Season: Int
    let Name: String
    let Team: String
    let Wins : Int
    let Losses : Int
    let Games : Int
    let FieldGoalPercentage : Double
    let TwoPointersPercentage : Double
    let ThreePointersPercentage : Double
    let FreeThrowsPercentage : Double
    let OffensiveRebounds : Int
    let DefensiveRebounds : Int
    let Assists : Int
    let Steals : Int
    let Turnovers : Int
    let Points : Int
}

struct NCAAB_WeeklyMatchUpRawData : Decodable {
    let HomeTeam : String
    let AwayTeam : String
    let Status : String
    let Day : String
    
}

