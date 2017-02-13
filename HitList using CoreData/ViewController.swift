//
//  ViewController.swift
//  HitList using CoreData
//
//  Created by Nano Degree on 13/02/2017.
//  Copyright © 2017 Swift Pakistan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var names = [String]()
    
    //MARK : Outlets and Actions
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(actions:UIAlertAction) -> Void in
            
            let textFeild = alert.textFields!.first
            self.names.append(textFeild!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true , completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
//        tableView.register(UITableView.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
        
    }
    
    // MARK : UITableVIewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = names[indexPath.row]
        
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

