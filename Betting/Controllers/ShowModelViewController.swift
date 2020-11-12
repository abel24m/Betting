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
    
    var modelMaster:ModelMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillScreen()

        // Do any additional setup after loading the view.
    }
    
    func fillScreen() {
        addLogotToTitleBar()
        
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
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
