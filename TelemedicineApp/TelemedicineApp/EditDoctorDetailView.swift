//
//  EditDoctorDetailView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct EditDoctorDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var doctor: Doctor?
    
    @State private var name: String = ""
    @State private var mailId: String = ""
    @State private var password: String = ""
    @State private var specialization: String = ""
    @State private var contact: String = ""
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("Doctor Details")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter the name", text: $name)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Mail ID", text: $mailId)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Password", text: $password)
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
                    
                    TextField("Enter Hospital Location", text: $location)
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save Details") {
                            updateDetails()
                        }
                        .buttonStyle(.bordered)
                        .font(.system(size: 18))
                        .padding(.vertical, 5)
                        .disabled(name.isEmpty || mailId.isEmpty || password.isEmpty || specialization.isEmpty || contact.isEmpty || location.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Edit Doctor Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Doctor Details")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                name = doctor?.name ?? ""
                mailId = doctor?.mailId ?? ""
                password = doctor?.password ?? ""
                specialization = doctor?.specialization ?? ""
                contact = doctor?.contact ?? ""
                location = doctor?.location ?? ""
            }
        }
    }
    
    private func updateDetails() {
        doctor?.name = name
        doctor?.mailId = mailId
        doctor?.password = password
        doctor?.specialization = specialization
        doctor?.contact = contact
        doctor?.location = location
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to update details: \(error.localizedDescription)")
            }
        }
    }
    
}

// struct EditDoctorDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDoctorDetailView()
//    }
// }
