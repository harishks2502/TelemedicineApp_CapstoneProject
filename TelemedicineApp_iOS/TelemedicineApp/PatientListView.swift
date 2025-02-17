//
//  PatientListView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let contactNumber: String
    let healthIssue: String
}

struct PatientListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var slot: Slots
    
    let patients = [
        Patient(name: "Raghu", contactNumber: "7894561239", healthIssue: "Sudden Severe Heart Pain"),
        Patient(name: "Poornima", contactNumber: "9874561235", healthIssue: "High Blood Pressure"),
        Patient(name: "Santhosh", contactNumber: "8794561356", healthIssue: "Heart Valve Disease"),
        Patient(name: "Pradeep", contactNumber: "7856412398", healthIssue: "Coronary Artery Disease")
    ]
    
    var body: some View {
        VStack{
            List {
                ForEach(patients) { patient in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name: \(patient.name)")
                            .font(.system(size: 18))
                            .padding(.vertical, 3)
                        
                        Text("Contact: \(patient.contactNumber)")
                            .font(.system(size: 18))
                            .padding(.vertical, 4)
                        
                        Text("Health Issue: \(patient.healthIssue)")
                            .font(.system(size: 20))
                            .padding(.vertical, 4)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Patients Appointment Details")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}


// struct PatientListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientListView()
//    }
// }
