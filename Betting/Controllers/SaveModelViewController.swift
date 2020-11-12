//
//  SaveModelViewController.swift
//  Locks
//
//  Created by Abel Moreno on 11/6/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class SaveModelViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ContentViewContraint: NSLayoutConstraint!
    @IBOutlet weak var MainStackView: UIStackView!
    @IBOutlet weak var NameOfModel: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var modelMaster:ModelMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()
        NameOfModel.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        //create saved model
        let newModel = Model(context: context)
        newModel.name = NameOfModel.text
        newModel.league = modelMaster.getLeague()
        
        //UserStatsChosen need to be changed from String:UILabel to String:String
        var userStats = [String:String]()
        for (key,value) in modelMaster.getUserStatsChosen() {
            userStats[key] = value.text!
        }
        print(userStats)
        newModel.stats = userStats
        //save model to core data
        do {
            try self.context.save()
        } catch  {
        
        }
        
        //Jump to the home screen so the user can see the  new model added
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(identifier: "TabController") as UITabBarController
        nextViewController.selectedIndex = 1
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func fillScreen() {
        addLogoToTitleBar()
        ContentViewContraint.constant = CGFloat( 90 + (modelMaster.getUserStatsChosen().count * 30))
        DispatchQueue.main.async {
            self.populateOverview()
            self.populateStats()
        }
        
    }
    
    func addLogoToTitleBar() {
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    func populateOverview(){
        //
        //
        //
        // Subtitle Section "Overview"
        //
        //
        //
        let overView = UIView()
        overView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        MainStackView.addArrangedSubview(overView)
        
        overView.translatesAutoresizingMaskIntoConstraints = false
        var heightConst = NSLayoutConstraint(item: overView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        var trailingConst = NSLayoutConstraint(item: overView, attribute: .trailing, relatedBy: .equal, toItem: MainStackView, attribute: .trailing, multiplier: 1, constant: 0)
        var leadingConst = NSLayoutConstraint(item: overView, attribute: .leading, relatedBy: .equal, toItem: MainStackView, attribute: .leading, multiplier: 1, constant: 0)
        
        MainStackView.addConstraints([trailingConst,leadingConst,heightConst])
        
        let overViewLabel = UILabel()
        overViewLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        overViewLabel.textAlignment = .center
        overViewLabel.text = "Overview"
        overView.addSubview(overViewLabel)
        
        overViewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var centerXConst = NSLayoutConstraint(item: overViewLabel, attribute: .centerX, relatedBy: .equal, toItem: overView, attribute: .centerX, multiplier: 1, constant: 0)
        var centerYConst = NSLayoutConstraint(item: overViewLabel, attribute: .centerY, relatedBy: .equal, toItem: overView, attribute: .centerY, multiplier: 1, constant: 0)
        
        overView.addConstraints([centerXConst,centerYConst])
        
        //
        //
        //
        //League Row
        //
        //
        //
        
        /*
         Create Stack View for League title and League Name Chosen
         */
        let leagueStackView = UIStackView()
        leagueStackView.axis = .horizontal
        leagueStackView.distribution = .fillEqually
        leagueStackView.spacing = 0
        
        MainStackView.addArrangedSubview(leagueStackView)
        
        leagueStackView.translatesAutoresizingMaskIntoConstraints = false
        
        trailingConst = NSLayoutConstraint(item: leagueStackView, attribute: .trailing, relatedBy: .equal, toItem: MainStackView, attribute: .trailing, multiplier: 1, constant: 0)
        leadingConst = NSLayoutConstraint(item: leagueStackView, attribute: .leading, relatedBy: .equal, toItem: MainStackView, attribute: .leading, multiplier: 1, constant: 0)
        heightConst  = NSLayoutConstraint(item: leagueStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        
        MainStackView.addConstraints([trailingConst,leadingConst,heightConst])
        
        /*
         Create view for the League label
         */
        let leagueView = UIView()
        leagueView.backgroundColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
        
        leagueStackView.addArrangedSubview(leagueView)
        
        /*
         Add label to view that says "League :
         */
        let leagueLabel = UILabel()
        leagueLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        leagueLabel.textAlignment = .left
        leagueLabel.text = "League :"
        leagueView.addSubview(leagueLabel)
        
        leagueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        centerXConst = NSLayoutConstraint(item: leagueLabel, attribute: .centerX, relatedBy: .equal, toItem: leagueView, attribute: .centerX, multiplier: 1, constant: 0)
        centerYConst = NSLayoutConstraint(item: leagueLabel, attribute: .centerY, relatedBy: .equal, toItem: leagueView, attribute: .centerY, multiplier: 1, constant: 0)
        
        leagueView.addConstraints([centerXConst,centerYConst])
        
        /*
         Create view for the League Chosen label
         */
        let leagueChosenView = UIView()
        leagueChosenView.backgroundColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
        
        leagueStackView.addArrangedSubview(leagueChosenView)
        
        /*
         Add label to view that defines league chosen
         */
        let leagueChosenLabel = UILabel()
        leagueChosenLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        leagueChosenLabel.textAlignment = .left
        leagueChosenLabel.text = modelMaster.getLeague()
        leagueChosenView.addSubview(leagueChosenLabel)
        
        leagueChosenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        centerXConst = NSLayoutConstraint(item: leagueChosenLabel, attribute: .centerX, relatedBy: .equal, toItem: leagueChosenView, attribute: .centerX, multiplier: 1, constant: 0)
        centerYConst = NSLayoutConstraint(item: leagueChosenLabel, attribute: .centerY, relatedBy: .equal, toItem: leagueChosenView, attribute: .centerY, multiplier: 1, constant: 0)
        
        leagueChosenView.addConstraints([centerXConst,centerYConst])
        
        
    }
    
    func populateStats() {
        
        let statsSubTitleView = UIView()
        statsSubTitleView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        MainStackView.addArrangedSubview(statsSubTitleView)
        
        statsSubTitleView.translatesAutoresizingMaskIntoConstraints = false
        var heightConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        var trailingConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .trailing, relatedBy: .equal, toItem: MainStackView, attribute: .trailing, multiplier: 1, constant: 0)
        var leadingConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .leading, relatedBy: .equal, toItem: MainStackView, attribute: .leading, multiplier: 1, constant: 0)
        
        MainStackView.addConstraints([trailingConst,leadingConst,heightConst])
        
        let statsAndValuesLabel = UILabel()
        statsAndValuesLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        statsAndValuesLabel.textAlignment = .center
        statsAndValuesLabel.text = "Stats and Values"
        statsSubTitleView.addSubview(statsAndValuesLabel)
        
        statsAndValuesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var centerXConst = NSLayoutConstraint(item: statsAndValuesLabel, attribute: .centerX, relatedBy: .equal, toItem: statsSubTitleView, attribute: .centerX, multiplier: 1, constant: 0)
        var centerYConst = NSLayoutConstraint(item: statsAndValuesLabel, attribute: .centerY, relatedBy: .equal, toItem: statsSubTitleView, attribute: .centerY, multiplier: 1, constant: 0)
        
        statsSubTitleView.addConstraints([centerXConst,centerYConst])
        
        //
        //
        //
        // Iterate through every stat chosen to place them one at a time
        //
        //
        //
        
        let userData = modelMaster.getUserStatsChosen()
        
        for (stat, value) in userData {
            
            /*
             Create Stack View for the stat name and value chosen
             */
            let statStackView = UIStackView()
            statStackView.axis = .horizontal
            statStackView.distribution = .fill
            statStackView.spacing = 1
            
            MainStackView.addArrangedSubview(statStackView)
            
            statStackView.translatesAutoresizingMaskIntoConstraints = false
            
            trailingConst = NSLayoutConstraint(item: statStackView, attribute: .trailing, relatedBy: .equal, toItem: MainStackView, attribute: .trailing, multiplier: 1, constant: 0)
            leadingConst = NSLayoutConstraint(item: statStackView, attribute: .leading, relatedBy: .equal, toItem: MainStackView, attribute: .leading, multiplier: 1, constant: 0)
            heightConst  = NSLayoutConstraint(item: statStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            
            MainStackView.addConstraints([trailingConst,leadingConst,heightConst])
            
            /*
             Create view for the League label
             */
            let statView = UIView()
            statView.backgroundColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
            
            statStackView.addArrangedSubview(statView)
            
            statView.translatesAutoresizingMaskIntoConstraints = false
            
            leadingConst = NSLayoutConstraint(item: statView, attribute: .leading, relatedBy: .equal, toItem: statStackView, attribute: .leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: statView, attribute: .trailing, relatedBy: .equal, toItem: statStackView, attribute: .trailing, multiplier: 1, constant: -125)
            let topConst = NSLayoutConstraint(item: statView, attribute: .top, relatedBy: .equal, toItem: statStackView, attribute: .top, multiplier: 1, constant: 0)
            let bottomConst = NSLayoutConstraint(item: statView, attribute: .bottom, relatedBy: .equal, toItem: statStackView, attribute: .bottom, multiplier: 1, constant: 0)
            
            statStackView.addConstraints([leadingConst,trailingConst,topConst,bottomConst])
            
            /*
             Add label to view that says "League :
             */
            let statLabel = UILabel()
            statLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            statLabel.textAlignment = .left
            statLabel.text = stat
            statView.addSubview(statLabel)
            
            statLabel.translatesAutoresizingMaskIntoConstraints = false
            
            leadingConst = NSLayoutConstraint(item: statLabel, attribute: .leading, relatedBy: .equal, toItem: statView, attribute: .leading, multiplier: 1, constant: 25)
            centerYConst = NSLayoutConstraint(item: statLabel, attribute: .centerY, relatedBy: .equal, toItem: statView, attribute: .centerY, multiplier: 1, constant: 0)
            
            statView.addConstraints([leadingConst,centerYConst])
            
            /*
             Create view for the League Chosen label
             */
            let statValueView = UIView()
            statValueView.backgroundColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
            
            statStackView.addArrangedSubview(statValueView)
            
            /*
             Add label to view that defines league chosen
             */
            let statValueLabel = UILabel()
            statValueLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            statValueLabel.textAlignment = .left
            statValueLabel.text = value.text
            statValueView.addSubview(statValueLabel)
            
            statValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: statValueLabel, attribute: .centerX, relatedBy: .equal, toItem: statValueView, attribute: .centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: statValueLabel, attribute: .centerY, relatedBy: .equal, toItem: statValueView, attribute: .centerY, multiplier: 1, constant: 0)
            
            statValueView.addConstraints([centerXConst,centerYConst])
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
