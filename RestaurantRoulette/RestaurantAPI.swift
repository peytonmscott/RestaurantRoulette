//
//  RestaurantAPI.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import Foundation
import CoreLocation

struct RestaurantAPI {
    static let shared = RestaurantAPI()
    private let apiKey = "xPZ2P34TMQLX0X2gDqXisC_l1xYSWhczgbQmI8tBTN793CGvnIvENQ43YDIYPLPUl_CFlJDqQs3UVadvYKzZjxCc-Gw_lGrdw-52beOd2anU5u4hTm2T9t8Cz1FEZHYx"
    private let baseURL = "https://api.yelp.com/v3/businesses/search"

    func fetchNearbyRestaurants(location: CLLocation, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        let url = URL(string: "\(baseURL)?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=restaurants&limit=50")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            do {
                let jsonResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                completion(.success(jsonResponse.businesses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct RestaurantResponse: Codable {
    let businesses: [Restaurant]
}

struct Restaurant: Codable, Identifiable {
    let id: String
    let name: String
    let imageURL: URL
    let distance: Double
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case distance, location
    }
}

struct Location: Codable {
    let address1: String?
    let city: String
    let state: String
    let zipCode: String

    enum CodingKeys: String, CodingKey {
        case address1, city, state
        case zipCode = "zip_code"
    }
}

