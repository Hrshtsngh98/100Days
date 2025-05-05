//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/30/25.
//

import CodeScanner
import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    
    enum SortType: String, CaseIterable {
        case ascendingName = "Name A to Z"
        case descendingName = "Name Z to A"
        case emailAscending = "Email A to Z"
        case emailDescending = "Email Z to A"
    }
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    @Binding var sortType: SortType
    @State private var isShowingScanner = false
    @State private var showSortSheet = false
    @State private var selectedProspects = Set<Prospect>()
    
    init(filter: FilterType, sortType: Binding<SortType> = .constant(.ascendingName)) {
        self.filter = filter
        self._sortType = sortType
        if filter == .none {
            switch sortType.wrappedValue {
            case .ascendingName:
                self._prospects = Query(filter: #Predicate { _ in
                    true
                }, sort: \.name)
            case .descendingName:
                self._prospects = Query(filter: #Predicate { _ in
                    true
                }, sort: \.name, order: .reverse)
            case .emailAscending:
                self._prospects = Query(filter: #Predicate { _ in
                    true
                }, sort: \.emailAddress)
            case .emailDescending:
                self._prospects = Query(filter: #Predicate { _ in
                    true
                }, sort: \.emailAddress, order: .reverse)
            }
        } else {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    let contactedImage = "person.crop.circle.fill.badge.checkmark"
    let uncontactedImage = "person.crop.circle.badge.xmark"
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProspects) { prospect in
                NavigationLink {
                    EditProspectView(prospect: prospect)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        if filter == .none {
                            Image(systemName: prospect.isContacted ? contactedImage : uncontactedImage)
                                .foregroundStyle(prospect.isContacted ? .green : .red)
                        }
                    }
                    .tag(prospect)
                }
                .swipeActions(edge: .trailing) {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: uncontactedImage) {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: contactedImage) {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(SortType.allCases, id: \.self) { sortType in
                            Button {
                                self.sortType = sortType
                            } label: {
                                Text(sortType.rawValue)
                            }
                            
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                VStack {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Harshit Singh\nharshit.singh@example.com", completion: handleScan)
                    CodeScannerView(codeTypes: [.qr], simulatedData: "AAA\nXXXX@example.com", completion: handleScan)
                    CodeScannerView(codeTypes: [.qr], simulatedData: "BBB\nCCCC@example.com", completion: handleScan)
                    CodeScannerView(codeTypes: [.qr], simulatedData: "CCC\nBBBB@example.com", completion: handleScan)
                    CodeScannerView(codeTypes: [.qr], simulatedData: "DDDD\nMMMM@example.com", completion: handleScan)
                }
            }
            
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // For testing in 5 seconds
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
