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
    
    init() {
        getBusiness()
    }
    
    func addBusiness(name: String) -> Void {
        let entity = BusinessEntity(context: manager.context)
        entity.name = name
        manager.save()
    }
    
    func getBusiness() -> Void {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
    
        do {
            business = try manager.context.fetch(request)
        } catch {
            print("error when get business list \(error)")
        }
    }
    
    
}

struct CoreDataRelationshipsView: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack (spacing: 20) {
                    
                    Button(action: {
                        vm.addBusiness(name: "Cars")
                    }, label: {
                        Text("Perform action")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    
                }
                .padding()
                .navigationTitle("RelationShips")
            }
        }
        
    }
}

#Preview {
    CoreDataRelationshipsView()
}
