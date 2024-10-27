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
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmpolyeeEntity] = []
    
    init() {
        getBusiness()
        getEmployees()
        getDepartments()
    }
    
    func addBusiness() -> Void {
        let entity = BusinessEntity(context: manager.context)
        entity.name = "Apple"
        save()
    }
    
    func getBusiness() -> Void {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
    
        do {
            business = try manager.context.fetch(request)
        } catch {
            print("error when get business list \(error.localizedDescription)")
        }
    }
    
    func addDepartment() -> Void {
        let department = DepartmentEntity(context: manager.context)
        department.name = "Marketing"
        department.businesses = [business[0]]
        save()
    }
    
    func getDepartments() -> Void {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("error when get departments \(error.localizedDescription)")
        }
    }
    
    func addEmployee() -> Void {
        let employee = EmpolyeeEntity(context: manager.context)
        employee.name = "Bilel"
        employee.age = 99
        employee.dateJoined = Date()
//        employee.department = departments[0]
//        employee.business = business[0]
        
        save()
    }
    
    func getEmployees() -> Void {
        let request = NSFetchRequest<EmpolyeeEntity>(entityName: "EmpolyeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("error when get employees \(error.localizedDescription)")
        }
    }
    
    
    
    func save() -> Void {
        business.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusiness()
            self.getDepartments()
            self.getEmployees()
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
                        vm.addEmployee()
                    }, label: {
                        Text("Perform action")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(vm.business) {
                                BusinessView(business: $0)
                            }
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(vm.departments) {
                                DepartmentView(department: $0)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(vm.employees) {
                                EmployeeView(employee: $0)
                            }
                        }
                    }
                    
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

struct BusinessView: View {
    
    let business: BusinessEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
            Text("Name: \(business.name ?? "")").bold()
            
            if let departments = business.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments :").bold()
                
                ForEach(departments) {
                    
                    Text($0.name ?? "")
                }
            }
            
            if let employees = business.employees?.allObjects as? [EmpolyeeEntity] {
                Text("Employees :").bold()
                
                ForEach(employees) {
                    
                    Text($0.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5).cornerRadius(10))
        .shadow(radius: 10)
         
    }
}

struct DepartmentView: View {
    
    let department: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
            Text("Name: \(department.name ?? "")").bold()
            
            if let businesess = department.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesess :").bold()
                
                ForEach(businesess) {
                    
                    Text($0.name ?? "")
                }
            }
            
            if let employees = department.employees?.allObjects as? [EmpolyeeEntity] {
                Text("Employees :").bold()
                
                ForEach(employees) {
                    
                    Text($0.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5).cornerRadius(10))
        .shadow(radius: 10)
         
    }
}

struct EmployeeView: View {
    
    let employee: EmpolyeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
            Text("Name: \(employee.name ?? "")").bold()
            
            Text("Age: \(employee.age)").bold()
            
            Text("Date Joined: \(employee.dateJoined ?? Date())").bold()
            
            Text("Business: ").bold()
            
            Text(employee.business?.name ?? "")
            
            
            Text("Department: ").bold()
            
            Text(employee.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
         
    }
}


