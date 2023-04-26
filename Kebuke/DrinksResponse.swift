//
//  DrinksResponse.swift
//  Kebuke
//
//  Created by NAI LUN CHEN on 2023/4/26.
//

import Foundation

struct DrinksResponse: Codable {
    let records: [Record]
    
    struct Record: Codable {
        let id: String
        //let createdTime: Date
        let fields: Field
    }
    
    struct Field: Codable {
        let description: String
        let mediumPrice: Int
        let introduction: String
        let name: String
        let type: String
        let largePrice: Int?
        let image: [DrinkImage]
    }
    
    struct DrinkImage: Codable {
        let id: String
        let width: Int
        let height: Int
        let url: URL
        let filename: String
        let size: Int
        let type: String
        let thumbnails: Thumbnails
    }
    
    struct Thumbnails: Codable {
        let small: ThumbnailsAttributes
        let large: ThumbnailsAttributes
        let full: ThumbnailsAttributes
    }
    
    struct ThumbnailsAttributes: Codable {
        let url: URL
        let width: Int
        let height: Int
        
    }
}
