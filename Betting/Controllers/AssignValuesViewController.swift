//
//  AssignValuesViewController.swift
//  Betting
//
//  Created by Abel Moreno on 9/25/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class AssignValuesViewController: UIViewController {

    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ContentView: UIView!
    
    var statSwitch = [String:UISwitch]()
    
    var sliderPercentages = [String:UILabel]()
    
    var stats:Stats!
    
    var modelMaster:ModelMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateStats()
        let title = #imageLiteral(resourceName: "Locks")
        let titleImageView = UIImageView(image: title)
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
        // Do any additional setup after loading the view.
    }
    
    @IBAction func donePressed(_ sender: Any) {
        performSegue(withIdentifier: "ResultsSegue", sender: self)
        
    }
    
    func populateStats() {
        let constant = (CGFloat)(statSwitch.count * 100)
        ContentViewHeight.constant = constant
        
        
        for stat in stats.stat_fields {
            let OnorOff = statSwitch[stat]!
            
            
            if OnorOff.isOn{
                
                //create a vertical stack to split as top and bottom
                //The top item will have the stat name and the value going to be associated with is
                //the bottom item will only have the slider, that will control the percentage value associated with it
                let fullStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width, height: 100))
                fullStackView.axis = .vertical
                fullStackView.distribution = .fillEqually
                fullStackView.alignment = .fill
                fullStackView.spacing = 0
                
                
                //create horizontal stack for stat field and switch
                let statStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width, height: 85))
                statStackView.axis = .horizontal
                statStackView.distribution = .fill
                statStackView.alignment = .fill
                statStackView.spacing = 0
                
                
                //Create view for label
                let labelView = UIView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width * 0.75, height: 85))
                labelView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
                //Add label to view
                let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelView.frame.width, height: 85))
                newLabel.textColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
                newLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 17)
                newLabel.textAlignment = NSTextAlignment.left
                newLabel.text = stat
                labelView.addSubview(newLabel)
                newLabel.translatesAutoresizingMaskIntoConstraints = false
                //add constraints to view for label
                var horizontalConstraint = NSLayoutConstraint(item: newLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: labelView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
                var verticalConstraint = NSLayoutConstraint(item: newLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: labelView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
                labelView.addConstraints([horizontalConstraint, verticalConstraint])
                //add view to horizontal stack view
                statStackView.addArrangedSubview(labelView)
                
                let percentView = UIView(frame: CGRect(x: 0, y: 0, width: StackView.frame.width * 0.25, height: 85))
                percentView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
                //Create/Add label for percent to view.
                let percentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: percentView.frame.width, height: 85))
                percentLabel.textColor = #colorLiteral(red: 0.7428528666, green: 0.7330520749, blue: 0.7115116715, alpha: 1)
                percentLabel.font = UIFont(name: "Kohinoor Gujarati Bold", size: 20)
                percentLabel.textAlignment = NSTextAlignment.center
                percentLabel.text = "50%"
                sliderPercentages.updateValue(percentLabel, forKey: stat)
                percentView.addSubview(percentLabel)
                percentLabel.translatesAutoresizingMaskIntoConstraints = false
                //add constraints to view for label
                horizontalConstraint = NSLayoutConstraint(item: percentLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: percentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
                verticalConstraint = NSLayoutConstraint(item: percentLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: percentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
                percentView.addConstraints([horizontalConstraint, verticalConstraint])
                
                statStackView.addArrangedSubview(percentView)
                
                labelView.translatesAutoresizingMaskIntoConstraints = false
                let labelViewTrailingConstraint  = NSLayoutConstraint(item: labelView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: statStackView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -110)
                let labelViewLeadingConstraint = NSLayoutConstraint(item: labelView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: statStackView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
                statStackView.addConstraints([labelViewTrailingConstraint, labelViewLeadingConstraint])
                
                fullStackView.addArrangedSubview(statStackView)
                
                //create a view for the slider.
                let sliderView = UIView(frame: CGRect(x: 0, y: 0, width: fullStackView.frame.width, height: 15))
                sliderView.backgroundColor = #colorLiteral(red: 0.04008977488, green: 0.03513521701, blue: 0.04804535955, alpha: 1)
                //Create+add slider to view
                let slider = UISlider(frame: CGRect(x: fullStackView.frame.width * 0.075, y: 0, width: fullStackView.frame.width * 0.85, height: 15))
                slider.maximumValue = 100
                slider.minimumValue = 0
                slider.tag = stats.stat_fields.firstIndex(of: stat)!
                slider.setValue(50, animated: true)
                slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
                sliderView.addSubview(slider)
                
                statStackView.addConstraints([labelViewTrailingConstraint, labelViewLeadingConstraint])

                fullStackView.addArrangedSubview(sliderView)
                                
                StackView.addArrangedSubview(fullStackView)
                
            }
            
            
            
        }
            
        
       
        
    }
    
    @objc func sliderValueChanged (sender: UISlider) {
        let formatValue = String(format: "%.0f", sender.value)
        sliderPercentages[stats.stat_fields[sender.tag]]?.text = "\(formatValue)%"
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue , sender: Any?) {
        if (segue.identifier == "ResultsSegue"){
            let destinationVC = segue.destination as! ModelResultsController
            modelMaster.setUserStatData(stats: sliderPercentages)
            modelMaster.setSeasonStats(stats: stats.teamSeasonStats)
            destinationVC.modelMaster = modelMaster
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
