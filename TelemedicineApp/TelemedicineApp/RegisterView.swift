//
//  RegisterView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name = ""
    @State private var mailId = ""
    @State private var password = ""
    @State private var specialization = ""
    @State private var contact = ""
    @State private var location = ""
    @State private var registrationSuccess = false

    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Register Yourself!")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                ) {
                    TextField("Enter Full Name", text: $name)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter mail Id", text: $mailId)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Enter Password", text: $password)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Specialization", text: $specialization)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Contact Number", text: $contact)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Hospital Name", text: $location)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Sign Up") {
                            registerUser()
                        }
                        .font(.system(size: 20))
                        .padding(.vertical, 5)
                        .buttonStyle(.bordered)
                        Spacer()
                    }

                    if registrationSuccess {
                        Text("Registration successfull, please click on Back button!")
                            .font(.system(size: 16))
                            .padding(.vertical, 10)
                            .foregroundColor(.green)
                    }
                }
            }
        }
        
    }

    private func registerUser() {
        let newDoctor = Doctor(context: viewContext)
        newDoctor.name = name
        newDoctor.mailId = mailId
        newDoctor.password = password
        newDoctor.specialization = specialization
        newDoctor.contact = contact
        newDoctor.location = location

        DispatchQueue.main.async {
            do {
                try viewContext.save()
                registrationSuccess = true
            } catch {
                print("Failed to register user: \(error)")
            }
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
