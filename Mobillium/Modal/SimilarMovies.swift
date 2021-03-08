//
//  SimiliarMovies.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
import  Alamofire

protocol SimilarMoviesDelegate {
    func GetSimiliarMovies(similiarMovData:SimilarMoviesData)
}
extension SimilarMoviesDelegate{
    func GetSimiliarMovies(similiarMovData:SimilarMoviesData){}
}

class  SimilarMovies: NSObject {
    
    var delegate: SimilarMoviesDelegate?
    
    func getSimiliar(movie_id:Int){
        print("SİMİLAR KISMI")
        let url = "https://api.themoviedb.org/3/movie/\(movie_id)/similar?api_key=063da539b9dcfd75e3f3107755d9936a"
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { (responseData) in
            //print("We got the response")
            print(responseData.result)
            guard let data = responseData.data else{return}
            
               do{
                   
                   let getMoviesData = try JSONDecoder().decode(SimilarMoviesData.self, from: data)
                    //print("ula veriii :",getMoviesData)
                 
                self.delegate?.GetSimiliarMovies(similiarMovData:getMoviesData)
            
               }catch{
                print("Api verileri ile uyuşmazlık olmuş olabilir..")
               }
        }
    }
}
