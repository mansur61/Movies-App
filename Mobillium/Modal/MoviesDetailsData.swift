//
//  MoviesDetailsData.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
// GET movie/{movie_id}
struct MoviesDetailsData:Codable {
    
    let backdrop_path:String
    let id:Int
    let imdb_id:String
    let original_title:String
    let overview:String
    let popularity:Float
    let poster_path:String
    let release_date:String
    let tagline:String
    let title:String
    let vote_average:Float
    let vote_count:Int


    enum CodingKeys: String, CodingKey {
       
       case backdrop_path = "backdrop_path"
       case id = "id"
       case imdb_id = "imdb_id"
       case original_title = "original_title"
       case overview = "overview"
       case popularity = "popularity"
       case poster_path = "poster_path"
       case release_date = "release_date"
       case tagline = "tagline"
       case title = "title"
       case vote_average = "vote_average"
       case vote_count = "vote_count"

    }
}
