//
//  MainTableViewController.swift
//  ToDoList
//
//  Created by Neil Sood on 9/12/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreData

protocol AddViewControllerDelegate: class {
    func addToDo(by controller: AddViewController, with data: [String:String])
}

class MainTableViewController: UITableViewController {
    var items = [ToDoList]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddToDoSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.titleLabel.text = items[indexPath.row].title
        cell.infoLabel.text = items[indexPath.row].info
        cell.dateLabel.text = items[indexPath.row].date
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        print("blah")
//        if cell?.accessoryType == .none {
//            print("print")
//            cell?.accessoryType = .checkmark
//        }
//        else {
//            print("hi")
//            cell?.accessoryType = .none
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .none {
//                cell.accessoryType = .checkmark
////                tableView.reloadData()
//                print("what")
//            }
//            else {
//                cell.accessoryType = .none
////                self.tableView.reloadData()
//                print("the")
//            }
//        }
//    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                //                tableView.reloadData()
                print("what")
            }
            else {
                cell.accessoryType = .none
                //                self.tableView.reloadData()
                print("the")
            }
        }
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addViewController = navigationController.topViewController as! AddViewController
        addViewController.delegate = self
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"ToDoList")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [ToDoList]
        }
        catch {
            print("\(error)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}

extension MainTableViewController: AddViewControllerDelegate {
    func addToDo(by controller: AddViewController, with data: [String:String]) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: managedObjectContext) as! ToDoList
        item.title = data["title"]
        item.info = data["info"]
        item.date = data["date"]
        items.append(item)
        
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

