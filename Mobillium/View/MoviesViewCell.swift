//
//  MoviesViewCell.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 8.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import Foundation
import  UIKit

class  MoviesViewCell: NSObject {
    
    func configure(moviesDataDetails:MoviesDetailsData?,movDetailInfo:UITextView!,moveDetailDesc:UILabel!,movDetailRes:UIImageView!,tmdbPuan:UILabel!,moviestarih:UILabel!){
         
        if  let resim = moviesDataDetails?.backdrop_path,
            let aciklama =  moviesDataDetails?.overview,
            let imdbID = moviesDataDetails?.vote_average,
            let title = moviesDataDetails?.title,
            let tarih = moviesDataDetails?.release_date{
            
            movDetailInfo.text = aciklama
            moveDetailDesc.text = title
            movDetailRes.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(resim)"))
                //.image = UIImage(named: resim)
            tmdbPuan.text = "\(imdbID)"
            moviestarih.text = "\(tarih)"
            
        }
    }
}
