//
//  OtherListsTableViewCell.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 7.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit
import Kingfisher

class OtherListsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var otherMovDesc: UILabel!
    @IBOutlet weak var otherMovTitle: UILabel!
    @IBOutlet weak var otherMovImage: UIImageView!
    @IBOutlet weak var otherTarih: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(othersData:OtherListData?,row:Int){
        
        if let otherTitle = othersData?.results[row].title , let otherADesc = othersData?.results[row].overview ,
            let otherImage = othersData?.results[row].poster_path,
        let othertarih = othersData?.results[row].release_date{
            
            self.otherMovTitle.text = otherTitle
             self.otherTarih.text = othertarih
            self.otherMovDesc.text = otherADesc
           self.otherMovImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(otherImage)"))
            // self.otherMovImage.kf.setImage(with: URL(string: "\(otherImage)"))
            //image = UIImage(named: otherImage) //KingFisher kullanılacak
            
        }
    }
    func config(titleData: [String]?, overviewData: [String],imgData: [String],row: Int){
        
        if let title = titleData?[row]{
            self.otherMovTitle.text = title
            self.otherMovDesc.text = overviewData[row]
            self.otherMovImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(imgData[row])"))
                //UIImage(named: imgData[row]) //KingFisher kullanılacak
            
        }
           
       
    }
}
