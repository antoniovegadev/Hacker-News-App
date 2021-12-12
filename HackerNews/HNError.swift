//
//  HNError.swift
//  HackerNewsApp
//
//  Created by Antonio Vega on 12/4/21.
//

import Foundation

enum HNError: String, Error {
    case invalidURL = "Invalid URL. Could not create URL"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data recieved from the server was invalid"
    case failedFetchingItems = "Failed to fetch items. Please try again."
}
