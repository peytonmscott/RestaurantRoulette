//
//  FirebaseAuthManager.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager: ObservableObject {
    @Published var currentUser: User?

    init() {
        currentUser = Auth.auth().currentUser
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.currentUser = user
                completion(.success(user))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.currentUser = user
                completion(.success(user))
            }
        }
    }
}

