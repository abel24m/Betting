//
//  ModelMaster.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation
import UIKit

class ModelMaster{
    
    private var sportsData_APIKey = "?key=8a19bd07be804e71be2c4a5cfb210d2b"
    private var currentWeekURL = "https://api.sportsdata.io/v3/nfl/scores/json/CurrentWeek"
    private var weekMatchupsURL = "https://api.sportsdata.io/v3/nfl/scores/json/ScoresByWeek/2020reg/" // missing week parameter
    
    private var currentWeek = 0
    private var weekMatchupData = [WeekMatchUpData]()
    private var userModelData = [String:UILabel]()
    private var seasonStats = [String:NFLTeamSeasonStats]()
    public var modelResults = [WeekMatchUpModel]()
    
    private var league = ""
    
    let session = URLSession(configuration: .default)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        print("Created Model Master")
        
        
    }
    
    func setLeague(league: String) {
        let getCurrentWeekURLString = "\(currentWeekURL)\(sportsData_APIKey)"
        DispatchQueue.main.async {
            self.getCurrentWeek(urlString: getCurrentWeekURLString)
            self.getWeekMatchup()
        }
        self.league = league
    }
    
    func getLeague() -> String {
        return league
    }
    
    func setUserStatData(stats: [String:UILabel]){
        userModelData = stats
    }
    
    func setSeasonStats(stats: [String:NFLTeamSeasonStats]){
        seasonStats = stats
    }
    
    func getUserStatsChosen() -> [String:UILabel] {
        return userModelData
    }
    
    
