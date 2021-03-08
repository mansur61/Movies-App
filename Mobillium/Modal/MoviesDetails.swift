//
//  MoviesDetails.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
import Alamofire

protocol MoviesDeatilsDelegate {
    func GetMoviesDetails(moviesDataDetails:MoviesDetailsData)
}
extension MoviesDeatilsDelegate{
    func GetMoviesDetails(moviesDataDetails:MoviesDetailsData){}
}

class MoviesDetails: NSObject {
    
    var delegate: MoviesDeatilsDelegate?
    
    func getMoviesDetails(movie_id:Int){
        
        let url:String = "https://api.themoviedb.org/3/movie/\(movie_id)?api_key=063da539b9dcfd75e3f3107755d9936a"
        print("url ->\(url)")
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { (responseData) in
            //print("We got the response")
            print(responseData.result)
            guard let data = responseData.data else{return}
            
               do{
                   
                   let getMoviesDetailLists = try JSONDecoder().decode(MoviesDetailsData.self, from: data)
                    //print("ula veriii :",getMoviesDetailLists)
                 
                self.delegate?.GetMoviesDetails(moviesDataDetails:getMoviesDetailLists)
            
               }catch{
                print("Api verileri ile uyuşmazlık olmuş olabilir..")
               }
        }
    }
}
