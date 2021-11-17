//
//  ContentView.swift
//  Bookstore
//
//  Created by Akshay Bhandary on 11/16/21.
//

import SwiftUI

struct BookstoreView: View {
    let data = (1...100).map { "Item \($0)" }

    @State var searchText: String = ""
    @ObservedObject var bookstoreViewModel = BookstoreViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]

    // lays out book images in a grid view.
    // tapping on any one of the images will take you to the detail view.
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(booksFiltered(), id: \.self) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                let urlString = "http://localhost:8000/\(book.id).jpg"
                                // using async image view here so that the images can be lazy loaded.
                                AsyncImage(url: URL(string: urlString)) {
                                    image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }.frame(width: 100, height: 150).cornerRadius(5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }.onTapGesture {
                // tapping on the hosting view will dismiss the keyboard.
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("Bookstore")
        }
    }
    
    // books are filtered by title or author based on the search text that's
    // entered into the search field.
    private func booksFiltered() -> [Book] {
        if searchText.isEmpty { return bookstoreViewModel.books }
        return bookstoreViewModel.books.filter {
            $0.author.containsCaseInsensitive(searchText) ||
            $0.title.containsCaseInsensitive(searchText)
        }
    }
}

struct BookstoreView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreView()
    }
}
