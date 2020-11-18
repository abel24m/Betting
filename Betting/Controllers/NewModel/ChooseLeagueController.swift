//
//  ChooseLeagueController.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class ChooseLeagueController: UIViewController {
    
    var modelMaster:ModelMaster!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var league: League!
    
    func fillScreen() {
        addLogoToTitleBar()
    }
    
    func addLogoToTitleBar(){
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    

    @IBAction func NflLeaguePressed(_ sender: UIButton) {
        modelMaster.setLeague(league: "NFL")
        league = NFL()
        performSegue(withIdentifier: "ChooseStatsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ChooseStatsSegue"){
            let destinationVC = segue.destination as! StatsChooseController
            destinationVC.league = league
            destinationVC.modelMaster = modelMaster
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
