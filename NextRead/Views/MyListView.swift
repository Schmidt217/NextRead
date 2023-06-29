//
//  MyListView.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import SwiftUI

struct MyListView: View {
    @EnvironmentObject var readListViewModel: ReadListViewModel

    @FetchRequest(
        entity: BookEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \BookEntity.title, ascending: true)],
        animation: .default)
    private var books: FetchedResults<BookEntity>

    var body: some View {
        List {
            ForEach(books) { book in
                if (book.title) != nil {
                    NavigationLink {
                        BookDetailView(book: Book(bookEntity: book))
                    } label: {
                        HStack {
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
                            VStack(alignment: .leading) {
                                Text(book.title ?? "")
                                    .font(.headline)
                                Text(book.author ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } //: VSTACK
                        } //: HSTACK
                    }
                }
            }
        }
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
