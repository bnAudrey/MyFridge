//
//  ItemDetailViewController.swift
//  MyFridge
//
//  Created by Brigitta Audrey on 27/04/22.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func doneAction(_ sender: Any) {
        saveData()
        
    }
    
    func saveData(){
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let timeString = df.string(from: datePickerField.date)
        
        let context = appDelegate.persistentContainer.viewContext
        let item = Fridge(context: context)
        item.itemName = itemNameField.text
        item.total = totalField.text!
        item.location = locationField.text
        item.datePicker = timeString
        do {
            context.insert(item)
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }

    
}
