//
//  TrailerResponse.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import Foundation
struct TrailerResponse: Codable
{
    let results: [Trailer]
}

struct Trailer: Codable
{
    let id: String
    let key: String // YouTube video ID
    let name: String
    let site: String // Should be "YouTube"
    let type: String // Trailer, Teaser, etc.
}
