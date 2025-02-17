//
//  AddSlotView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct AddSlotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var slotTime: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Add Slot")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter Slot Time", text: $slotTime)
                        .font(.system(size: 18))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save Slot") {
                            saveSlot()
                        }
                        .disabled(slotTime.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Add New Slot", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add New Slot")
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
        }
    }
    
    private func saveSlot() {
        guard !slotTime.isEmpty else { return }
        
        let newSlot = Slots(context: viewContext)
        newSlot.slotTime = slotTime
        newSlot.date = date
        newSlot.id = UUID()
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to save slot: \(error.localizedDescription)")
            }
        }
    }
}

// struct AddSlotView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSlotView()
//    }
// }
