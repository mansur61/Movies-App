//
//  SliderCollectionViewCell.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 7.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit
import Kingfisher
class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderRes: UIImageView!
    @IBOutlet weak var sliderTitle: UILabel!
    
    var size:String = "w500"
    var baseUrl:String = "https://image.tmdb.org/t/p/"
    
    func configure(slidersData:SliderListData?,row:Int){
        
        if let sliderImg = slidersData?.results[row].backdrop_path,
            let title = slidersData?.results[row].title{
            
            self.sliderTitle.text = title
            self.sliderRes.kf.setImage(with: URL(string: "\(baseUrl)\(size)\(sliderImg)"))
            //image = UIImage(named: sliderImg)
        }
    }
    
}
