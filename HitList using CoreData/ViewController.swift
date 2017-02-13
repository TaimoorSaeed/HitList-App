//
//  ViewController.swift
//  HitList using CoreData
//
//  Created by Nano Degree on 13/02/2017.
//  Copyright © 2017 Swift Pakistan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

//    var names = [String]()
    
    var people = [NSManagedObject]()
    
    
    //MARK : Outlets and Actions
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(actions:UIAlertAction) -> Void in
            
            let textFeild = alert.textFields!.first
//            self.names.append(textFeild!.text!)
//            self.tableView.reloadData()
            
            self.saveName(name: textFeild!.text!)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        //3
        do {
            let results =
                try context.fetch(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK : UITableVIewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        return names.count
            return people.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
//        cell!.textLabel!.text = names[indexPath.row]
        
        let person = people[indexPath.row]
        
        cell!.textLabel!.text = person.value(forKey: "name") as? String
        
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func saveName(name: String) {
        //1
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        
//         let managedContext = appDelegate.managedObjectContext
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:context)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto:context)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try context.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}

