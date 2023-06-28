//
//  Book.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import Foundation

struct Book: Codable, Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    let rank: Int
    let publisher: String
    let description: String
    let title: String
    let author: String
    let book_image: URL
    var buy_links: [BuyLinks]
    

    
    static let example = Book(
        rank: 1,
        publisher: "Berkley",
        description: "A former couple pretend to be together for the sake of their friends during their annual getaway in Maine",
        title: "HAPPY PLACE",
        author: "Emily Henry",
        book_image: URL(string: "https://storage.googleapis.com/du-prd/books/images/9780593441275.jpg")!,
        buy_links: [
            BuyLinks(name: "Amazon", url: URL(string: "https://www.amazon.com/dp/0593441273?tag=NYTBSREV-20")!),
            BuyLinks(name: "Apple Books", url: URL(string: "https://goto.applebooks.apple/9780593441275?at=10lIEQ")!),
            BuyLinks(name: "Barns and Noble", url: URL(string: "https://www.barnesandnoble.com/w/?ean=9780593441275")!)
        ]
    )
    
}

struct BuyLinks: Codable {
    let name: String
    let url: URL
    

}

extension Book {
        init(bookEntity: BookEntity) {
            self.title = bookEntity.title ?? ""
            self.author = bookEntity.author ?? ""
            self.publisher = bookEntity.publisher ?? ""
            self.description = bookEntity.bookDescription ?? ""
            self.rank = Int(bookEntity.rank)
            if let bookImageString = bookEntity.bookImage, let bookImageURL = URL(string: bookImageString) {
                self.book_image = bookImageURL
            } else {
                self.book_image = URL(string: "https://example.com/placeholder_image.jpg")!
            }
            self.buy_links = bookEntity.buyLinks?.map { BuyLinks(buyLinkEntity: $0 as! BuyLinkEntity) } ?? []
        }
}

extension BuyLinks {
    init(buyLinkEntity: BuyLinkEntity) {
        self.name = buyLinkEntity.name ?? ""
        self.url = URL(string: buyLinkEntity.url ?? "")!
    }
}
