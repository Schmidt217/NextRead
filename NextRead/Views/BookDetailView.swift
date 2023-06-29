//
//  BookDetailView.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/22/23.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var readListViewModel: ReadListViewModel

    let book: Book

    var isBookInReadList: Bool {
        return readListViewModel.readList.contains(book)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text(book.title)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.heavy)

                AsyncImage(url: book.book_image) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "book")
                    case let .success(image):
                        image
                            .resizable()
                            .frame(width: 300)
                    case .failure:
                        Image(systemName: "book")
                    @unknown default:
                        Text("Unknown error")
                    }
                }

                Spacer()

                Text(book.author)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))

                Spacer()
                Text(book.description
                )
                .font(.system(size: 18, design: .rounded))
                .frame(width: 300)

                Spacer()

                if !book.buy_links.isEmpty {
                    ForEach(book.buy_links.prefix(upTo: 3), id: \.name) { link in
                        Button {
                            UIApplication.shared.open(link.url)
                        } label: {
                            Text(link.name)
                                .frame(width: 150)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .background(Capsule())
                        }
                    } //: FOREACH LOOP
                }
                Button {
                    if isBookInReadList {
                        readListViewModel.removeFromReadList(book: book)
                    } else {
                        readListViewModel.addToReadList(book: book)
                    }
                } label: {
                    Text(isBookInReadList ? "Remove from Read List" : "Add to Read List")
                }
            } //: VSTACK
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book.example)
    }
}
