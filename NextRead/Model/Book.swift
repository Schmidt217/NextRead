//
//  Book.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import Foundation

struct Book: Codable, Equatable, Collection {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    // Collection conformance
    typealias Index = Array<BuyLinks>.Index
    typealias Element = Array<BuyLinks>.Element

    var startIndex: Index { return buy_links.startIndex }
    var endIndex: Index { return buy_links.endIndex }

    subscript(index: Index) -> Element {
        return buy_links[index]
    }

    func index(after i: Index) -> Index {
        return buy_links.index(after: i)
    }
    
    let rank: Int
    let publisher: String
    let description: String
    let title: String
    let author: String
    let book_image: URL
    var buy_links: [BuyLinks]
    var bookEntity: BookEntity?
    
    private enum CodingKeys: String, CodingKey {
           case rank, publisher, description, title, author, book_image, buy_links
       }
    
    init(rank: Int, publisher: String, description: String, title: String, author: String, book_image: URL, buy_links: [BuyLinks]) {
            self.rank = rank
            self.publisher = publisher
            self.description = description
            self.title = title
            self.author = author
            self.book_image = book_image
            self.buy_links = buy_links
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.rank = try container.decode(Int.self, forKey: .rank)
            self.publisher = try container.decode(String.self, forKey: .publisher)
            self.description = try container.decode(String.self, forKey: .description)
            self.title = try container.decode(String.self, forKey: .title)
            self.author = try container.decode(String.self, forKey: .author)
            let bookImageString = try container.decode(String.self, forKey: .book_image)
            if let bookImageURL = URL(string: bookImageString) {
                self.book_image = bookImageURL
            } else {
                self.book_image = URL(string: "https://example.com/placeholder_image.jpg")!
            }
            self.buy_links = try container.decode([BuyLinks].self, forKey: .buy_links)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(rank, forKey: .rank)
            try container.encode(publisher, forKey: .publisher)
            try container.encode(description, forKey: .description)
            try container.encode(title, forKey: .title)
            try container.encode(author, forKey: .author)
            try container.encode(book_image.absoluteString, forKey: .book_image)
            try container.encode(buy_links, forKey: .buy_links)
        }
    

    
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
            self.bookEntity = bookEntity
        }
}

extension BuyLinks {
    init(buyLinkEntity: BuyLinkEntity) {
        self.name = buyLinkEntity.name ?? ""
        self.url = URL(string: buyLinkEntity.url ?? "")!
    }
}
