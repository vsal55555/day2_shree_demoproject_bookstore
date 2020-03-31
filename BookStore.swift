//
//  BookStore.swift
//  day2_shree_demoproject_bookstore
//
//  Created by Bishal on 3/26/20.
//  Copyright © 2020 Bishal. All rights reserved.
//

import Foundation


class BookStore{
    var theBookStore: [Book] = []
    
    
    init() {
        var newBook = Book()  //the first book object is allocated and initialized.
        newBook.title = "Swift for absolute Begineers"
        newBook.author = "Bennett and Lees"
        newBook.description = "iOS programming made easy"
        
    theBookStore.append(newBook)
        
        newBook = Book()
        newBook.title = "A Farewell to Arms"
        newBook.author = "Ernest Hemingway"
        newBook.description = "The story of an affair between english nurse and an american solider on World War I"
        
    theBookStore.append(newBook)
        
    }

}
