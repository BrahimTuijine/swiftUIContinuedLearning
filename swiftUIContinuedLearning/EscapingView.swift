//
//  EscapingView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI

fileprivate class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData()  -> Void {
        downloadData5 { [weak self] returnedData in
            self?.text = returnedData.data
        }
    }
    
    func downloadData() -> String {
        return "New data !"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void)  {
        completionHandler("new data !")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> () )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("new data !")
        }
    }
    
    func downloadData4 (completionHandler: @escaping (DownloadResult) -> () )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "new data !")
            completionHandler(result)
        }
    }
    
    func downloadData5 (completionHandler: @escaping DownloadCompletion )  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "new data !")
            completionHandler(result)
        }
    }
}

fileprivate struct DownloadResult {
    let data: String
}

fileprivate typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingView: View {
    
    @StateObject fileprivate var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingView()
}
