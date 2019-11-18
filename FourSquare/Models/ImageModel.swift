//
//  Image.swift
//  FourSquare
//
//  Created by Kimball Yang on 11/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
    let response: Photos
}
struct Photos: Codable{
    let photos: Items
}
struct Items: Codable {
    let items: [ImageInfo]
}
struct ImageInfo: Codable{
    let prefix: String
    let suffix: String
    var imageInfo: String {
        return "\(prefix)original\(suffix)"
    }
}
