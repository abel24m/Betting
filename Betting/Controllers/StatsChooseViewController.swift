//
//  ViewController.swift
//  Betting
//
//  Created by Abel Moreno on 9/7/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class StatsChooseController: UIViewController {
    
    
    
    var statSwitches = [String:UISwitch]()
    var modelMaster:ModelMaster!
    
    var stats = Stats()
    
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ContentHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()
        // Do any additional setup after loading the view.
    }
    
    func fillScreen(){
        addLogoToTitleBar()
        populateStats()
    }
    
    
    func addLogoToTitleBar(){
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    
    @IBAction func DonePressed(_ sender: UIButton) {
        stats.statsChosen(statsChosen: statSwitches)
        performSegue(withIdentifier: "AssignValuesSegue", sender: self)
    }
    

    
    func populateStats() {
        let constant = (CGFloat)(stats.stat_fields.count * 100)
        ContentHeightConstraint.constant = constant
        for stat in stats.stat_fields{
            //create horizontal stack for stat field and switch
            let statStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width, height: 100))
            statStackView.axis = .horizontal
            statStackView.distribution = .fill
            statStackView.alignment = .fill
            statStackView.spacing = 0
            statStackView.layer.borderWidth = 0
            
            //Create view for label
            let labelView = UIView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width * 0.75, height: 100))
            labelView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            //Add label to view
            let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelView.frame.width, height: 100))
            newLabel.textColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
            newLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 17)
            newLabel.textAlignment = NSTextAlignment.left
            newLabel.text = stat
            labelView.addSubview(newLabel)
            newLabel.translatesAutoresizingMaskIntoConstraints = false
            labelView.translatesAutoresizingMaskIntoConstraints = false
            //add constraints to view for label
            var horizontalConstraint = NSLayoutConstraint(item: newLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: labelView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            var verticalConstraint = NSLayoutConstraint(item: newLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: labelView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            labelView.addConstraints([horizontalConstraint, verticalConstraint])
            statStackView.addArrangedSubview(labelView)
            
            
            //create view for switch
            let secondView = UIView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width * 0.25, height: 100))
            secondView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
            //add switch to view
            let switchOnOff = UISwitch(frame:CGRect(x: 0, y: 0, width: secondView.frame.width, height: 100))
            switchOnOff.setOn(true, animated: false)
            secondView.addSubview(switchOnOff)
            switchOnOff.translatesAutoresizingMaskIntoConstraints = false
            //add constraints to switch and view
            horizontalConstraint = NSLayoutConstraint(item: switchOnOff, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            verticalConstraint = NSLayoutConstraint(item: switchOnOff, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            secondView.addConstraints([horizontalConstraint, verticalConstraint])
            statStackView.addArrangedSubview(secondView)
            
            //Add constraints to label view to take up 3/4 of the stack. 
            let labelViewTrailingConstraint  = NSLayoutConstraint(item: labelView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: statStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -150)
            let labelViewLeadingConstraint = NSLayoutConstraint(item: labelView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: statStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
            
            statStackView.addConstraints([labelViewLeadingConstraint,labelViewTrailingConstraint])

            
            statSwitches.updateValue(switchOnOff, forKey: newLabel.text!)

            StackView.addArrangedSubview(statStackView)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue , sender: Any?) {
        if (segue.identifier == "AssignValuesSegue"){
            let destinationVC = segue.destination as! AssignValuesViewController
            destinationVC.modelMaster = modelMaster
            destinationVC.statSwitch = statSwitches
            destinationVC.stats = stats
            print("Preparing for segue")
        }
    }
    
}

