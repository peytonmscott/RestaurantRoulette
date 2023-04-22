//
//  RestaurantRouletteApp.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//
import SwiftUI
import Firebase
import CoreLocation

@main
struct RestaurantRouletteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let locationManager = LocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        locationManager.requestLocationPermission()
        return true
    }
}




