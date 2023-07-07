//
//  BookViewModel.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"]
    
    
    func fetchBooks() {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=\(apiKey ?? "00")") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BookResponse.self, from: data)
                DispatchQueue.main.async {
                    self.books = response.results.books
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print(error)
            }
        }.resume()
    }
    
    func searchBook(query: String) {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/reviews.json?title=\(query)&api-key=\(apiKey ?? "00")") else {
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BookResponse.self, from: data)
                DispatchQueue.main.async {
                    print(response)
//                    self.books = response.results.books
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print(error)
            }
        }.resume()
    }
}
