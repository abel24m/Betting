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
            if matchup.Status == "Scheduled" && matchup.OverUnder != nil{
                var match = NFLMatchUp()
                let homeTeam = allTeams[matchup.HomeTeam!]!
                let awayTeam = allTeams[matchup.AwayTeam!]!
                match.HomeTeam = homeTeam.Name
                match.AwayTeam = awayTeam.Name
                match.PointSpread = matchup.PointSpread
                match.OverUnder = matchup.OverUnder
                for stat in modelMaster.getUserModelParameters().keys{
                    let statWinner : String
                    let modelPoints : [Double]
                    let spreadScoreAdjuster = abs(match.PointSpread) / Double(modelParams.count)
                    switch stat {
                    case "Average Points Per Game":
                        match.AvgPPG_Results = whoWonAveragePointsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.AvgPPG_Results.keys.first!
                        modelPoints = match.AvgPPG_Results.values.first!
                    case "Average Points Against":
                        match.AvgPA_Results = whoWonAveragePointsAgainst(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.AvgPA_Results.keys.first!
                        modelPoints = match.AvgPA_Results.values.first!
                    case "Time Of Possession":
                        match.AvgTOP_Results = whoWonTimeOfPossesion(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.AvgTOP_Results.keys.first!
                        modelPoints = match.AvgTOP_Results.values.first!
                    case "Redzone Attempts Per Game":
                        match.RedZone_Results = whoWonRedzoneAttemptsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster)
                        statWinner = match.RedZone_Results.keys.first!
                        modelPoints = match.RedZone_Results.values.first!
                    case "Opponent Time Of Possession":
                        match.OppTOP_Results = whoWonOpponentTimeOfPossession(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster)
                        statWinner = match.OppTOP_Results.keys.first!
                        modelPoints = match.OppTOP_Results.values.first!
                    case "Passing Completion Percentage":
                        match.PassComp_Results = whoWonPassCompletionPercentage(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster)
                        statWinner = match.PassComp_Results.keys.first!
                        modelPoints = match.PassComp_Results.values.first!
                    case "Third Down Percentage":
                        match.ThirdDownPercent_Results = whoWonThirdDownPercentage(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster)
                        statWinner = match.ThirdDownPercent_Results.keys.first!
                        modelPoints = match.ThirdDownPercent_Results.values.first!
                    case "Fourth Down Percentage":
                        match.FourthDownPercent_Results = whoWonFourthDownPercentage(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster)
                        statWinner = match.FourthDownPercent_Results.keys.first!
                        modelPoints = match.FourthDownPercent_Results.values.first!
                    case "Takeaways Per Game":
                        match.TakeawaysPG_Results = whoWonTakeawaysPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.TakeawaysPG_Results.keys.first!
                        modelPoints = match.TakeawaysPG_Results.values.first!
                    case "Passing Yards Per Game":
                        match.PassingYPG_Results = whoWonPassingYardsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.PassingYPG_Results.keys.first!
                        modelPoints = match.PassingYPG_Results.values.first!
                    case "Rushing Yards Per Game":
                        match.RushingYPG_Results = whoWonRushingYardsPerGame(homeTeam: homeTeam, awayTeam: awayTeam, percent: modelParams[stat]!, spreadAdjuster: spreadScoreAdjuster )
                        statWinner = match.RushingYPG_Results.keys.first!
                        modelPoints = match.RushingYPG_Results.values.first!
                    default:
                        continue
                    }
                    if statWinner == match.HomeTeam{
                        match.Home_moneylineScore += modelPoints[0]
                        match.Home_SpreadScore += modelPoints[1]
                    }else{
                        match.Away_moneylineScore += modelPoints[0]
                        match.Away_SpreadScore += modelPoints[1]
                    }
                }
                match.Home_MoneylinePercentage = getPercentage(scoreOne: match.Home_moneylineScore, scoreTwo: match.Away_moneylineScore)
                match.Away_MoneylinePercentage = getPercentage(scoreOne: match.Away_moneylineScore, scoreTwo: match.Home_moneylineScore)
                match.Home_SpreadPercentage = getSpreadPercentage(scoreOne: match.Home_SpreadScore, scoreTwo: match.Away_SpreadScore, spread: match.PointSpread, total: match.OverUnder)
                match.Away_SpreadPercentage = getSpreadPercentage(scoreOne: match.Away_SpreadScore, scoreTwo: match.Home_SpreadScore, spread: -(match.PointSpread), total: match.OverUnder)
                match.MoneylineWinner = match.Home_MoneylinePercentage > match.Away_MoneylinePercentage ? match.HomeTeam : match.AwayTeam
                match.SpreadWinner = match.Home_SpreadPercentage > match.Away_SpreadPercentage ? match.HomeTeam : match.AwayTeam
                nflMatchups.append(match)
            }
        }
        return nflMatchups
    }
    
    func getSpreadPercentage(scoreOne: Double, scoreTwo: Double, spread : Double, total: Double) -> Double {
        let scoreAdjuster = (total/(scoreOne+scoreTwo))
        let newScoreOne = (scoreOne*scoreAdjuster)
        let newScoreTwo = scoreTwo*scoreAdjuster
        let newTotal = newScoreOne+newScoreTwo
        let scoreSpread = newScoreOne+spread
        let result = scoreSpread/newTotal
        return result
    }
        
    func getPercentage(scoreOne: Double, scoreTwo: Double) -> Double {
        let total = scoreOne+scoreTwo
        let result = scoreOne / total
        return result
    }
    
    func whoWonRushingYardsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.50) + 1.0
        var rushingYards_Results = [String:[Double]]()
        let diff = abs(homeTeam.RushingYardsPerGame - awayTeam.RushingYardsPerGame)
        let moneyLinePoints = (Double(diff) * 0.05) * spreadValue
        let spreadPoints = (Double(diff) * 0.05) * spreadValue
        let winningTeam = homeTeam.RushingYardsPerGame > awayTeam.RushingYardsPerGame ? homeTeam.Name : awayTeam.Name
        rushingYards_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return rushingYards_Results
    }
    
    func whoWonPassingYardsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var passingYards_Results = [String:[Double]]()
        let diff = abs(homeTeam.PassingYardsPerGame - awayTeam.PassingYardsPerGame)
        let moneyLinePoints = (Double(diff) * 0.02) * spreadValue
        let spreadPoints = (Double(diff) * 0.02) * spreadValue
        let winningTeam = homeTeam.PassingYardsPerGame > awayTeam.PassingYardsPerGame ? homeTeam.Name : awayTeam.Name
        passingYards_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return passingYards_Results
    }
    
    func whoWonTakeawaysPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var takeAways_Results = [String:[Double]]()
        let diff = abs(homeTeam.TakeawaysPerGame - awayTeam.TakeawaysPerGame)
        let moneyLinePoints = (Double(diff) * 2.0) * spreadValue
        let spreadPoints = (Double(diff) * 2.0) * spreadValue
        let winningTeam = homeTeam.TakeawaysPerGame > awayTeam.TakeawaysPerGame ? homeTeam.Name : awayTeam.Name
        takeAways_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return takeAways_Results
    }
    
    func whoWonFourthDownPercentage(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var fourthDownPercent_Results = [String:[Double]]()
        let diff = abs(homeTeam.FourthDownPercentage - awayTeam.FourthDownPercentage)
        let moneyLinePoints = (Double(diff) * 0.2) * spreadValue
        let spreadPoints = (Double(diff) * 0.2) * spreadValue
        let winningTeam = homeTeam.FourthDownPercentage > awayTeam.FourthDownPercentage ? homeTeam.Name : awayTeam.Name
        fourthDownPercent_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return fourthDownPercent_Results
    }
    
    func whoWonThirdDownPercentage(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var thirdDownPercent_Results = [String:[Double]]()
        let diff = abs(homeTeam.ThirdDownPercentage - awayTeam.ThirdDownPercentage)
        let moneyLinePoints = (Double(diff) * 0.25) * spreadValue
        let spreadPoints = (Double(diff) * 0.25) * spreadValue
        let winningTeam = homeTeam.ThirdDownPercentage > awayTeam.ThirdDownPercentage ? homeTeam.Name : awayTeam.Name
        thirdDownPercent_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return thirdDownPercent_Results
    }
    
    func whoWonPassCompletionPercentage(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var PassComp_Results = [String:[Double]]()
        let diff = abs(homeTeam.PassingCompletionPercentage - awayTeam.PassingCompletionPercentage)
        let moneyLinePoints = (Double(diff) * 0.25) * spreadValue
        let spreadPoints = (Double(diff) * 0.25) * spreadValue
        let winningTeam = homeTeam.PassingCompletionPercentage > awayTeam.PassingCompletionPercentage ? homeTeam.Name : awayTeam.Name
        PassComp_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return PassComp_Results
    }
    
    func whoWonOpponentTimeOfPossession(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var OppTOP_Results = [String:[Double]]()
        let diff = abs(homeTeam.OpponentTimeOfPossession - awayTeam.OpponentTimeOfPossession)
        let moneyLinePoints = (Double(diff) * 0.015) * spreadValue
        let spreadPoints = (Double(diff) * 0.015) * spreadValue
        let winningTeam = homeTeam.OpponentTimeOfPossession < awayTeam.OpponentTimeOfPossession ? homeTeam.Name : awayTeam.Name
        OppTOP_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return OppTOP_Results
    }
    
    
    func whoWonRedzoneAttemptsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var avgRedzone_Results = [String:[Double]]()
        let diff = abs(homeTeam.RedZoneAttemptsPerGame - awayTeam.RedZoneAttemptsPerGame)
        let moneyLinePoints = (Double(diff) * 2.0) * spreadValue
        let spreadPoints = (Double(diff) * 2.0) * spreadValue
        let winningTeam = homeTeam.RedZoneAttemptsPerGame > awayTeam.RedZoneAttemptsPerGame ? homeTeam.Name : awayTeam.Name
        avgRedzone_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return avgRedzone_Results
        
    }
    
    func whoWonTimeOfPossesion(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var avgTOP_Results = [String:[Double]]()
        let diff = abs(homeTeam.TimeOfPossession - awayTeam.TimeOfPossession)
        let moneyLinePoints = (Double(diff) * 0.015) * spreadValue
        let spreadPoints = (Double(diff) * 0.015) * spreadValue
        let winningTeam = homeTeam.TimeOfPossession > awayTeam.TimeOfPossession ? homeTeam.Name : awayTeam.Name
        avgTOP_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return avgTOP_Results
    }
    
    func whoWonAveragePointsAgainst(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var avgPA_Results = [String:[Double]]()
        let diff = abs(homeTeam.AveragePointsAgainst - awayTeam.AveragePointsAgainst)
        let moneyLinePoints = (Double(diff) * 0.33) * spreadValue
        let spreadPoints = (Double(diff) * 0.33) * spreadValue
        let winningTeam = homeTeam.AveragePointsAgainst < awayTeam.AveragePointsAgainst ? homeTeam.Name : awayTeam.Name
        avgPA_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return avgPA_Results
    }
    
    func whoWonAveragePointsPerGame(homeTeam: NFLTeam, awayTeam: NFLTeam, percent: String, spreadAdjuster: Double) -> [String: [Double]] {
        let value = turnPercentageIntoDecimal(value: percent)
        let spreadValue = (value - 0.5) + 1.0
        var avgPPG_Results = [String:[Double]]()
        let diff = abs(homeTeam.AveragePointsPerGame - awayTeam.AveragePointsPerGame)
        let moneyLinePoints = (Double(diff) * 0.33) * spreadValue
        let spreadPoints = (Double(diff) * 0.33) * spreadValue
        let winningTeam = homeTeam.AveragePointsPerGame > awayTeam.AveragePointsPerGame ? homeTeam.Name : awayTeam.Name
        avgPPG_Results[winningTeam] = [moneyLinePoints,spreadPoints]
        return avgPPG_Results
    }
    
    func turnPercentageIntoDecimal(value: String) -> Double {
        let number = value.components(separatedBy: "%")
        let result = Double(number[0])! / 100.0
        return result
    }
    
    
    
    func getTeamStats() -> [String:NFLTeam]{
        var teams = [String:NFLTeam]()
        var teamInfoInterator = nfl.teamRawData.makeIterator()
        for teamData in nfl.teamSeasonRawData{
            var team = NFLTeam(team : teamData.Team)
            team.Name = teamInfoInterator.next()!.FullName
            for stat in modelMaster.getUserModelParameters().keys{
                switch stat {
                case "Average Points Per Game":
                    team.AveragePointsPerGame = calculateAveragePointsPerGame(data: teamData)
                case "Average Points Against":
                    team.AveragePointsAgainst = calculateAveragePointsAgainst(data: teamData)
                case "Time Of Possession":
                    team.TimeOfPossession = calculateTimeOfPossession(data: teamData)
                case "Redzone Attempts Per Game":
                    team.RedZoneAttemptsPerGame = calculateRedZoneAttemptsPerGame(data: teamData)
                case "Opponent Time Of Possession":
                    team.OpponentTimeOfPossession = calculateOpponentTimeOfPossesion(data: teamData)
                case "Passing Completion Percentage":
                    team.PassingCompletionPercentage = calculatePassingCompletionPercentage(data: teamData)
                case "Third Down Percentage":
                    team.ThirdDownPercentage = calculateThirdDownPercentage(data: teamData)
                case "Fourth Down Percentage":
                    team.FourthDownPercentage = calculateFourthDownPercentage(data: teamData)
                case "Takeaways Per Game":
                    team.TakeawaysPerGame = calculateTakeawaysPerGame(data: teamData)
                case "Passing Yards Per Game":
                    team.PassingYardsPerGame = calculatePassingYardsPerGame(data: teamData)
                case "Rushing Yards Per Game":
                    team.RushingYardsPerGame = calculateRushingYardsPerGame(data: teamData)
                default:
                    continue
                }
            }
            teams[team.Team] = team
        }
        return teams
    }
    
    private func calculateOpponentTimeOfPossesion(data: NFL_TeamSeasonRawData)->Int{
        let time = data.OpponentTimeOfPossession.components(separatedBy: ":")
        var totalseconds = Int(time[0])!*60
        totalseconds += Int(time[1])!
        return totalseconds
    }
    
    private func calculateRushingYardsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        let rushingYards = data.RushingYards
        let games = data.Games
        let result = Double(rushingYards)/Double(games)
        return result
    }
    
    private func calculatePassingYardsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        let passingYards = data.PassingYards
        let games = data.Games
        let result = Double(passingYards)/Double(games)
        return result
    }
    
    private func calculateTakeawaysPerGame(data: NFL_TeamSeasonRawData) -> Double{
        let takeaways = data.Takeaways
        let games = data.Games
        let result = Double(takeaways)/Double(games)
        return result
    }
    
    private func calculateFourthDownPercentage(data: NFL_TeamSeasonRawData) -> Double{
        return data.FourthDownPercentage
    }
    
    private func calculateThirdDownPercentage(data: NFL_TeamSeasonRawData) -> Double{
        return data.ThirdDownPercentage
    }
    
    private func calculatePassingCompletionPercentage(data: NFL_TeamSeasonRawData) -> Double{
        return data.CompletionPercentage
    }
    
    private func calculateAveragePointsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.Score) / Double(data.Games)
    }
    
    private func calculateAveragePointsAgainst(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.OpponentScore) / Double(data.Games)
    }
    
    private func calculateTimeOfPossession(data: NFL_TeamSeasonRawData) -> Int{
        let time = data.TimeOfPossession.components(separatedBy: ":")
        var totalseconds = Int(time[0])!*60
        totalseconds += Int(time[1])!
        return totalseconds
        
    }
    
    private func calculateRedZoneAttemptsPerGame(data: NFL_TeamSeasonRawData) -> Double{
        return Double(data.RedZoneAttempts) / Double(data.Games)
    }

    
    
    
    
    
}
