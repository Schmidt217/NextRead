//
//  BookResponse.swift
//  NextRead
//
//  Created by Michael Schmidt on 5/19/23.
//

import Foundation

struct BookResponse: Codable {
    let results: BookResults
}

struct BookResults: Codable {
    let books: [Book]
}

