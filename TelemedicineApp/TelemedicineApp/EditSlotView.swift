//
//  EditSlotView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct EditSlotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var slot: Slots
    
    @State private var slotTime: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("Slot Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Edit slot time", text: $slotTime)
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
                        
                        Button("Update Slot") {
                            updateSlot()
                        }
                        .disabled(slotTime.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Edit Slot", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Slot")
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
            .onAppear{
                slotTime = slot.slotTime ?? ""
                date = slot.date ?? Date()
            }
        }
    }
    
    private func updateSlot() {
        slot.slotTime = slotTime
        slot.date = date
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to update slot: \(error.localizedDescription)")
            }
        }
    }
}


// struct EditSlotView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSlotView()
//    }
// }
