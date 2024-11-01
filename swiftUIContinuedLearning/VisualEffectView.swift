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
        
        ScrollView {
            
            VStack(spacing: 20) {
                ForEach(0..<100) { value in
                    Rectangle()
                        .frame(width: 300, height: 300)
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                        .visualEffect { content, geometry in
                            content.offset(x: geometry.frame(in: .global).minY * 0.5)
                        }
                }
            }
            
        }
//        Text("Hello world")
//            .frame(width: width)
//            .padding()
//            .background(.red)
//            .visualEffect { content, geometryProxy in
//                content.grayscale(geometryProxy.size.width >= 200 ? 1 : 0)
//            }
//            .onTapGesture {
//                withAnimation {
//                    if width == 300 {
//                        width = 100
//                    } else {
//                        width = 300
//                    }
//                }
//            }
    
    }
}

#Preview {
    VisualEffectView()
}
