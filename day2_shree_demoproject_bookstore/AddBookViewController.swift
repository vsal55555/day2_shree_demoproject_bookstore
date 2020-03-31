//
//  AddBookViewController.swift
//  day2_shree_demoproject_bookstore
//
//  Created by Bishal on 3/27/20.
//  Copyright © 2020 Bishal. All rights reserved.
//

import UIKit


protocol BookStoreDelegate{
    func newBook(_ controller: AnyObject, newBook: Book)
    func editBook(_ controller: AnyObject, editBook: Book)
    func deleteBook(_ controller: AnyObject)
}

class AddBookViewController: UIViewController {
    
    var book = Book()
    var delegate: BookStoreDelegate?
    var read = false
    var editBook = false
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var pagesText: UITextField!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var descriptionText: UITextView!
    @IBAction func saveBookAction(_ sender: UIButton) {
    
    book.title = titleText.text!
    book.author = authorText.text!
    book.description = descriptionText.text!
    book.pages = Int(pagesText.text!)!
        if switchOutlet.isOn{
        book.readThisBook = true
        }
        else{
        book.readThisBook = false
        }
        if(editBook) {
            delegate!.editBook(self, editBook: book)
        }
        else{
        delegate!.newBook(self, newBook: book)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editBook == true{
        self.title = "Edit Book"
        titleText.text = book.title
        authorText.text = book.author
        pagesText.text = String(book.pages)
        descriptionText.text = book.description
            if book.readThisBook {
                switchOutlet.isOn = true
            }
            else{
                switchOutlet.isOn = false
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
