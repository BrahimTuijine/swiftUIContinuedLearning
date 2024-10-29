//
//  TimerView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 29/10/2024.
//

import SwiftUI

struct TimerView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    // current time
    /*  @State var currentDate : Date = Date()
     
     var dateFormatter : DateFormatter {
     let formatter = DateFormatter()
     formatter.dateStyle = .medium
     formatter.timeStyle = .medium
     return formatter
     }
     */
    // count down 
        @State var count: Int = 10
        @State var finishedText: String? = nil

    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(.purple) , Color(.blue)]),
                center: .center,
                startRadius: 5,
                endRadius: 500
            )
            
            Text(finishedText ?? "\(count)")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding()
            
        }
        .onReceive(timer, perform: { _ in
            if count <= 1 {
                finishedText = "Wow !"
            } else {
                count -= 1
            }
        })
        
        .ignoresSafeArea()
    }
}

#Preview {
    TimerView()
}
