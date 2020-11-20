//
//  NFLResultsGenerator.swift
//  Locks
//
//  Created by Abel Moreno on 11/16/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation


class NFLResultsGenerator : ResultsGenerator {

    var results = [MatchUpResults]()
    var teamStats = [String:NFLTeam]()
    
    var nfl : NFL!
    var modelMaster: ModelMaster
    
    init(modelM: ModelMaster, league: NFL) {
        nfl = league
        modelMaster = modelM
        
    }
    
    func run() {
        results.removeAll()
        let allTeams = self.getTeamStats()
        self.results = self.getMatchResults(allTeams: allTeams)
    }
    
    func getMatchResults(allTeams: [String:NFLTeam]) -> [NFLMatchUp] {
        var nflMatchups = [NFLMatchUp]()
        let modelParams = modelMaster.getUserModelParameters()
        for matchup in nfl.weeklyMatchupsRawData{
            if matchup.Status == "Scheduled" || matchup.Status == "InProgess"{
                var match = NFLMatchUp()
                let homeTeam = allTeams[matchup.HomeTeam!]!
                let awayTeam = allTeams[matchup.AwayTeam!]!
                match.HomeTeam = homeTeam.Name
                match.AwayTeam = awayTeam.Name
                for stat in modelMaster.getUserModelParameters().keys{
                    switch stat {
                    case "Average Points Per Game":
                        match.AvgPPG_Results = whoWonAveragePointsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.AvgPPG_Results.keys.first!
                        let modelPoints = match.AvgPPG_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    case "Average Points Against":
                        match.AvgPA_Results = whoWonAveragePointsAgainst(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.AvgPA_Results.keys.first!
                        let modelPoints = match.AvgPA_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    case "Average Time of Possesion":
                        match.AvgTOP_Results = whoWonAverageTimeOfPossesion(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.AvgTOP_Results.keys.first!
                        let modelPoints = match.AvgTOP_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    case "Redzone Attempts Per Game":
                        match.RedZone_Results = whoWonRedzoneAttemptsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.RedZone_Results.keys.first!
                        let modelPoints = match.RedZone_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    default:
                        continue
                    }
                }
                match.Home_Percentage = getPercentage(scoreOne: match.Home_ModelScore, scoreTwo: match.Away_ModelScore)
                match.Away_Percentage = getPercentage(scoreOne: match.Away_ModelScore, scoreTwo: match.Home_ModelScore)
                match.Winner = match.Home_Percentage > match.Away_Percentage ? match.HomeTeam : match.AwayTeam
                nflMatchups.append(match)
            }
        }
        return nflMatchups
    }
    
    func getPercentage(scoreOne: Double, scoreTwo: Double) -> Double {
        let total = scoreOne+scoreTwo
        let result = scoreOne / total
        return result
    }
    
    
    func whoWonRedzoneAttemptsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgRedzone_Results = [String:Double]()
        let diff = abs(homeTeam.RedZoneAttemptsPerGame - awayTeam.RedZoneAttemptsPerGame)
        let modelPoints = (Double(diff) * 2) * value
        let winningTeam = homeTeam.RedZoneAttemptsPerGame > awayTeam.RedZoneAttemptsPerGame ? homeTeam.Name : awayTeam.Name
        avgRedzone_Results[winningTeam] = modelPoints
        return avgRedzone_Results
        
    }
    
    func whoWonAverageTimeOfPossesion(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgTOP_Results = [String:Double]()
        let diff = abs(homeTeam.AverageTimeOfPossesion - awayTeam.AverageTimeOfPossesion)
        let modelPoints = (Double(diff) * 0.01) * value
        let winningTeam = homeTeam.AverageTimeOfPossesion > awayTeam.AverageTimeOfPossesion ? homeTeam.Name : awayTeam.Name
        avgTOP_Results[winningTeam] = modelPoints
        return avgTOP_Results
    }
    
    func whoWonAveragePointsAgainst(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgPA_Results = [String:Double]()
        let diff = abs(homeTeam.AveragePointsAgainst - awayTeam.AveragePointsAgainst)
        let modelPoints = (diff * 0.29) * value
        let winningTeam = homeTeam.AveragePointsAgainst < awayTeam.AveragePointsAgainst ? homeTeam.Name : awayTeam.Name
        avgPA_Results[winningTeam] = modelPoints
        return avgPA_Results
    }
    
    func whoWonAveragePointsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgPPG_Results = [String:Double]()
        let diff = abs(homeTeam.AveragePointsPerGame - awayTeam.AveragePointsPerGame)
        let modelPoints = (diff * 0.29) * value
        print(modelPoints)
        let winningTeam = homeTeam.AveragePointsPerGame > awayTeam.AveragePointsPerGame ? homeTeam.Name : awayTeam.Name
        avgPPG_Results[winningTeam] = modelPoints
        return avgPPG_Results
    }
    
    func turnPercentageIntoDecimal(value: String) -> Double {
        let number = value.components(separatedBy: "%")
        let result = Double(number[0])! / 100.0
        return result
    }
    
    
    
    func getTeamStats() -> [String:NFLTeam]{
        var teams = [String:NFLTeam]()
        for teamData in nfl.teamSeasonRawData{
            var team = NFLTeam(team : teamData.Team)
            team.Name = teamData.TeamName
            for stat in modelMaster.getUserModelParameters().keys{
                switch stat {
                case "Average Points Per Game":
                    team.AveragePointsPerGame = calculateAveragePointsPerGame(data: teamData)
                case "Average Points Against":
                    team.AveragePointsAgainst = calculateAveragePointsAgainst(data: teamData)
                case "Average Time of Possesion":
                    team.AverageTimeOfPossesion = calculateAverageTimeOfPossesion(data: teamData)
                case "Redzone Attempts Per Game":
                    team.RedZoneAttemptsPerGame = calculateRedZoneAttemptsPerGame(data: teamData)
                default:
                    continue
                }
            }
            teams[team.Team] = team
        }
        return teams
    }
    
    private func calculateAveragePointsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.Score) / Double(data.Games)
    }
    
    private func calculateAveragePointsAgainst(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.OpponentScore) / Double(data.Games)
    }
    
    private func calculateAverageTimeOfPossesion(data: NFL_TeamSeasonRawData) -> Int{
        let time = data.TimeOfPossession.components(separatedBy: ":")
        var totalseconds = Int(time[0])!*60
        totalseconds += Int(time[1])!
        return totalseconds
        
    }
    
    private func calculateRedZoneAttemptsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.RedZoneAttempts) / Double(data.Games)
    }

    
    
    
    
    
}
