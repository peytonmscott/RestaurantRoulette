//
//  ContentView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var restaurants: [Restaurant] = []
    @State private var isLoggedIn = false

    private func fetchNearbyRestaurants() {
        if let userLocation = locationManager.userLocation {
            RestaurantAPI.shared.fetchNearbyRestaurants(location: userLocation) { result in
                switch result {
                case .success(let fetchedRestaurants):
                    DispatchQueue.main.async {
                        restaurants = fetchedRestaurants
                    }
                case .failure(let error):
                    print("Error fetching restaurants: \(error)")
                }
            }
        }
    }

    var body: some View {
        if isLoggedIn {
            NavigationView {
                VStack {
                    if let userLocation = locationManager.userLocation {
                        Text("Your location: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
                            .font(.footnote)
                            .padding()
                            .foregroundColor(.white)

                        SelectRestaurantsView(allRestaurants: restaurants)
                    } else {
                        Text("Loading location...")
                            .foregroundColor(.white)
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .navigationTitle("Restaurant Roulette")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Restaurant Roulette")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
                .onChange(of: locationManager.userLocation) { _ in
                    fetchNearbyRestaurants()
                }
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
