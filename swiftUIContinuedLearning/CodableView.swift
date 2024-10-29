//
//  CodableView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

struct CustomerModel : Codable {
    let name: String
    let points: Int
    let isPremium: Bool
    
//    init(name: String, points: Int, isPremium: Bool) {
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    enum CodingKeys: CodingKey {
//        case name
//        case points
//        case isPremium
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init () {
        getData()
    }
    
    func getData() -> Void {
        guard let data = getJsonData() else {return}
        
        do {
            customer = try JSONDecoder().decode( CustomerModel.self , from: data)
        } catch {
            print("error when docode json \(error)")
        }
    }
    
    func getJsonData() -> Data?  {
        let customer = CustomerModel(name: "brahim", points: 20, isPremium: true) 
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
}

struct CodableView: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customers = vm.customer {
                Text(customers.name)
                Text("\(customers.points)")
                Text(customers.isPremium.description)
            }
        }
    }
}

#Preview {
    CodableView()
}
