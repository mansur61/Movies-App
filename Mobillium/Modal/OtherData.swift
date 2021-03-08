//
//  OtherData.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation

import Alamofire

protocol OtherMoviesDelegate {
    func GetOtherDataMovies(otherData:OtherListData)
}
extension OtherMoviesDelegate{
    func GetOtherDataMovies(otherData:OtherListData){}
}

class OtherData: NSObject {
    
    var delegate: OtherMoviesDelegate?
    
    func getOtherData(){
        
        let url:String = "https://api.themoviedb.org/3/movie/upcoming?api_key=063da539b9dcfd75e3f3107755d9936a"
                
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { (responseData) in
            
            guard let data = responseData.data else{return}
            
               do{
                   
                   let getOhersData = try JSONDecoder().decode(OtherListData.self, from: data)
                  
                self.delegate?.GetOtherDataMovies(otherData:getOhersData)
            
               }catch{
                print("Api verileri ile uyuşmazlık olmuş olabilir..")
               }
        }
    }
}
