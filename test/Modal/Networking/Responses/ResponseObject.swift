//
//  ObjectInfo.swift
//  testing
//
//  Created by Antarpunit Singh on 2012-08-05.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation

//Mark -Data object
struct DataObject:Codable {
    
    var images: ImageType
}

//Mark- MetaObject
struct MetaObject:Codable {
    
    var status:Int32
    var msg:String
    var response: String
    
    enum CodingKeys : String,CodingKey{
        
        case status
        case msg
        case response = "response_id"
        
    }
}
struct ImageType:Codable {
    var fixed: SizeData
    
    enum CodingKeys: String ,CodingKey{
        case fixed = "fixed_height_small"
    }
}
struct SizeData:Codable {
    var url:String
    var size:String
}

