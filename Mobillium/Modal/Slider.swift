//
//  Slider.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
import Alamofire

protocol SliderMoviesDelegate {
    func GetSliderMovies(sliderMovData:SliderListData)
}
extension SliderMoviesDelegate{
    func GetSliderMovies(sliderMovData:SliderListData){}
}

class Slider: NSObject {
    
    var delegate: SliderMoviesDelegate?
    
    func getSlider(){
        let url:String = "https://api.themoviedb.org/3/movie/now_playing?api_key=063da539b9dcfd75e3f3107755d9936a"
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { (responseData) in
            
            guard let data = responseData.data else{return}
            
               do{
                   let getSlider = try JSONDecoder().decode(SliderListData.self, from: data)
                print("getSlider")
                self.delegate?.GetSliderMovies(sliderMovData: getSlider)
            
               }catch{
                    print("Api verileri ile uyuşmazlık olmuş olabilir..")
               }
            
        }
        
    }
    
}