//    init(userData: [String:UILabel], stats: [String:NFLTeamSeasonStats]) {
//
//        let getCurrentWeekURLString = "\(currentWeekURL)\(sportsData_APIKey)"
//        DispatchQueue.main.async {
//            self.getCurrentWeek(urlString: getCurrentWeekURLString)
//            self.getWeekMatchup()
//        }
//
//        userModelData = userData
//        seasonStats = stats
//    }
    
    func runModel() {
        for matchup in weekMatchupData{
            if matchup.Status != "Scheduled"{
                continue
            }
            var newMatchUpModel = WeekMatchUpModel()
            let hometeam = seasonStats[matchup.HomeTeam!]!
            let awayteam = seasonStats[matchup.AwayTeam!]!
            newMatchUpModel.HomeTeam = hometeam.TeamName
            newMatchUpModel.AwayTeam = awayteam.TeamName
            for (stat, value) in userModelData {
                let trueValue = convertToDecimal(label: value)
                switch stat {
                case "Average Points Per Game":
                    var avgPPG_ModelResults = [String:Double]()
                    let diff = abs(hometeam.AveragePointsPerGame - awayteam.AveragePointsPerGame)
                    let modelPoints = (diff * 0.29) * trueValue
                    let winningTeam = hometeam.AveragePointsPerGame > awayteam.AveragePointsPerGame ? hometeam.TeamName : awayteam.TeamName
                    if winningTeam == hometeam.TeamName {
                        newMatchUpModel.Home_ModelScore += modelPoints
                    }else{
                        newMatchUpModel.Away_ModelScore += modelPoints
                    }
                    avgPPG_ModelResults.updateValue(modelPoints, forKey: winningTeam)
                    newMatchUpModel.AvgPPG_Results = avgPPG_ModelResults
                case "Average Points Against":
                    var avgPPGAgainst_ModelResults = [String:Double]()
                    let diff = abs(hometeam.AveragePointsAgainst - awayteam.AveragePointsAgainst)
                    let modelPoints = (diff * 0.29) * trueValue
                    let winningTeam = hometeam.AveragePointsAgainst < awayteam.AveragePointsAgainst ? hometeam.TeamName : awayteam.TeamName
                    if winningTeam == hometeam.TeamName {
                        newMatchUpModel.Home_ModelScore += modelPoints
                    }else{
                        newMatchUpModel.Away_ModelScore += modelPoints
                    }
                    avgPPGAgainst_ModelResults.updateValue(modelPoints, forKey: winningTeam)
                    newMatchUpModel.AvgPA_Results = avgPPGAgainst_ModelResults
                case "Average Time of Possesion":
                    var avgTOP_ModelResults = [String:Double]()
                    let diff = abs(hometeam.AverageTimeOfPossesion - awayteam.AverageTimeOfPossesion)
                    let modelPoints = (Double(diff) * 0.01) * trueValue
                    let winningTeam = hometeam.AverageTimeOfPossesion > awayteam.AverageTimeOfPossesion ? hometeam.TeamName : awayteam.TeamName
                    if winningTeam == hometeam.TeamName {
                        newMatchUpModel.Home_ModelScore += modelPoints
                    }else{
                        newMatchUpModel.Away_ModelScore += modelPoints
                    }
                    avgTOP_ModelResults.updateValue(modelPoints, forKey: winningTeam)
                    newMatchUpModel.AvgTOP_Results = avgTOP_ModelResults
                case "Redzone Attempts Per Game":
                    var redzoneAPG_ModelResults = [String:Double]()
                    let diff = abs(hometeam.RedZoneAttemptsPerGame - awayteam.RedZoneAttemptsPerGame)
                    let modelPoints = (Double(diff) * 2) * trueValue
                    let winningTeam = hometeam.RedZoneAttemptsPerGame > awayteam.RedZoneAttemptsPerGame ? hometeam.TeamName : awayteam.TeamName
                    if winningTeam == hometeam.TeamName {
                        newMatchUpModel.Home_ModelScore += modelPoints
                    }else{
                        newMatchUpModel.Away_ModelScore += modelPoints
                    }
                    redzoneAPG_ModelResults.updateValue(modelPoints, forKey: winningTeam)
                    newMatchUpModel.RedZone_Results = redzoneAPG_ModelResults
                default:
                    continue
                }
            }
            newMatchUpModel.Winner = newMatchUpModel.Home_ModelScore > newMatchUpModel.Away_ModelScore ? hometeam.TeamName : awayteam.TeamName
            let total = newMatchUpModel.Home_ModelScore + newMatchUpModel.Away_ModelScore
            newMatchUpModel.Home_Percentage = newMatchUpModel.Home_ModelScore / total
            newMatchUpModel.Away_Percentage = newMatchUpModel.Away_ModelScore / total
            modelResults.append(newMatchUpModel)
        }
    }
    
    private func convertToDecimal(label: UILabel) -> Double {
        let number = label.text!.components(separatedBy: "%")
        let value = Double(number[0])! / 100.0
        return value
    }
    
    
    
    private func getCurrentWeek(urlString: String){
        if let url = URL(string: urlString){

            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    let date = Date()
                    let calender = Calendar.current
                    let day = calender.component(.weekday, from: date)
                    let str = String(decoding: safeData, as: UTF8.self)
                    let week = Int(str)!
                    print(day)
                    if day == 3
                    {
                        self.currentWeek = week + 1
                    }
                    else
                    {
                        self.currentWeek = week
                    }

                }
            }
            task.resume()
            //Need to fix This
            //This is terrible coding
            //Priority1
            while currentWeek == 0{

            }
            print(currentWeek)
        }
    }
    
    private func getWeekMatchup(){
        let urlString = "\(weekMatchupsURL)\(currentWeek)\(sportsData_APIKey)"
        performRequest(urlString: urlString)
        //Need to fix This
        //This is terrible coding
        //Priority1
        while weekMatchupData.count == 0{
            
        }
        print(weekMatchupData)
    }
    
    private func performRequest(urlString: String) {

        if let url = URL(string: urlString){

            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            while currentWeek == 0 {
                
            }
            task.resume()
        }
    }

    private func handle(data: Data?, response: URLResponse?, error: Error?) {

        if error != nil{
            print(error!)
            return
        }

        if let safeData = data {
            parseJSON(seasonTeamData: safeData)
        }
    }

    private func parseJSON(seasonTeamData: Data) {
        let decoder = JSONDecoder()
        do {
            weekMatchupData = try decoder.decode([WeekMatchUpData].self, from: seasonTeamData)
        } catch {
            print(error)
        }
    }
    
}
