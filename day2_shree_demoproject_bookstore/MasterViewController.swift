//
//  MasterViewController.swift
//  day2_shree_demoproject_bookstore
//
//  Created by Bishal on 3/25/20.
//  Copyright © 2020 Bishal. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, BookStoreDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var myBookStore: BookStore = BookStore()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        self.performSegue(withIdentifier: "addBookSegue", sender: nil)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedBook: Book = myBookStore.theBookStore[indexPath.row] //as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = selectedBook
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.delegate = self
            }
        }
        else if segue.identifier == "addBookSegue"{
            let vc = segue.destination as! AddBookViewController
            vc.delegate = self
        }
        
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookStore.theBookStore.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        //let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = myBookStore.theBookStore[indexPath.row].title//object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    
    
    //MARK: - Delegate methods conforming to the protocol BookStorDelegate as defined in the AddBookViewController
    
    func newBook(_ controller: AnyObject, newBook: Book) {
        myBookStore.theBookStore.append(newBook)
        tableView.reloadData()
            _ = navigationController?.popViewController(animated: true)
    }
    func deleteBook(_ controller: AnyObject) {
        let indexPath = tableView.indexPathForSelectedRow
        let row = (indexPath as NSIndexPath?)?.row
        myBookStore.theBookStore.remove(at: row!)
        tableView.reloadData()
            _ = navigationController?.popViewController(animated: false)
    }
    func editBook(_ controller: AnyObject, editBook: Book) {
        let indexPath = tableView.indexPathForSelectedRow
        let row = (indexPath as NSIndexPath?)?.row
        myBookStore.theBookStore.remove(at: row!+1)
        tableView.reloadData()
            _ = navigationController?.popViewController(animated: true)
    }

}


