//
//  LoginView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Doctor.entity(),
        sortDescriptors: []
    ) private var doctors: FetchedResults<Doctor>

    @State private var mailId = ""
    @State private var password = ""
    @State private var showError = false
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("Sign In")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                ) {
                    TextField("Enter Mail Id", text: $mailId)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Enter Password", text: $password)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if showError {
                        Text("Invalid username or password!")
                            .foregroundColor(.red)
                            .font(.system(size: 16))
                    }
                    
                    HStack {
                        Spacer()
                        Button("Sign in") {
                            authenticateUser()
                        }
                        .font(.system(size: 20))
                        .padding(.vertical, 5)
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                    
                }
                
                Section {
                    NavigationLink(destination: RegisterView()) {
                        Text("Not Registered? Click here")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 5)
                }
            }
            .fullScreenCover(isPresented: $isAuthenticated) {
                DashboardView()
            }
            .navigationBarTitle("Telemedicine App", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Telemedicine App")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
        }
    }
    
    private func authenticateUser() {
        if doctors.contains(where: { $0.mailId == mailId && $0.password == password }) {
            isAuthenticated = true
            showError = false
        } else {
            showError = true
        }
        mailId = ""
        password = ""
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
