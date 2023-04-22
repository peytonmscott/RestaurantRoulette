//
//  LoginView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var error: String?
    @State private var isLoading = false
    @Binding var isLoggedIn: Bool
    @State private var isRegistering: Bool = false

    var body: some View {
        VStack {
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
                .foregroundColor(.black) // Set the foreground color to black
            Button(action: {
                signIn()
            }) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            if let error = error, !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()

            HStack {
                Text("Don't have an account?")
                Button(action: {
                    isRegistering = true
                }) {
                    Text("Create One")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitle("Login")
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            self.checkLoggedIn()
        }
        .sheet(isPresented: $isRegistering) {
            RegistrationView(isLoggedIn: $isLoggedIn)
        }
    }

    private func signIn() {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }

    private func checkLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
static var previews: some View {
LoginView(isLoggedIn: .constant(false))
    }
}

