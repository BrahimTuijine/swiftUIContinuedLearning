//
//  CoreDataView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 24/10/2024.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    static let shared : CoreDataViewModel = CoreDataViewModel()
    
    @Published var fruits: [FruitsEntity] = []
    
    
    let container: NSPersistentContainer
    
    
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading core data \(error.localizedDescription)")
            } else {
                print ("Successfully loaded core data!")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits() -> Void {
        let request = NSFetchRequest<FruitsEntity>(entityName: "FruitsEntity")
        
        do {
            fruits = try container.viewContext.fetch(request)
        } catch {
            print("error during fetch data \(error)")
        }
    }
    
    func addFruit(fruitTitle : String) -> Void {
        let fruit = FruitsEntity(context: container.viewContext)
        fruit.name = fruitTitle
        saveFruit()
    }
    
    func deleteFruit(indexSet: IndexSet) -> Void {
        guard let index = indexSet.first else {return}
        let entity = fruits[index]
        container.viewContext.delete(entity)
        saveFruit()
    }
    
    func updateFruit(fruit: FruitsEntity) -> Void {
        let oldName = fruit.name ?? ""
        let newName = oldName + " updated"
        fruit.name = newName
        saveFruit()
    }
    
    private func saveFruit() -> Void {
        do {
           try container.viewContext.save()
            fetchFruits()
        } catch {
            print("error when save fruit \(error)")
        }
    }
    
}

struct CoreDataView: View {
    
    @StateObject private var vm : CoreDataViewModel = CoreDataViewModel()
    @State var textField : String = ""
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20){
                
                TextField("add fruit name here...", text: $textField)
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    
                
                Button("Save fruit") {
                    guard !textField.isEmpty && !(textField.count < 3) else {return}
                    vm.addFruit(fruitTitle: textField)
                    textField = ""
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(.pink)
                .cornerRadius(10)
                

                List {
                    ForEach(vm.fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(fruit: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Fruits")
        }
        .padding()
        
    }
}

#Preview {
    CoreDataView()
}
