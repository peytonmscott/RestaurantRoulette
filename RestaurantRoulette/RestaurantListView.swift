//
//  RestaurantListView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import SwiftUI

struct RestaurantListView: View {
    let restaurants: [Restaurant]

    var body: some View {
        List(restaurants) { restaurant in
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                Text(restaurant.location.city)
                    .font(.subheadline)
            }
        }
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView(restaurants: [])
    }
}

