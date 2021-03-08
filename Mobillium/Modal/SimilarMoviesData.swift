//
//  SimiilarMoviesData.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
// https://api.themoviedb.org/3/movie/{movie_id}/similar?api_key=063da539b9dcfd75e3f3107755d9936a
// GET movie/{movie_id}\similar
struct SimilarMoviesData:Codable {
    let results:[SimiilarResults]
}
struct SimiilarResults :Codable{
    
    let original_title:String
    let poster_path:String
    let vote_average:Float
    let overview:String
    let id:Int
    let vote_count:Int
    let title:String
    let backdrop_path:String
    let release_date:String
    let popularity:Float
    
    enum CodingKeys: String, CodingKey {
        
        case original_title = "original_title"
        case poster_path = "poster_path"
        case vote_average = "vote_average"
        case overview = "overview"
        case id = "id"
        case vote_count = "vote_count"
        case title = "title"
        case backdrop_path = "backdrop_path"
        case release_date = "release_date"
        case popularity = "popularity"
           
    }
}
