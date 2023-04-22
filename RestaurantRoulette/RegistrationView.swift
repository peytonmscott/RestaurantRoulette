//
//  RegistrationView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//
import SwiftUI
import Firebase

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var error: String?
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack {
            Text("Create an Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                createAccount()
            }) {
                Text("Create Account")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationBarTitle("Register")
        .navigationBarBackButtonHidden(true)
    }
    
    private func createAccount() {
        // Check if password matches confirm password
        guard password == confirmPassword else {
            self.error = "Passwords do not match"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }
}

