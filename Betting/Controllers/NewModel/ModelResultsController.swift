//
//  ModelResultsController.swift
//  Betting
//
//  Created by Abel Moreno on 10/21/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class ModelResultsController: UIViewController {
    
    @IBOutlet weak var ResultStackView: UIStackView!
    @IBOutlet weak var ContentViewHeighConstraint: NSLayoutConstraint!
    
    var resultsGenerator:ResultsGenerator!

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.resultsGenerator.run()
            self.populateResults()
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SaveModelSegue"){
            let destinationVC = segue.destination as! SaveModelViewController
            destinationVC.modelMaster = resultsGenerator.modelMaster
        }
    }
    

    @IBAction func SaveModelPressed(_ sender: Any) {
        performSegue(withIdentifier: "SaveModelSegue", sender: self)
    }
    
    
    @IBAction func NewModelPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func addLogoToTitleBar() {
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    
    func populateResults() {
        ContentViewHeighConstraint.constant = CGFloat(150 * resultsGenerator.results.count)
        for matchup in resultsGenerator.results{
            let matchupStackView = UIStackView()
            matchupStackView.axis = .horizontal
            matchupStackView.distribution = .fillEqually
            matchupStackView.alignment = .fill
            matchupStackView.spacing = 0
            
            //
            //
            //
            // HOME TEAM STACK VIEW
            //
            //
            //
            
            let homeStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: ResultStackView.frame.width / 2, height: 150))
            homeStackView.axis = .vertical
            homeStackView.distribution = .fill
            homeStackView.alignment = .fill
            homeStackView.spacing = 0
            
            //
            //
            //
            // HOME TEAM NAME VIEW
            //
            //
          
            let homeNameView = UIView(frame: CGRect(x: 0, y: 0, width: homeStackView.frame.width, height: 80))
            homeNameView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            homeStackView.addArrangedSubview(homeNameView)
            
            homeNameView.translatesAutoresizingMaskIntoConstraints = false
            
            var heightConstraint = NSLayoutConstraint(item: homeNameView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
            
            homeNameView.addConstraint(heightConstraint)
            
            //
            //
            //
            //HOME TEAM NAME LABEL
            //
            //
            //
            
            let homeLabel = UILabel()
            homeLabel.textColor = #colorLiteral(red: 0.9612759948, green: 1, blue: 0.1015161052, alpha: 1)
            homeLabel.font.withSize(100)
            homeLabel.textAlignment = NSTextAlignment.center
            homeLabel.text = matchup.HomeTeam
            homeNameView.addSubview(homeLabel)

            homeLabel.translatesAutoresizingMaskIntoConstraints = false
            //add constraints to view for label
            var centerXConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            var centerYConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            homeNameView.addConstraints([centerXConst, centerYConst])
            
            //
            //
            //
            //HOME PERCENT VIEW
            //
            //
            //
            
            let homeSUPercentView = UIView(frame: CGRect(x: 0, y: 0, width: homeStackView.frame.width, height: 35))
            if matchup.Home_MoneylinePercentage > matchup.Away_MoneylinePercentage{
                homeSUPercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                homeSUPercentView.backgroundColor = #colorLiteral(red: 0.8391280174, green: 0, blue: 0, alpha: 1)
            }
            
            homeStackView.addArrangedSubview(homeSUPercentView)
            
            homeSUPercentView.translatesAutoresizingMaskIntoConstraints = false
            
            heightConstraint = NSLayoutConstraint(item: homeSUPercentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
            
            homeSUPercentView.addConstraint(heightConstraint)
            
            //
            //
            //
            //HOME TEAM PERCENT LABEL
            //
            //
            //
            
            let homeSUPercentLabel = UILabel()
            homeSUPercentLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            homeSUPercentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 25)
            homeSUPercentLabel.textAlignment = NSTextAlignment.center
            homeSUPercentLabel.text = "\(Int(matchup.Home_MoneylinePercentage * 100))%"
            homeSUPercentView.addSubview(homeSUPercentLabel)
            
            homeSUPercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: homeSUPercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeSUPercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: homeSUPercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeSUPercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            homeSUPercentView.addConstraints([centerXConst, centerYConst])

            homeStackView.addArrangedSubview(homeSUPercentView)
            
            //
            //
            //
            //HOME ATS PERCENT VIEW
            //
            //
            //
            
            let homeATSPercentView = UIView(frame: CGRect(x: 0, y: 0, width: homeStackView.frame.width, height: 35))
            if matchup.Home_SpreadPercentage > matchup.Away_SpreadPercentage{
                homeATSPercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                homeATSPercentView.backgroundColor = #colorLiteral(red: 0.8391280174, green: 0, blue: 0, alpha: 1)
            }
            
            homeStackView.addArrangedSubview(homeATSPercentView)
            
            homeATSPercentView.translatesAutoresizingMaskIntoConstraints = false
            
            heightConstraint = NSLayoutConstraint(item: homeATSPercentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
            
            homeATSPercentView.addConstraint(heightConstraint)
            
            //
            //
            //
            //HOME TEAM ATS PERCENT LABEL
            //
            //
            //
            
            let homeATSPercentLabel = UILabel()
            homeATSPercentLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            homeATSPercentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 25)
            homeATSPercentLabel.textAlignment = NSTextAlignment.center
            homeATSPercentLabel.text = "\(Int(matchup.Home_SpreadPercentage * 100))%"
            homeATSPercentView.addSubview(homeATSPercentLabel)
            
            homeATSPercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: homeATSPercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeATSPercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: homeATSPercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeATSPercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            homeATSPercentView.addConstraints([centerXConst, centerYConst])

            homeStackView.addArrangedSubview(homeATSPercentView)
        
            //
            //
            //
            //AWAY TEAM STACK VIEW
            //
            //
            //
                        
            let awayStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: ResultStackView.frame.width / 2, height: 150))
            awayStackView.axis = .vertical
            awayStackView.distribution = .fill
            awayStackView.alignment = .fill
            awayStackView.spacing = 0
            
            
            //
            //
            //
            //AWAY TEAM NAME VIEW
            //
            //
            //
            
            let awayNameView = UIView(frame: CGRect(x: 0, y: 0, width: awayStackView.frame.width, height: 80))
            awayNameView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            awayStackView.addArrangedSubview(awayNameView)
            
            awayStackView.translatesAutoresizingMaskIntoConstraints = false
            
            heightConstraint = NSLayoutConstraint(item: awayNameView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
            
            awayNameView.addConstraint(heightConstraint)
        
            
            //
            //
            //
            //AWAY TEAM NAME LABEL
            //
            //
            //

            let awayLabel = UILabel()
            awayLabel.textColor = #colorLiteral(red: 0.9612759948, green: 1, blue: 0.1015161052, alpha: 1)
            awayLabel.font.withSize(100)
            awayLabel.textAlignment = NSTextAlignment.center
            awayLabel.text = matchup.AwayTeam
            awayNameView.addSubview(awayLabel)
            
            awayLabel.translatesAutoresizingMaskIntoConstraints = false
            //add constraints to view for label
            centerXConst = NSLayoutConstraint(item: awayLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayNameView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: awayLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayNameView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            awayNameView.addConstraints([centerXConst, centerYConst])
            
            //
            //
            //
            //AWAY TEAM PERCENT VIEW
            //
            //
            //
            
            let awayPercentView = UIView(frame: CGRect(x: 0, y: 0, width: homeStackView.frame.width, height: 35))
            if matchup.Home_MoneylinePercentage < matchup.Away_MoneylinePercentage{
                awayPercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                awayPercentView.backgroundColor = #colorLiteral(red: 0.8973830342, green: 0, blue: 0.1194367632, alpha: 1)
            }
            
            awayStackView.addArrangedSubview(awayPercentView)
            
            awayPercentView.translatesAutoresizingMaskIntoConstraints = false
            
            heightConstraint = NSLayoutConstraint(item: awayPercentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
            
            awayPercentView.addConstraint(heightConstraint)
            
            
            //
            //
            //
            //AWAY TEAM PERCENT LABEL
            //
            //
            //
            
            let awayPercentLabel = UILabel()
            awayPercentLabel.textColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            awayPercentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 25)
            awayPercentLabel.textAlignment = NSTextAlignment.center
            awayPercentLabel.text = "\(Int(matchup.Away_MoneylinePercentage * 100))%"
            awayPercentView.addSubview(awayPercentLabel)

            awayPercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            awayPercentView.addConstraints([centerXConst, centerYConst])
            
            //
            //
            //
            //AWAY TEAM ATS PERCENT VIEW
            //
            //
            //
            
            let awayATSPercentView = UIView(frame: CGRect(x: 0, y: 0, width: homeStackView.frame.width, height: 35))
            if matchup.Home_SpreadPercentage < matchup.Away_SpreadPercentage{
                awayATSPercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                awayATSPercentView.backgroundColor = #colorLiteral(red: 0.8973830342, green: 0, blue: 0.1194367632, alpha: 1)
            }
            
            awayStackView.addArrangedSubview(awayATSPercentView)
            
            awayATSPercentView.translatesAutoresizingMaskIntoConstraints = false
            
            heightConstraint = NSLayoutConstraint(item: awayATSPercentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)
            
            awayATSPercentView.addConstraint(heightConstraint)
            
            
            //
            //
            //
            //AWAY TEAM PERCENT LABEL
            //
            //
            //
            
            let awayATSPercentLabel = UILabel()
            awayATSPercentLabel.textColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            awayATSPercentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 25)
            awayATSPercentLabel.textAlignment = NSTextAlignment.center
            awayATSPercentLabel.text = "\(Int(matchup.Away_SpreadPercentage * 100))%"
            awayATSPercentView.addSubview(awayATSPercentLabel)

            awayATSPercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: awayATSPercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayATSPercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: awayATSPercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayATSPercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

            awayATSPercentView.addConstraints([centerXConst, centerYConst])
            
            matchupStackView.addArrangedSubview(homeStackView)
            matchupStackView.addArrangedSubview(awayStackView)
            
            
            ResultStackView.addArrangedSubview(matchupStackView)
            
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
