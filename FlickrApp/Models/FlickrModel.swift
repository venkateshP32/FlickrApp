//
//  FlickrModel.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//

import Foundation

struct FlickerResults: Codable {
    let items:[FlickerItem]?
}

struct FlickerItem: Codable {
    let  title: String?
    let  description: String?
    let  link: String?
    let  media: ImageDetails?
    
    enum CodingKeys: String, CodingKey {
           case title, description, link, media
       }
    
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)

            title = try values.decode(String.self, forKey: .title)
            description = try values.decode(String.self, forKey: .description)
            link = try values.decode(String.self, forKey: .link)
            media = try values.decode(ImageDetails.self, forKey: .media)
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)

           try container.encode(title, forKey: .title)
           try container.encode(description, forKey: .description)
           try container.encode(link, forKey: .link)
       }
}

struct ImageDetails: Codable {
    let imageLink: String?
    
    enum CodingKeys: String, CodingKey {
           case m
       }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        imageLink = try values.decode(String.self, forKey: .m)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(imageLink, forKey: .m)
    }
}
