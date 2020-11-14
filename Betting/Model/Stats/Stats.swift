//
//  Stats.swift
//  Betting
//
//  Created by Abel Moreno on 9/7/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation
import UIKit

class Stats {
    
    private var sportsData_APIKey = "?key=8a19bd07be804e71be2c4a5cfb210d2b"
    private var teamSeasonStatsURL = "https://api.sportsdata.io/v3/nfl/scores/json/TeamSeasonStats/2020reg"
    
    var stat_fields = ["Average Points Per Game", "Average Points Against", "Average Time of Possesion", "Redzone Attempts Per Game"]
    
    var teamSeasonData =  [NFLTeamSeasonData]()
    var teamSeasonStats = [String:NFLTeamSeasonStats]()
    
    
    init() {
        DispatchQueue.main.async {
            self.getTeamSeasonStats()
        }
        
    }
    
    func statsChosen(statsChosen: [String:UISwitch]) {
        for (stat, uiSwitch) in statsChosen{
            if uiSwitch.isOn{
                switch stat {
                case "Average Points Per Game":
                    calculateAveragePointsPerGame()
                case "Average Points Against":
                    calculateAveragePointsAgainst()
                case "Average Time of Possesion":
                    calculateAverageTimeOfPossesion()
                case "Redzone Attempts Per Game":
                    calculateRedZoneAttemptsPerGame()
                default:
                    continue
                }
            }
            
        }
    }
    
    func runStats(statsChosen: [String:String]) {
        for (stat, value) in statsChosen{
            switch stat {
            case "Average Points Per Game":
                calculateAveragePointsPerGame()
            case "Average Points Against":
                calculateAveragePointsAgainst()
            case "Average Time of Possesion":
                calculateAverageTimeOfPossesion()
            case "Redzone Attempts Per Game":
                calculateRedZoneAttemptsPerGame()
            default:
                continue
            }
            
        }
    }
    
    private func calculateAveragePointsPerGame(){
        
        for teamData in teamSeasonData {
            if var teamStats = teamSeasonStats[teamData.Team]{
                teamStats.AveragePointsPerGame = Double(teamData.Score) / Double(teamData.Games)
                teamSeasonStats.updateValue(teamStats, forKey: teamData.Team)
            }else{
                var newTeamStats = NFLTeamSeasonStats()
                newTeamStats.TeamName = teamData.TeamName
                newTeamStats.AveragePointsPerGame = Double(teamData.Score) / Double(teamData.Games)
                teamSeasonStats.updateValue(newTeamStats, forKey: teamData.Team)
            }
            
        }
        
    }
    
    private func calculateAveragePointsAgainst(){
        for teamData in teamSeasonData {
            if var teamStats = teamSeasonStats[teamData.Team]{
                teamStats.AveragePointsAgainst = Double(teamData.OpponentScore) / Double(teamData.Games)
                teamSeasonStats.updateValue(teamStats, forKey: teamData.Team)
            }else{
                var newTeamStats = NFLTeamSeasonStats()
                newTeamStats.TeamName = teamData.TeamName
                newTeamStats.AveragePointsAgainst = Double(teamData.OpponentScore) / Double(teamData.Games)
                teamSeasonStats.updateValue(newTeamStats, forKey: teamData.Team)
            }
            
            
        }
    }
    
    private func calculateAverageTimeOfPossesion(){
        for teamData in teamSeasonData {
            if var teamStats = teamSeasonStats[teamData.Team]{
                let time = teamData.TimeOfPossession.components(separatedBy: ":")
                var totalseconds = Int(time[0])!*60
                totalseconds += Int(time[1])!
                teamStats.AverageTimeOfPossesion = totalseconds
                teamSeasonStats.updateValue(teamStats, forKey: teamData.Team)
            }else{
                var newTeamStats = NFLTeamSeasonStats()
                newTeamStats.TeamName = teamData.TeamName
                let time = teamData.TimeOfPossession.components(separatedBy: ":")
                var totalseconds = Int(time[0])!*60
                totalseconds += Int(time[1])!
                newTeamStats.AverageTimeOfPossesion = totalseconds
                teamSeasonStats.updateValue(newTeamStats, forKey: teamData.Team)
            }
            
        }
    }
    
    private func calculateRedZoneAttemptsPerGame(){
        for teamData in teamSeasonData {
            if var teamStats = teamSeasonStats[teamData.Team]{
                teamStats.RedZoneAttemptsPerGame = Double(teamData.RedZoneAttempts) / Double(teamData.Games)
                teamSeasonStats.updateValue(teamStats, forKey: teamData.Team)
            }else{
                var newTeamStats = NFLTeamSeasonStats()
                newTeamStats.TeamName = teamData.TeamName
                newTeamStats.RedZoneAttemptsPerGame = Double(teamData.RedZoneAttempts) / Double(teamData.Games)
                teamSeasonStats.updateValue(newTeamStats, forKey: teamData.Team)
            }
            
        }
    }
    
    
    private func getTeamSeasonStats() {
        let urlString = "\(teamSeasonStatsURL)\(sportsData_APIKey)"
        performRequest(urlString: urlString)
    }
    
    private func performRequest(urlString: String) {
        
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    private func handle(data: Data?, response: URLResponse?, error: Error?) {
        print("Abel- Got to handle")
        
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            parseJSON(seasonTeamData: safeData)
        }
    }
    
    private func parseJSON(seasonTeamData: Data) {
        print("Abel got to parseJSON")
        let decoder = JSONDecoder()
        do {
            teamSeasonData = try decoder.decode([NFLTeamSeasonData].self, from: seasonTeamData)
        } catch {
            print(error)
        }
    }
    
//    Points Per Game
//
//    Average Points they give up
//
//    Time of Possession
//
//    Inside the red zone
//
//    Record vs Top Teams
//
//    Record vs Bottom Teams
    
    
    
}
