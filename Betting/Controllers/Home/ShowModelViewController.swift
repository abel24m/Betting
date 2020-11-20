//
//  ShowModelViewController.swift
//  Locks
//
//  Created by Abel Moreno on 11/11/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class ShowModelViewController: UIViewController {
    
    @IBOutlet weak var ModelName: UILabel!
    @IBOutlet weak var MainStack: UIStackView!
    @IBOutlet weak var ContentViewHeight: NSLayoutConstraint!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var league : League!
    var modelMaster: ModelMaster!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.fillScreen()
        }
    }
    
    func fillScreen() {
        addLogotToTitleBar()
        ModelName.text = modelMaster.getModelName()
        ContentViewHeight.constant = CGFloat( 90 + (modelMaster.getUserModelParameters().count * 30))
        populateOverview()
        populateStats()
        
    }
    
    func addLogotToTitleBar(){
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    func populateOverview() {
        //
        //
        //
        // Subtitle Section "Overview"
        //
        //
        //
        let overView = UIView()
        overView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        MainStack.addArrangedSubview(overView)
        
        overView.translatesAutoresizingMaskIntoConstraints = false
        var heightConst = NSLayoutConstraint(item: overView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        var trailingConst = NSLayoutConstraint(item: overView, attribute: .trailing, relatedBy: .equal, toItem: MainStack, attribute: .trailing, multiplier: 1, constant: 0)
        var leadingConst = NSLayoutConstraint(item: overView, attribute: .leading, relatedBy: .equal, toItem: MainStack, attribute: .leading, multiplier: 1, constant: 0)
        
        MainStack.addConstraints([trailingConst,leadingConst,heightConst])
        
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
        
        MainStack.addArrangedSubview(leagueStackView)
        
        leagueStackView.translatesAutoresizingMaskIntoConstraints = false
        
        trailingConst = NSLayoutConstraint(item: leagueStackView, attribute: .trailing, relatedBy: .equal, toItem: MainStack, attribute: .trailing, multiplier: 1, constant: 0)
        leadingConst = NSLayoutConstraint(item: leagueStackView, attribute: .leading, relatedBy: .equal, toItem: MainStack, attribute: .leading, multiplier: 1, constant: 0)
        heightConst  = NSLayoutConstraint(item: leagueStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        
        MainStack.addConstraints([trailingConst,leadingConst,heightConst])
        
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
        
        MainStack.addArrangedSubview(statsSubTitleView)
        
        statsSubTitleView.translatesAutoresizingMaskIntoConstraints = false
        var heightConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        var trailingConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .trailing, relatedBy: .equal, toItem: MainStack, attribute: .trailing, multiplier: 1, constant: 0)
        var leadingConst = NSLayoutConstraint(item: statsSubTitleView, attribute: .leading, relatedBy: .equal, toItem: MainStack, attribute: .leading, multiplier: 1, constant: 0)
        
        MainStack.addConstraints([trailingConst,leadingConst,heightConst])
        
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
        
        let userData = modelMaster.getUserModelParameters()
        
        for (stat, value) in userData {
            
            /*
             Create Stack View for the stat name and value chosen
             */
            let statStackView = UIStackView()
            statStackView.axis = .horizontal
            statStackView.distribution = .fill
            statStackView.spacing = 1
            
            MainStack.addArrangedSubview(statStackView)
            
            statStackView.translatesAutoresizingMaskIntoConstraints = false
            
            trailingConst = NSLayoutConstraint(item: statStackView, attribute: .trailing, relatedBy: .equal, toItem: MainStack, attribute: .trailing, multiplier: 1, constant: 0)
            leadingConst = NSLayoutConstraint(item: statStackView, attribute: .leading, relatedBy: .equal, toItem: MainStack, attribute: .leading, multiplier: 1, constant: 0)
            heightConst  = NSLayoutConstraint(item: statStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            
            MainStack.addConstraints([trailingConst,leadingConst,heightConst])
            
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
            statValueLabel.text = value
            statValueView.addSubview(statValueLabel)
            
            statValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: statValueLabel, attribute: .centerX, relatedBy: .equal, toItem: statValueView, attribute: .centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: statValueLabel, attribute: .centerY, relatedBy: .equal, toItem: statValueView, attribute: .centerY, multiplier: 1, constant: 0)
            
            statValueView.addConstraints([centerXConst,centerYConst])
        }
    }
    
    @IBAction func runModelPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowResultsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResultsSegue" {
            let destinationVC = segue.destination as! ResultsSavedModelViewController
            switch modelMaster.getLeague() {
            case "NFL":
                destinationVC.resultsGenerator = NFLResultsGenerator(modelM: modelMaster, league: league as! NFL)
            case "NCAAF":
                destinationVC.resultsGenerator = NCAAFResultsGenerator(modelM: modelMaster, league: league as! NCAAF)
            default:
                destinationVC.resultsGenerator = NFLResultsGenerator(modelM: modelMaster, league: league as! NFL)
            }
            
            
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
