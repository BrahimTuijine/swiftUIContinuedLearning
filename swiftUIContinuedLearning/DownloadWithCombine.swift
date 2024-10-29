//
//  DownloadWithCombine.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 29/10/2024.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts : [PostModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    
    func getData() -> Void {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self]  posts in
                self?.posts = posts
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
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
    DownloadWithCombine()
}
