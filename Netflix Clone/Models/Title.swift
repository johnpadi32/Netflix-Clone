//
//  Movie.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/18/22.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let title: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let realease_date: String?
    let vote_average: Double
}

