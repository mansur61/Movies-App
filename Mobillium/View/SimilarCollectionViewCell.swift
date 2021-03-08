//
//  SimilarCollectionViewCell.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 7.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit
import  Kingfisher

class SimilarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var similarMoives: UIImageView!
    @IBOutlet weak var similarTitle: UILabel!
    
    
    func configure(similarData:SimilarMoviesData?,row:Int){
        
        if let title = similarData?.results[row].title,
            let similarImg = similarData?.results[row].poster_path{
            
            similarMoives.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w92\(similarImg)"))
                //.image = UIImage(named: similarImg)
            similarTitle.text = title
        }
    }
}
