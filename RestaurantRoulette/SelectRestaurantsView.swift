//
//  SelectRestaurantsView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import SwiftUI

struct SelectRestaurantsView: View {
    let allRestaurants: [Restaurant]
    @State private var selectedRestaurants: Set<String> = []

    var body: some View {
        VStack {
            Text("Select Restaurants")
                .font(.title)
                .padding()

            List(allRestaurants, id: \.id) { restaurant in
                RestaurantRow(restaurant: restaurant, isSelected: selectedRestaurants.contains(restaurant.id)) {
                    if selectedRestaurants.contains(restaurant.id) {
                        selectedRestaurants.remove(restaurant.id)
                    } else if selectedRestaurants.count < 10 {
                        selectedRestaurants.insert(restaurant.id)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(height: 300)

            Text("Selected: \(selectedRestaurants.count) / 10")
                .padding()

            NavigationLink("Go to Roulette", destination: RouletteView(restaurants: allRestaurants.filter { selectedRestaurants.contains($0.id) }))
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(selectedRestaurants.count == 0)
        }
    }
}

struct RestaurantRow: View {
    let restaurant: Restaurant
    let isSelected: Bool
    let toggleSelection: () -> Void

    var body: some View {
        Button(action: toggleSelection) {
            HStack {
                Text(restaurant.name)
                    .foregroundColor(isSelected ? .red : .primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.red)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


