//
//  ViewController.swift
//  Todoey
//
//  Created by Travis Yatsko on 7/16/18.
//  Copyright © 2018 Travis Yatsko. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

  //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
       let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
        
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user taps the add item button on our UIAlert
          
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
func saveItems() {
    
        
        let encoder = PropertyListEncoder()
    
    do {
    let data = try encoder.encode(itemArray)
    try data.write(to: dataFilePath!)
    } catch {
    }
    self.tableView.reloadData()
    
    
}
    func loadItems() {
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
        do {
            itemArray = try decoder.decode([Item].self, from: data!)
        } catch {
            print(error)
        }
        
    }
}
