//
//  HashableView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 23/10/2024.
//

import SwiftUI

struct MyCustomModel: Hashable {
    
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    let data: [MyCustomModel] = [
        MyCustomModel(title: "one") ,
        MyCustomModel(title: "two") ,
        MyCustomModel(title: "three") ,
        MyCustomModel(title: "four") ,
        MyCustomModel(title: "five") ,
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { value in
                    Text("\(value.hashValue)")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableView()
}
