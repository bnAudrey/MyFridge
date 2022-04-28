//
//  ViewController.swift
//  MyFridge
//
//  Created by Brigitta Audrey on 27/04/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
//    var names = ["Brigitta Audrey", "gregorius Albert", "rahmat"]
    
    var items = [Fridge]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
//        var itemDetail = ItemDetail(itemName: "Roasted Peanut", location: "kitchen", total: 3)
//        items.append(itemDetail)

        let context = appDelegate.persistentContainer.viewContext
        do {
            let data = Fridge.fetchRequest()
            let result = try context.fetch(data)
            items = result
        }
        catch{}
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Will Appear")
        let context = appDelegate.persistentContainer.viewContext
        do {
            let data = Fridge.fetchRequest()
            let result = try context.fetch(data)
            items = result
        }
        catch{}
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("did appear")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.self.layer.cornerRadius = 10
        
        cell.layer.shadowColor = UIColor(
            red: 0.11,
            green: 0.11,
            blue: 0.11,
            alpha: 0.15).cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        cell.itemName.text = items[indexPath.row].itemName
        cell.location.text = items[indexPath.row].location
        cell.total.text = "\(items[indexPath.row].total!)"
        cell.expirationDate.text = items[indexPath.row].datePicker
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // pas di klik mau ngapain
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "Are you sure to delete this item?",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { _ in
                do{
                    let context = self.appDelegate.persistentContainer.viewContext
                    context.delete(self.items[indexPath.row])
                    try context.save()
        
                    do {
                        let data = Fridge.fetchRequest()
                        let result = try context.fetch(data)
                        self.items = result
                    }
                    catch{}
                    self.collectionView.reloadData()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        present(alert, animated: true)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        let context = appDelegate.persistentContainer.viewContext
        do {
            let data = Fridge.fetchRequest()
            let result = try context.fetch(data)
            items = result
        }
        catch{}
        collectionView.reloadData()
    }
    
    @IBAction func tapEdit(_ sender: UIBarButtonItem) {
//        let vc = CustomModalViewController()
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: false)
    }
    
    /// let appDelegate = UIApplication.shared.delegate as! AppDelegate
    /// let context = appDelegate.persistentContainer.viewContext
    /// 
    
}

