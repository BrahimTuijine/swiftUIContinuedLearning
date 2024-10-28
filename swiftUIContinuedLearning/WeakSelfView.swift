//
//  WeakSelfView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

struct WeakSelfView: View {
    
    @AppStorage("count") var count : Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondView()
                
            }.navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            
            , alignment: .topTrailing)
    }
}

struct WeakSelfSecondView: View {
        
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("SecondView")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("deinit now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount - 1, forKey: "count")
    }
    
    func getData()  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "new data !!!"
        }
    }
}

#Preview {
    WeakSelfView()
}
