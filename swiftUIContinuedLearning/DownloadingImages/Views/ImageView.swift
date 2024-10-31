//
//  ImageView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import SwiftUI

struct ImageView: View {
    
    let imageLink: String
    
    @StateObject var loader : ImageLoadingViewModel
    
    init(imageLink: String) {
        self.imageLink = imageLink
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(imageLink: imageLink))
    }
    
    var body: some View {
        if loader.isLoading  {
            ProgressView()
        } else if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .clipShape(Circle())
        }
    }
}

#Preview {
    ImageView(imageLink: "https://via.placeholder.com/150/771796")
}
