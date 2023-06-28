//
//  HomeView.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var bookViewModel = BookViewModel()

    var body: some View {
        List(bookViewModel.books, id: \.title) { book in
            NavigationLink {
                BookDetailView(book: book)
            } label: {
                HStack {
                    AsyncImage(url: book.book_image) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "book")
                        case .success(let image):
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
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } //: VSTACK
                } //: HSTACK
            } // NAV LINK
        }
        .onAppear(perform: bookViewModel.fetchBooks)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
