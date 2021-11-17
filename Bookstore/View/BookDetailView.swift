//
//  BookDetailView.swift
//  Bookstore
//
//  Created by Akshay Bhandary on 11/16/21.
//

import Foundation

import SwiftUI

// a static layout view that will show a Book's ID, author and title.
struct BookDetailView: View {
    let book: Book
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            HStack(alignment: .top) {
                Text("ID").font(.headline).padding(.leading, 10)
                Text(book.id)
            }
            Divider()
            HStack(alignment: .top) {
                Text("Author").font(.headline).padding(.leading, 10)
                VStack(alignment: .trailing) {
                    Text(book.author)
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing).padding(.trailing, 15)
            }
            Divider()
            HStack(alignment: .top) {
                Text("Title").font(.headline).padding(.leading, 10)
                Text(book.title)
            }
            Divider()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}
