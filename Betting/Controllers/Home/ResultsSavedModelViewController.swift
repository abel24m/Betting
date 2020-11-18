//
//  ResultsSavedModelViewController.swift
//  Locks
//
//  Created by Abel Moreno on 11/13/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class ResultsSavedModelViewController: UIViewController {

    @IBOutlet weak var ResultStackView: UIStackView!
    
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    
    var resultsGenerator:ResultsGenerator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.resultsGenerator.run()
            self.populateResults()
        }

        // Do any additional setup after loading the view.
    }
    
    
    func addLogoToTitleBar() {
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    
    func populateResults() {
        contentViewHeight.constant = CGFloat(200 * resultsGenerator.results.count)
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
            
            let homeStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: ResultStackView.frame.width / 2, height: 200))
            homeStackView.axis = .vertical
            homeStackView.distribution = .fill
            homeStackView.alignment = .fill
            homeStackView.spacing = 0
            
            //
            //
            //
            //HOME TEAM LOGO VIEW
            //
            //
            //

            let homeTeamLogoView = UIView()
            homeTeamLogoView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            homeStackView.addArrangedSubview(homeTeamLogoView)
            
            homeTeamLogoView.translatesAutoresizingMaskIntoConstraints = false
            var leadingConst = NSLayoutConstraint(item: homeTeamLogoView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            var trailingConst = NSLayoutConstraint(item: homeTeamLogoView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            var heightContraint = NSLayoutConstraint(item: homeTeamLogoView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            
            homeStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
            //
            //
            //
            //HOME TEAM LOGO IMAGE
            //
            //
            //
            
            let logo = UIImage(named: matchup.HomeTeam)
            let logoView = UIImageView(image: logo)
            homeTeamLogoView.addSubview(logoView)
            
            logoView.translatesAutoresizingMaskIntoConstraints = false
            var centerXConst = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeTeamLogoView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            var centerYConst = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeTeamLogoView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            var widthConst = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            var heighConst = NSLayoutConstraint(item: logoView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            
            homeTeamLogoView.addConstraints([centerYConst,centerXConst,widthConst, heighConst])
            
            //
            //
            //
            // HOME TEAM NAME VIEW
            //
            //
          
            let homeNameView = UIView()
            homeNameView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            homeStackView.addArrangedSubview(homeNameView)
            
            homeNameView.translatesAutoresizingMaskIntoConstraints = false
            leadingConst = NSLayoutConstraint(item: homeNameView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: homeNameView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightContraint = NSLayoutConstraint(item: homeNameView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            
            homeStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
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
            centerXConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            leadingConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeNameView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            var heightConst = NSLayoutConstraint(item: homeLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)

            homeNameView.addConstraints([centerXConst, centerYConst, leadingConst, trailingConst, heightConst])
            
            //
            //
            //
            //HOME PERCENT VIEW
            //
            //
            //
            
            let homePercentView = UIView()
            if matchup.Home_Percentage > matchup.Away_Percentage{
                homePercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                homePercentView.backgroundColor = #colorLiteral(red: 0.8391280174, green: 0, blue: 0, alpha: 1)
            }
            
            
            homeStackView.addArrangedSubview(homePercentView)
            
            homePercentView.translatesAutoresizingMaskIntoConstraints = false
            leadingConst = NSLayoutConstraint(item: homePercentView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: homePercentView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homeStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightContraint = NSLayoutConstraint(item: homePercentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            
            homeStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
            //
            //
            //
            //HOME TEAM PERCENT LABEL
            //
            //
            //
            
            let homePercentLabel = UILabel()
            homePercentLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            homePercentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 25)
            homePercentLabel.textAlignment = NSTextAlignment.center
            homePercentLabel.text = "\(Int(matchup.Home_Percentage * 100))%"
            homePercentView.addSubview(homePercentLabel)
            
            homePercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: homePercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homePercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: homePercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homePercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            leadingConst = NSLayoutConstraint(item: homePercentLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homePercentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: homePercentLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: homePercentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightConst = NSLayoutConstraint(item: homePercentLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)

            homePercentView.addConstraints([centerXConst, centerYConst, leadingConst, heightConst])

            homeStackView.addArrangedSubview(homePercentView)
        
            //
            //
            //
            //AWAY TEAM STACK VIEW
            //
            //
            //
                        
            let awayStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: ResultStackView.frame.width / 2, height: 200))
            awayStackView.axis = .vertical
            awayStackView.distribution = .fill
            awayStackView.alignment = .fill
            awayStackView.spacing = 0
            
            //
            //
            //
            //AWAY TEAM LOGO VIEW
            //
            //
            //
            
            let awayTeamLogoView = UIView()
            awayTeamLogoView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            awayStackView.addArrangedSubview(awayTeamLogoView)
            
            awayTeamLogoView.translatesAutoresizingMaskIntoConstraints = false
            leadingConst = NSLayoutConstraint(item: awayTeamLogoView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: awayTeamLogoView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightContraint = NSLayoutConstraint(item: awayTeamLogoView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            
            awayStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
            //
            //
            //
            //AWAY TEAM LOGO IMAGE
            //
            //
            //
            let awayLogo = UIImage(named: matchup.AwayTeam)
            let awayLogoImage = UIImageView(image: awayLogo)
            awayTeamLogoView.addSubview(awayLogoImage)
            
            awayLogoImage.translatesAutoresizingMaskIntoConstraints = false
            centerXConst = NSLayoutConstraint(item: awayLogoImage, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayTeamLogoView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: awayLogoImage, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayTeamLogoView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            widthConst = NSLayoutConstraint(item: awayLogoImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            heighConst = NSLayoutConstraint(item: awayLogoImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            
            awayTeamLogoView.addConstraints([centerYConst,centerXConst,widthConst, heighConst])
            
            //
            //
            //
            //AWAY TEAM NAME VIEW
            //
            //
            //
            
            let awayNameView = UIView()
            awayNameView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            
            awayStackView.addArrangedSubview(awayNameView)
            
            awayNameView.translatesAutoresizingMaskIntoConstraints = false
            leadingConst = NSLayoutConstraint(item: awayNameView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: awayNameView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightContraint = NSLayoutConstraint(item: awayNameView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            
            awayStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
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
            leadingConst = NSLayoutConstraint(item: awayLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayNameView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: awayLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayNameView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightConst = NSLayoutConstraint(item: awayLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)

            awayNameView.addConstraints([centerXConst, centerYConst, leadingConst, trailingConst, heightConst])
            
            //
            //
            //
            //AWAY TEAM PERCENT VIEW
            //
            //
            //
            
            let awayPercentView = UIView()
            if matchup.Home_Percentage < matchup.Away_Percentage{
                awayPercentView.backgroundColor = #colorLiteral(red: 0, green: 0.8792312741, blue: 0, alpha: 1)
            }else{
                awayPercentView.backgroundColor = #colorLiteral(red: 0.8973830342, green: 0, blue: 0.1194367632, alpha: 1)
            }
            
            awayStackView.addArrangedSubview(awayPercentView)
            
            awayPercentView.translatesAutoresizingMaskIntoConstraints = false
            leadingConst = NSLayoutConstraint(item: awayPercentView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: awayPercentView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightContraint = NSLayoutConstraint(item: awayPercentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            
            awayStackView.addConstraints([leadingConst, trailingConst, heightContraint])
            
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
            awayPercentLabel.text = "\(Int(matchup.Away_Percentage * 100))%"
            awayPercentView.addSubview(awayPercentLabel)

            awayPercentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            centerXConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            centerYConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            leadingConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            trailingConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: awayPercentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
            heightConst = NSLayoutConstraint(item: awayPercentLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)

            awayPercentView.addConstraints([centerXConst, centerYConst, leadingConst, trailingConst, heightConst])
            
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
