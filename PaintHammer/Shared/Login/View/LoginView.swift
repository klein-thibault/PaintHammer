//
//  LoginView.swift
//  PaintHammer
//
//  Created by Thibault Klein on 4/8/21.
//

import Environment
import SwiftUI

struct LoginView: View {
    @Binding var showLoginView: Bool
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: LoginViewModel

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Login to your PaintHammer account")
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .textContentType(.password)

                HStack {
                    Group {
                        Button(action: {
                            self.viewModel.login(email: self.email, password: self.password)
                        }) {
                            Text("Login")
                        }
                    }
                    .disabled(!viewModel.areCredentialsValid(email: email, password: password))

                    Text("or")

                    Button(action: {
                        self.viewModel.createAccount(email: self.email, password: self.password)
                    }) {
                        Text("Create Account")
                    }
                    .disabled(!viewModel.areCredentialsValid(email: email, password: password))
                }
            }
            .padding()
            .navigationBarItems(trailing: Button("Cancel") {
                showLoginView = false
            })
            .onAppear {
                viewModel.appEnvironment = appEnvironment
            }
        }
    }
}
