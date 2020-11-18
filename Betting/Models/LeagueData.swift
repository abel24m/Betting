//
//  LeagueData.swift
//  Locks
//
//  Created by Abel Moreno on 11/14/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

/*
 Things to know

 
 */

protocol League {
    var stats : [String] { get }
    var apiKey : String { get }
    
}

protocol Football : League {
    var teamSeasonTotalsURL : String { get }
    var weeklyMatchupsURL : String { get }
    var getCurrentWeekURL : String { get }
}

class NFL : Football {
    
    var stats = ["Average Points Per Game",
                "Average Points Against",
                "Average Time of Possesion",
                "Redzone Attempts Per Game"]
    
    var teamSeasonRawData = [NFLTeamSeasonRawData]()
    var weeklyMatchupsRawData = [NFLWeeklyMatchUpRawData]()
    
    
    //API Data
    var apiKey = "?key=8a19bd07be804e71be2c4a5cfb210d2b"
    var teamSeasonTotalsURL = "https://api.sportsdata.io/v3/nfl/scores/json/TeamSeasonStats/2020reg"
    var weeklyMatchupsURL = "https://api.sportsdata.io/v3/nfl/scores/json/ScoresByWeek/2020reg/"
    var getCurrentWeekURL = "https://api.sportsdata.io/v3/nfl/scores/json/CurrentWeek"
    
    init() {
        getTeamSeasonRawData()
        getWeeklyMatchupData()
    }
    
    func getTeamSeasonRawData() {
        let urlString = ("\(teamSeasonTotalsURL)\(apiKey)")
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { [self] (data, resp, err) in
            
            if let safeData = data {
                do {
                    teamSeasonRawData = try JSONDecoder().decode([NFLTeamSeasonRawData].self, from: safeData)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    func getWeeklyMatchupData() {
        let currentWeek = getCurrentWeek()
        let urlString = ("\(weeklyMatchupsURL)\(currentWeek)\(apiKey)")
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { [self] (data, resp, err) in
            
            if let safeData = data {
                do {
                    weeklyMatchupsRawData = try JSONDecoder().decode([NFLWeeklyMatchUpRawData].self, from: safeData)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    private func getCurrentWeek() -> Int{
        var currentWeek = 0
        if let url = URL(string: "\(getCurrentWeekURL)\(apiKey)"){
            let session = URLSession(configuration: .default)
            
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
                    if day == 2
                    {
                        currentWeek = week + 1
                    }
                    else
                    {
                        currentWeek = week
                    }

                }
            }
            task.resume()
            
        }
        //Needs to be fixed
        while currentWeek == 0{
            
        }
        return currentWeek
    }
    
        
}

struct NBA {
    
}

struct NCAAF {
    
}

struct NCAAB{
    
}

struct MLB{
    
}
