//
//  ReadListViewModel.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/22/23.
//

import CoreData

class ReadListViewModel: ObservableObject {
    @Published var readList: [Book] = []

    private let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = PersistenceController.shared.container
        loadReadList()
    }

    private func loadReadList() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        do {
            let bookEntities = try persistentContainer.viewContext.fetch(request)
            readList = bookEntities.map { Book(bookEntity: $0) }
        } catch {
            print("Failed to fetch read list: \(error)")
        }
    }

    private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    func addToReadList(book: Book) {
        if !readList.contains(book) {
            let bookEntity = BookEntity(context: persistentContainer.viewContext)
            bookEntity.title = book.title
            bookEntity.author = book.author
            bookEntity.publisher = book.publisher
            bookEntity.bookDescription = book.description
            bookEntity.rank = Int16(book.rank)
            bookEntity.bookImage = book.book_image.absoluteString

            for buyLink in book.buy_links {
                let buyLinkEntity = BuyLinkEntity(context: persistentContainer.viewContext)
                buyLinkEntity.name = buyLink.name
                buyLinkEntity.url = buyLink.url.absoluteString
                bookEntity.addToBuyLinks(buyLinkEntity)
            }

            readList.append(book)
            saveContext()
        }
    }

    func removeFromReadList(book: Book) {
            guard let bookEntity = book.bookEntity else {
                return
            }
            
            PersistenceController.shared.container.viewContext.delete(bookEntity)
            PersistenceController.shared.saveContext()
            readList.removeAll(where: { $0 == book })
    }
}
