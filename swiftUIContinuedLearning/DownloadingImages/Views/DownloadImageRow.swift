//
//  DownloadImageRow.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import SwiftUI

struct DownloadImageRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            ImageView(imageLink: model.url).frame(width: 70, height: 70)
            VStack (alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#Preview {
    DownloadImageRow(model: PhotoModel(albumID: 1, id: 1, title: "title", url:"https://via.placeholder.com/150/771796", thumbnailURL: "thumbnailURL"))
        
}
