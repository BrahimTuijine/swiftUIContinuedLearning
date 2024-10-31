//
//  DownloadingImageView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var vm = PhotoModelViewModel.instance
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(vm.photoModel) { model in
                        
                    }
                }
                
               
            } .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImageView()
}
