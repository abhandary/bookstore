//
//  Book.swift
//  Bookstore
//
//  Created by Akshay Bhandary on 11/16/21.
//

import Foundation

// model to represent the Book object parsed out books json response
// from the server
struct Book: Identifiable, Decodable, Hashable {
    let id: String
    let author: String
    let title: String
}
