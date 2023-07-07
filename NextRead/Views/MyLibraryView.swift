//
//  MyListView.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import SwiftUI

struct MyLibraryView: View {
    @EnvironmentObject var readListViewModel: ReadListViewModel

    @FetchRequest(
        entity: BookEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \BookEntity.title, ascending: true)],
        animation: .default)
    private var books: FetchedResults<BookEntity>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(books) { book in
                    if (book.title) != nil {
                        NavigationLink {
                            BookDetailView(book: Book(bookEntity: book))
                        } label: {
                                AsyncImage(url: URL(string: book.bookImage ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        Image(systemName: "book")
                                    case let .success(image):
                                        image
                                            .resizable()
                                            .frame(width: 75, height: 120)
                                    case .failure:
                                        Image(systemName: "book")
                                    @unknown default:
                                        Text("Unknown error")
                                    }
                                }
                        }
                    }
                }
            } // :HSTACK
        } //: SCROLLVIEW
   
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyLibraryView()
    }
}
