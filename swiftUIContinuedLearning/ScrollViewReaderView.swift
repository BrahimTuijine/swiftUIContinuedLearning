//
//  ScrollViewReaderView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 22/10/2024.
//

import SwiftUI

struct ScrollViewReaderView: View {
    
    @State var scrollTo : Int = 0
    
    @State var textFieldText : String = "";
    
    var body: some View {
        VStack {
            
            TextField("enter item number", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .border(Color.black)
                .padding()
                .padding(.horizontal)
                
                
            
            Button("PRESS HETO TO GO TO $\(scrollTo)") {
                if let index = Int(textFieldText) {
                    scrollTo = index
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(Color.black.cornerRadius(10))
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("this is item $\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.cornerRadius(10))
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollTo) {
                        withAnimation(.spring()) {
                            proxy.scrollTo(
                                scrollTo,
                                anchor: .center
                            )
                        }
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderView()
}
