//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/25/22.
//

import Foundation

struct YoutubeSearchResponse: Codable  {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
