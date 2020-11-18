//
//  StartModelController.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class StartModelController: UIViewController {

    @IBOutlet weak var TitleBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func addLogoToTitleBar() {
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        TitleBar.titleView = titleImageView
    }
    
    @IBAction func CreateAModelButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ChooseLeagueSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ChooseLeagueSegue"){
            let destinationVC = segue.destination as! ChooseLeagueController
            let modelMaster = ModelMaster()
            destinationVC.modelMaster = modelMaster
        }
    }
    
    
    

    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
