//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Harshit Singh on 5/5/25.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String
    @State var email: String
    var backupProspect: Prospect
    
    init(prospect: Prospect) {
        self.email = prospect.emailAddress
        self.name = prospect.name
        self.backupProspect = prospect
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Name:")
                    TextField("Name", text: $name)
                }
                
                HStack {
                    Text("Email:")
                    TextField("Email", text: $email)
                }
                
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    modelContext.delete(backupProspect)
                    modelContext.insert(Prospect(name: name, emailAddress: email, isContacted: backupProspect.isContacted))
                    dismiss()
                }
            }
        }
        .navigationTitle("Update Prospect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

#Preview {
    EditProspectView(prospect: .init(name: "", emailAddress: "", isContacted: false))
}
