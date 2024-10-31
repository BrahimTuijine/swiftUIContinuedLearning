//
//  PhotoModel.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photoModel = try? JSONDecoder().decode(PhotoModel.self, from: jsonData)

// MARK: - PhotoModel
struct PhotoModel: Identifiable, Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
