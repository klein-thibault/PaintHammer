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
            VStack(spacing: 25) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.lightGray)
                    .cornerRadius(5.0)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color.lightGray)
                    .cornerRadius(5.0)

                HStack {
                    Group {
                        Button(action: {
                            self.viewModel.login(email: self.email, password: self.password)
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.primary)
                                .cornerRadius(5.0)
                        }
                    }
                    .disabled(!viewModel.areCredentialsValid(email: email, password: password))

                    Text("or")

                    Button(action: {
                        self.viewModel.createAccount(email: self.email, password: self.password)
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primary)
                            .cornerRadius(5.0)
                    }
                    .disabled(!viewModel.areCredentialsValid(email: email, password: password))
                }

                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button("Cancel") {
                showLoginView = false
            })
            .onAppear {
                viewModel.appEnvironment = appEnvironment
            }
            .onReceive(viewModel.viewDismissalModePublisher, perform: { _ in
                if viewModel.token != nil {
                    showLoginView = false
                }
            })
        }
    }
}
