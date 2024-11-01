//
//  AlignmentGuideView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 01/11/2024.
//

//https://swiftui-lab.com/alignment-guides/

import SwiftUI

struct AlignmentGuideView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
                .background(.blue)
                .alignmentGuide(.leading, computeValue: { dimension in
                    return dimension.width * 0.5
                })
            
            Text("this is some other text!")
                .background(.red)
        }
        .background(.orange )
    }
}

struct AlignmentChildView: View {
    
    private func row(title: String , showIcon: Bool = false) -> some View {
        return HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
        .alignmentGuide(.leading, computeValue: { dimension in
            return showIcon ? 40 : 0
        })
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            row(title: "Row 1")
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3")
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(40)
    }
}

#Preview {
    AlignmentChildView()
}

#Preview {
    AlignmentGuideView()
}
