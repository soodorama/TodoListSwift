//
//  AddViewController.swift
//  ToDoList
//
//  Created by Neil Sood on 9/12/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    weak var delegate: AddViewControllerDelegate?
    var data = [String:String]()
//    var indexPath: IndexPath
    
    @IBOutlet weak var addTitleLabel: UITextField!
    @IBOutlet weak var addInfoLabel: UITextField!
    @IBOutlet weak var toDoDatePicker: UIDatePicker!
    
    @IBAction func addItemPressed(_ sender: UIButton) {
        let title = addTitleLabel?.text
        let info = addInfoLabel?.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // "MM/dd/yyyy h:mm a" if you want normal time with no unnecessary 0's and am/pm
        let date = dateFormatter.string(from: toDoDatePicker.date)
        print(date)
        
        data["title"] = title
        data["info"] = info
        data["date"] = date
        
        delegate?.addToDo(by: self, with: data)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
