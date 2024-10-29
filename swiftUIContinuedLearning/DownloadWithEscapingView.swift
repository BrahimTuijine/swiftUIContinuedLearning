//
//  DownloadWithEscapingView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 28/10/2024.
//

import SwiftUI


struct Post: Identifiable, Codable {
    let userId, id: Int
    let title, body: String
}

typealias downloadDataHandler = (_ data: Data , _ statusCode : Int, _ error: String?) -> ()

class DownloadWithEscapingViewModel: ObservableObject {
    
    
    @Published var posts : [Post] = []
    
    init() {
        getData()
    }
    
    
    func getData() -> Void {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(url: url) { data, statusCode, error in
            guard error == nil else { print(error!); return}
            
            guard let decodedPosts = try? JSONDecoder().decode([Post].self, from: data) else {return}
            
            DispatchQueue.main.async { [weak self] in
                print(decodedPosts)
                self?.posts = decodedPosts
            }
        }
    }
    
    func downloadData(url: URL , handler: @escaping downloadDataHandler) {
     
        URLSession.shared.dataTask(with: url) {  data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                
                print("Error downloading Data")
                return
            }
            
            handler(data, response.statusCode, error?.localizedDescription)
            
        }.resume()
    }
}

struct DownloadWithEscapingView: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.title).font(.headline)
                    Text(post.body).foregroundColor(.gray)
                    
                }
            }
        }
    }
}

#Preview {
    DownloadWithEscapingView()
}
