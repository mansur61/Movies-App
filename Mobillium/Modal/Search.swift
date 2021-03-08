//
//  Search.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
import  Alamofire

protocol SearchMoviesDelegate {
    func GetSearchMoviesName(searchData:SearchData)
}
extension SearchMoviesDelegate{
    func GetSearchMoviesName(searchData:SearchData){}
}

class  Search: NSObject {
    
    var delegate: SearchMoviesDelegate?
    
    func getSearch(query:String){
        
      
        if query != "" || query != " "{
            let url:String = "https://api.themoviedb.org/3/search/movie?api_key=063da539b9dcfd75e3f3107755d9936a&query=\(query)"
            print("url -> \(url)")
            
            /*   let params =
                                  [
                                      "api_key":"063da539b9dcfd75e3f3107755d9936a",
                                      "query":"\(query)"
                                  ]
             */
        
           AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil).response { (responseData) in
            
                //if responseData.error != nil {
                    
                    if let satatusCode = responseData.response?.statusCode{
                        print("satatusCode Data ->",satatusCode)
                        
                        guard let data = responseData.data else{return}
                            
                           do{
                               let getSearch = try JSONDecoder().decode(SearchData.self, from: data)
                               self.delegate?.GetSearchMoviesName(searchData: getSearch)
                        
                           }catch{
                                print("Api verileri ile uyuşmazlık olmuş olabilir..")
                           }
                    }
                    
              /*
                }else{
                    print("AF ERROR ->",responseData.error.debugDescription)
                }
            */
            
            }
        }else{
            print("query must be provided")
        }
       
    }
}
