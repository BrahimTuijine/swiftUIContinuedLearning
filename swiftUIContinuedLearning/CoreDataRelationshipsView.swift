//
//  CoreDataRelationshipsView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 25/10/2024.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { descripton, error in
            if let error = error {
                print("error loading data \(error.localizedDescription)")
            } else {
                print("load data success")
            }
        }
        context = container.viewContext
    }
    
    func save() -> Void {
        do {
            try context.save()
        } catch {
            print("error when save data \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    let manager : CoreDataManager = CoreDataManager.instance

    @Published var business : [BusinessEntity] = []
    
    func addBusiness(name: String) -> Void {
        let entity = BusinessEntity(context: manager.context)
        entity.name = name
        manager.save()
    }
}

struct CoreDataRelationshipsView: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataRelationshipsView()
}
