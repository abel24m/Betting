//
//  ResultsGenerator.swift
//  Locks
//
//  Created by Abel Moreno on 11/15/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import Foundation

protocol ResultsGenerator {
    
    var results : [MatchUpResults] {get set}
    var modelMaster : ModelMaster {get set}
    
    func run()
    
}
