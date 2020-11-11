//
//  WeekMatchUpData.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

struct WeekMatchUpData: Decodable {
    let GameKey: String?
    let Date: String?
    let AwayTeam : String?
    let HomeTeam : String?
    let Channel : String?
    let Status: String?
}
