//
//  ImageView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import SwiftUI

struct ImageView: View {
    
    @State var isLoading : Bool = true
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            
        }
    }
}

#Preview {
    ImageView()
}
