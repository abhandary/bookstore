//
//  BookstoreViewModel.swift
//  Bookstore
//
//  Created by Akshay Bhandary on 11/16/21.
//

import Foundation


class BookstoreViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    init() {
        loadData()
    }
    
    // fetches books json from the local http server,
    // parses using JSONDecoder and publishes it through the 'book' property
    func loadData() {
        let urlString = "http://localhost:8000/books.json"
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: urlString) else {
            print("Error: Unable to create URL object for string", urlString)
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print("Error: got nil data")
                return
            }
            do {
                let booksMap = try JSONDecoder().decode([String: [Book]].self, from: data)
                if let books = booksMap["books"] {
                    DispatchQueue.main.async {
                        self.books = books
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
