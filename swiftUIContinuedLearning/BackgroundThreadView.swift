//
//  BackgroundThreadView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() -> Void {
        DispatchQueue.global(qos: .background).async {
            let data = self.downloadData()
            
            print(Thread.isMainThread)
            print(Thread.current)
            
            DispatchQueue.main.async {
                self.dataArray = data
                print(Thread.isMainThread)
                print(Thread.current)
            }
        }
        
    }
    
    private func downloadData() -> [String] {
        var data : [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
}

struct BackgroundThreadView: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 20) {
                Text("Load data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadView()
}
