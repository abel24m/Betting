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
    let Temperature: Int
    let Humidity: Int
    let WindSpeed: Int
    let OverUnder: Double
    let PointSpread: Double
    let ScoreQuarter1: Int
    let ScoreQuarter2: Int
    let ScoreQuarter3: Int
    let ScoreQuarter4: Int
    let ScoreOvertime: Int
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
    let ReturnYards: Int
    let Penalties: Int
    let PenaltyYards: Int
    let Fumbles: Int
    let FumblesLost: Int
    let TimesSacked: Int
    let TimesSackedYards: Int
    let QuarterbackHits: Int
    let TacklesForLoss: Int
    let Safeties: Int
    let Punts: Int
    let PuntYards: Int
    let PuntAverage: Double
    let Giveaways: Int
    let Takeaways: Int
    let OpponentPuntNetYards: Int
    let TeamName: String
    let Games: Int
    let PassingDropbacks: Int
    let OpponentPassingDropbacks: Int
    let TeamSeasonID: Int
    let TwoPointConversionReturns: Int
    let OpponentTwoPointConversionReturns: Int
    let TeamID: Int
    let GlobalTeamID: Int
    let TeamStatID: Int
}

struct NFL_WeeklyMatchUpRawData: Decodable {
    let GameKey: String?
    let Date: String?
    let AwayTeam : String?
    let HomeTeam : String?
    let Channel : String?
    let Status: String?
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
    
}

struct NCAAB_WeeklyMatchUpRawData : Decodable {
    
}

