//
//  MaskView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 22/10/2024.
//

import SwiftUI

struct MaskView: View {
    
    @State var rating : Int = 0
    var body: some View {
        ZStack {
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView : some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: (geometry.size.width / 5) * CGFloat(rating))
                
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor( .gray)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                rating = index + 1
                            }
                        }
                }
            }
        
    }
}

#Preview {
    MaskView()
}


