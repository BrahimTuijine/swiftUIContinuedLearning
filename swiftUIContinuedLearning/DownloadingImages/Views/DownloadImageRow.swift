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
            Circle().frame(width: 70, height: 70)
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
    DownloadImageRow(model: PhotoModel(albumID: 1, id: 1, title: "title", url:"url image", thumbnailURL: "thumbnailURL"))
        
}
