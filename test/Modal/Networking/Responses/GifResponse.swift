//
//  ImageResponse.swift
//  testing
//
//  Created by Antarpunit Singh on 2012-08-05.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
struct GifResponse: Codable {
    var data: [DataObject]
    var meta: MetaObject
}
struct SingleGifResponse:Codable {
    var data: DataObject
    var meta: MetaObject
}
