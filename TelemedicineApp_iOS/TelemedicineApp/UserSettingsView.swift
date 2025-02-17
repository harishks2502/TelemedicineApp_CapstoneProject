//
//  UserSettingsView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct UserSettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    @State private var isShowingEditDoctor = false
    @State private var doctor: Doctor?
    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("Doctor Details")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    Text("Name: \(doctor?.name ?? "No Name")")
                        .font(.system(size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Email: \(doctor?.mailId ?? "No Email")")
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Specialization: \(doctor?.specialization ?? "Unknown")")
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Contact No.: \(doctor?.contact ?? "No Data")")
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Hospital Location: \(doctor?.location ?? "No Data")")
                        .font(.system(size: 20))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Delete Account") {
                            deleteAccount()
                        }
                        .font(.system(size: 20))
                        .padding(.vertical, 5)
                        .buttonStyle(.bordered)
                        
                        Spacer()
                        
                        Button("Edit Details") {
                            isShowingEditDoctor = true
                        }
                        .font(.system(size: 20))
                        .padding(.vertical, 5)
                        .buttonStyle(.bordered)
                        
                        Spacer()
                    }
                }
                
                Section {
                    Button("Logout") {
                        logout()
                    }
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .padding(.vertical, 5)
                    .buttonStyle(.bordered)
                }
                
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .sheet(isPresented: $isShowingEditDoctor) {
                EditDoctorDetailView(doctor: $doctor)
            }
            .onAppear {
                fetchDoctorDetails()
            }
        }
    }
    
    private func deleteAccount() {
        guard let doctor = doctor else { return }
        
        viewContext.delete(doctor)
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                isAuthenticated = false
            } catch {
                print("Failed to delete account: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func fetchDoctorDetails() {
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        
        DispatchQueue.main.async {
            do {
                let doctors = try viewContext.fetch(fetchRequest)
                doctor = doctors.first
            } catch {
                print("Failed to fetch doctor: \(error)")
            }
        }
        
    }
    
    private func logout() {
        isAuthenticated = false
    }
    
}


struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
