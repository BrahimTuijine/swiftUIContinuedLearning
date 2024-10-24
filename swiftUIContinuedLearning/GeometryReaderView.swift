//
//  GeometryReaderView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 22/10/2024.
//

import SwiftUI

struct GeometryReaderView: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
            
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<50) { value in
                    GeometryReader { gemetry in
                        Rectangle()
                            .cornerRadius(10)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: gemetry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                        .padding()
                }
            }
        }
        
//        GeometryReader { geometry in
//            HStack(spacing:  0){
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle().fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    GeometryReaderView()
}
