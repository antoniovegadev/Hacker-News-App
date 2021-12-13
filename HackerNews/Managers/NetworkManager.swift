//
//  NetworkManager.swift
//  HackerNewsApp
//
//  Created by Antonio Vega on 12/4/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://hacker-news.firebaseio.com/v0/"
    private let decoder = JSONDecoder()

    private init() {
        decoder.dateDecodingStrategy = .secondsSince1970
    }

    func fetchLiveData(filter: LiveData) async throws -> [ID] {
        let endPoint = baseURL + "\(filter.rawValue).json"
        guard let url = URL(string: endPoint) else { throw HNError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw HNError.invalidResponse }

        do {
            return try decoder.decode([ID].self, from: data)
        } catch {
            throw HNError.invalidData
        }
    }

    func fetchItems(ids: [ID]) async throws -> [Item] {
        do {
            return try await withThrowingTaskGroup(of: Item?.self) { group -> [Item] in
                for (index, id) in ids.enumerated() {
                    group.addTask { [self] in
                        guard var item = await self.fetchItem(id: id),
                              !item.wrappedDead && !item.wrappedDeleted else {
                            return nil
                        }
                        item.rank = index + 1
                        return item
                    }
                }

                let allStories = try await group.reduce(into: [Item]()) { $0.append($1) }.compactMap { $0 }
                return allStories.sorted { $0.rank < $1.rank }
            }
        } catch {
            throw HNError.failedFetchingItems
        }
    }

    private func fetchItem(id: ID) async -> Item? {
        let endPoint = baseURL + "item/\(id).json"
        guard let url = URL(string: endPoint) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decoder.decode(Item.self, from: data)
        } catch {
            return nil
        }
    }
}
