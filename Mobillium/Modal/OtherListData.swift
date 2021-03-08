//
//  OtherListData.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
// https://api.themoviedb.org/3/movie/upcoming?api_key=063da539b9dcfd75e3f3107755d9936a
//GET movie/upcoming
struct OtherListData:Codable  {
    
    let results:[OtherResults]
}

struct  OtherResults: Codable {
    
    let backdrop_path:String
    let id:Int
    let original_title:String
    let overview:String
    let poster_path:String
    let release_date:String
    let title:String
    let vote_average:Float
    let vote_count:Int
    
    
    enum CodingKeys: String, CodingKey {
        
        case backdrop_path = "backdrop_path"
        case id = "id"
        case original_title = "original_title"
        case overview = "overview"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
     
}
