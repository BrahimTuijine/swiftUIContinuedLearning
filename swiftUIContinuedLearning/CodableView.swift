//
//  CodableView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

struct CustomerModel : Hashable, Codable {
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init () {
        getData()
    }
    
    func getData() -> Void {
        guard let data = getJsonData() else {return}
        
        if
            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionary = localData as? [String: Any],
            let name = dictionary["name"] as? String,
            let points = dictionary["points"] as? Int,
            let isPremium = dictionary["isPremium"] as? Bool {
            
            customer = CustomerModel(name: name, points: points, isPremium: isPremium)
        }
    }
    
    func getJsonData() -> Data?  {
        let dictinary: [String: Any] = [
            "name": "brahim",
            "points": 10,
            "isPremium": true,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictinary, options: [])
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
