//
//  MultipleSheetView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 22/10/2024.
//

import SwiftUI

struct RandomModel : Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
}

struct NextView : View {
    let randomModel : RandomModel
    
    var body: some View {
        Text(randomModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetView: View {
    @State var randomModel : RandomModel? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                
                ForEach(0..<50) { index in
                    Button("button \(index)") {
                        randomModel =  RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $randomModel) { model in
                NextView(randomModel: model)
            }
        }
    }
}

#Preview {
    MultipleSheetView()
}
