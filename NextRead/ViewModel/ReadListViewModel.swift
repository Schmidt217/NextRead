//
//  ReadListViewModel.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/22/23.
//

import Foundation
import CoreData


class ReadListViewModel: ObservableObject {
    @Published var readList: [BookEntity] = []

    private let context = PersistenceController.shared.container.viewContext
    
    func addToReadList(book: Book) {
        // Create and associate BuyLinkEntity objects
        let buyLinkEntities = book.buy_links.map { buyLink in
            let buyLinkEntity = BuyLinkEntity(context: context)
            buyLinkEntity.name = buyLink.name
            buyLinkEntity.url = buyLink.url.absoluteString
            return buyLinkEntity
        }
        
        let bookEntity = BookEntity(context: context)
        bookEntity.title = book.title
        bookEntity.author = book.author
        bookEntity.bookDescription = book.description
        bookEntity.publisher = book.publisher
        bookEntity.rank = Int16(book.rank)
        bookEntity.bookImage = book.book_image.absoluteString
        bookEntity.buyLinks = NSOrderedSet(array: buyLinkEntities)
        

        readList.append(bookEntity)
        do {
            try context.save()
        } catch {
            print("error! \(error.localizedDescription)")
        }
    }
    
//    func removeFromReadList(book: Book) {
//        if let index = readList.books.firstIndex(of: book) {
//            readList.books.remove(at: index)
//        }
//    }
  
}

