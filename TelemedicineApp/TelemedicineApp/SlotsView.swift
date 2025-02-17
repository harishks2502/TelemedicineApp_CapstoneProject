//
//  SlotsView.swift
//  TelemedicineApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct SlotsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Slots.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Slots.date, ascending: false)]
    ) private var slots: FetchedResults<Slots>
    
    @State private var isShowingAddSlot = false
    @State private var isShowingEditSlot = false
    @State private var selectedSlot: Slots?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(slots) { slot in
                    HStack {
                        NavigationLink(destination: PatientListView(slot: slot)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(slot.slotTime ?? "Unnamed")
                                    .padding(.top, 10)
                                    .padding(.bottom, 5)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("\(slot.date ?? Date(), formatter: slotDateFormatter)")
                                    .font(.system(size: 20))
                            }
                        }
                        Spacer()
                        
                        Button(action: {
                            selectedSlot = slot
                            isShowingEditSlot = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                                .font(.system(size: 30))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .onDelete(perform: deleteSlot)
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Slots")
                        .font(.title.bold())
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddSlot = true}) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSlot) {
                AddSlotView()
            }
            .sheet(item: $selectedSlot) { slot in
                EditSlotView(slot: slot)
            }
        }
    }
    
    private let slotDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        return formatter
    } ()
    
    private func deleteSlot(at offsets: IndexSet) {
        for index in offsets {
            let slot = slots[index]
            viewContext.delete(slot)
        }
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Error deleting slot: \(error.localizedDescription)")
            }
        }
    }
    
}

// struct SlotsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlotsView()
//    }
// }
