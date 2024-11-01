//
//  VisualEffectView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 02/11/2024.
//

import SwiftUI

struct VisualEffectView: View {
    @State var width: Double = 100
    
    var body: some View {
        Text("Hello world")
            .frame(width: width)
            .padding()
            .background(.red)
            .visualEffect { content, geometryProxy in
                content.grayscale(geometryProxy.size.width >= 200 ? 1 : 0)
            }
            .onTapGesture {
                withAnimation {
                    if width == 300 {
                        width = 100
                    } else {
                        width = 300
                    }
                }
            }

            
    }
}

#Preview {
    VisualEffectView()
}
