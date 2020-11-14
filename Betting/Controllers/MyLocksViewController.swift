//
//  MyLocksViewController.swift
//  Locksmith
//
//  Created by Abel Moreno on 11/2/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//

import UIKit

class MyLocksViewController: UIViewController {

    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var TitleBar: UINavigationItem!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var models:[Model]?
    let modelMaster = ModelMaster()
    let stats = Stats()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLogoToTitleBar()
        TableView.delegate = self
        TableView.dataSource = self
        
        fetchModels()

        // Do any additional setup after loading the view.
    }
    
    func addLogoToTitleBar() {
        let logo = #imageLiteral(resourceName: "Locks")
        let logoImageView = UIImageView(image: logo)
        logoImageView.contentMode = .scaleAspectFit
        TitleBar.titleView = logoImageView
    }
    
    /*
    // MARK: - Navigation
   
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchModels() {
        do {
            self.models = try context.fetch(Model.fetchRequest())
            
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        } catch  {
            
        }
    }

}

extension MyLocksViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedModels = try! context.fetch(Model.fetchRequest())
        let model = savedModels[indexPath.row] as! Model
        
        modelMaster.setLeague(league: model.league!)
        modelMaster.setUserStatData(stats: model.stats!)
        modelMaster.setModelName(name: model.name!)
        performSegue(withIdentifier: "ShowModelSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowModelSegue" {
            let destionationVC = segue.destination as! ShowModelViewController
            destionationVC.stats = stats
            destionationVC.modelMaster = modelMaster
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let modelToDelete = self.models![indexPath.row]
            
            self.context.delete(modelToDelete)
            
            do {
                try self.context.save()
            } catch  {
                
            }
            
            self.fetchModels()
            
            
        }
        
    }
}

extension MyLocksViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let model = models![indexPath.row]
        
        
        cell.textLabel?.text = model.name
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.imageView?.image = #imageLiteral(resourceName: "NflLogo")
        
        
        return cell
    }
    
    
}
