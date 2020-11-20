//
//  NCAAFResultsGenerator.swift
//  Locks
//
//  Created by Abel Moreno on 11/18/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation


class NCAAFResultsGenerator: ResultsGenerator {
    
    var results = [MatchUpResults]()
    
    var modelMaster: ModelMaster
    
    var ncaaf: NCAAF
    
    init(modelM: ModelMaster, league: NCAAF) {
        ncaaf = league
        modelMaster = modelM
    }
    
    func run() {
        results.removeAll()
        let allTeams = getTeamStats()
//        for team in allTeams{
//            print(team)
//            print("----------------")
//        }
        self.results = self.getMatchResults(allTeams: allTeams)
        for result in results{
            print(result)
            print("---------------------------")
        }
        
        
    }
    
    func getMatchResults(allTeams: [String:NCAAFTeam]) -> [NCAAFMatchUp] {
        var nflMatchups = [NCAAFMatchUp]()
        let modelParams = modelMaster.getUserModelParameters()
        for matchup in ncaaf.weeklyMatchupsRawData{
            if matchup.Status == "Scheduled" || matchup.Status == "InProgess" || matchup.Status == "Final" {
                var match = NCAAFMatchUp()
                let homeTeam = allTeams[matchup.HomeTeam]!
                let awayTeam = allTeams[matchup.AwayTeam]!
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
                    case "Average Time Of Possession":
                        print("AvgTOP")
                        match.AvgTOP_Results = whoWonAverageTimeOfPossesion(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.AvgTOP_Results.keys.first!
                        let modelPoints = match.AvgTOP_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    case "Passing Completion Percentage":
                        match.PassComp_Results = whoWonPassingCompletionPercentage(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.PassComp_Results.keys.first!
                        let modelPoints = match.PassComp_Results.values.first!
                        if statWinner == match.HomeTeam{
                            match.Home_ModelScore += modelPoints
                        }else{
                            match.Away_ModelScore += modelPoints
                        }
                    case "Rushing Yards Per Attempt":
                        match.RushYardsPA_Results = whoWonRushingYardsPerAttempt(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!)
                        let statWinner = match.RushYardsPA_Results.keys.first!
                        let modelPoints = match.RushYardsPA_Results.values.first!
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
                print(match)
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
    
    func whoWonRushingYardsPerAttempt(homeTeam: NCAAFTeam, awayTeam: NCAAFTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var RushYardsPA_Results = [String:Double]()
        let diff = abs(homeTeam.RushingYardsPerAttempt - awayTeam.RushingYardsPerAttempt)
        let modelPoints = (Double(diff) * 0.9) * value
        let winningTeam = homeTeam.RushingYardsPerAttempt > awayTeam.RushingYardsPerAttempt ? homeTeam.Name : awayTeam.Name
        RushYardsPA_Results[winningTeam] = modelPoints
        return RushYardsPA_Results
    }
    
    func whoWonPassingCompletionPercentage(homeTeam: NCAAFTeam, awayTeam: NCAAFTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var PassComp_Results = [String:Double]()
        let diff = abs(homeTeam.PassingCompletionPercentage - awayTeam.PassingCompletionPercentage)
        let modelPoints = (Double(diff) * 0.08) * value
        let winningTeam = homeTeam.PassingCompletionPercentage > awayTeam.PassingCompletionPercentage ? homeTeam.Name : awayTeam.Name
        PassComp_Results[winningTeam] = modelPoints
        return PassComp_Results
    }

    func whoWonAverageTimeOfPossesion(homeTeam: NCAAFTeam, awayTeam: NCAAFTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgTOP_Results = [String:Double]()
        let diff = abs(homeTeam.AverageTimeOfPossesion - awayTeam.AverageTimeOfPossesion)
        let modelPoints = (Double(diff) * 0.01) * value
        let winningTeam = homeTeam.AverageTimeOfPossesion > awayTeam.AverageTimeOfPossesion ? homeTeam.Name : awayTeam.Name
        avgTOP_Results[winningTeam] = modelPoints
        return avgTOP_Results
    }
    
    func whoWonAveragePointsAgainst(homeTeam: NCAAFTeam, awayTeam: NCAAFTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgPA_Results = [String:Double]()
        let diff = abs(homeTeam.AveragePointsAgainst - awayTeam.AveragePointsAgainst)
        let modelPoints = (diff * 0.20) * value
        let winningTeam = homeTeam.AveragePointsAgainst < awayTeam.AveragePointsAgainst ? homeTeam.Name : awayTeam.Name
        avgPA_Results[winningTeam] = modelPoints
        return avgPA_Results
    }
    
    func whoWonAveragePointsPerGame(homeTeam: NCAAFTeam, awayTeam: NCAAFTeam, percent: String) -> [String: Double] {
        let value = turnPercentageIntoDecimal(value: percent)
        var avgPPG_Results = [String:Double]()
        let diff = abs(homeTeam.AveragePointsPerGame - awayTeam.AveragePointsPerGame)
        let modelPoints = (diff * 0.20) * value
        let winningTeam = homeTeam.AveragePointsPerGame > awayTeam.AveragePointsPerGame ? homeTeam.Name : awayTeam.Name
        avgPPG_Results[winningTeam] = modelPoints
        return avgPPG_Results
    }
    
    func turnPercentageIntoDecimal(value: String) -> Double {
        let number = value.components(separatedBy: "%")
        let result = Double(number[0])! / 100.0
        return result
    }
    
    func getTeamStats() -> [String:NCAAFTeam]{
        var teams = [String:NCAAFTeam]()
        for teamData in ncaaf.teamSeasonRawData{
            var team = NCAAFTeam(team : teamData.Team)
            team.Name = teamData.Name
            for stat in modelMaster.getUserModelParameters().keys{
                switch stat {
                case "Average Points Per Game":
                    team.AveragePointsPerGame = calculateAveragePointsPerGame(data: teamData)
                case "Average Points Against":
                    team.AveragePointsAgainst = calculateAveragePointsAgainst(data: teamData)
                case "Average Time Of Possession":
                    team.AverageTimeOfPossesion = calculateAverageTimeOfPossesion(data: teamData)
                case "Passing Completion Percentage":
                    team.PassingCompletionPercentage = calculatePassingCompletionPercentage(data: teamData)
                case "Rushing Yards Per Attempt" :
                    team.RushingYardsPerAttempt = calculateRushingYardsPerAttempt(data: teamData)
                default:
                    continue
                }
            }
            teams[team.Team] = team
        }
        return teams
    }
    
    private func calculateAveragePointsPerGame(data: NCAAF_TeamSeasonRawData) -> Double{
        let totalGames = data.Losses + data.Wins
        let result = Double(data.PointsFor) / Double(totalGames)
        return result
    }
    
    private func calculateAveragePointsAgainst(data: NCAAF_TeamSeasonRawData) -> Double{
        let totalGames = data.Losses + data.Wins
        let result = Double(data.PointsAgainst) / Double(totalGames)
        return result
    }
    
    private func calculateAverageTimeOfPossesion(data: NCAAF_TeamSeasonRawData) -> Int{
        let totalGames = data.Losses + data.Wins
        let totalSeconds = (data.TimeOfPossessionMinutes * 60) + data.TimeOfPossessionSeconds
        let result = totalSeconds / totalGames
        return result
    }
    
    private func calculatePassingCompletionPercentage(data : NCAAF_TeamSeasonRawData) -> Double{
        return data.PassingCompletionPercentage
    }
    
    private func calculateRushingYardsPerAttempt(data: NCAAF_TeamSeasonRawData) -> Double{
        return data.RushingYardsPerAttempt
    }
    
}
