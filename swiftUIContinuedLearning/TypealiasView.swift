//
//  TypealiasView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel


struct TypealiasView: View {
        
//    @State var item: MovieModel = MovieModel(title: "Title", director: "Brahim", count: 5)
    
    @State var item: TVModel = TVModel(title: "Title", director: "Bilel", count: 10)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasView()
}
