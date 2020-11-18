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
    
    private var modelName : String!
    private var modelParameters : [String:String]!
    private var league : String!
    
    func setLeague(league: String) {
        self.league = league
    }
    
    func getLeague() -> String {
        return league
    }
    
    func setModelName(name : String)  {
        modelName = name
    }
    
    func getModelName() -> String {
        return modelName
    }
    
    
    func setUserModelParameters(params: [String:String]){
        modelParameters = params
    }
    
    func getUserModelParameters() -> [String:String] {
        return modelParameters
    }
    
    
}
