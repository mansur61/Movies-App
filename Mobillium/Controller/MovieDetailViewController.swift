//
//  MovieDetailViewController.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 6.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit
import  Kingfisher
class MovieDetailViewController: UIViewController {

    var moviesDetailsDataSource = MoviesDetails()
    var moviesDetailsData:MoviesDetailsData?
    
    var similarDataSource = SimilarMovies()
    var similarData:SimilarMoviesData?
    
    /* VİEW */
    @IBOutlet weak var movDetailRes: UIImageView!
    @IBOutlet weak var moveDetailDesc: UILabel!
    @IBOutlet weak var movDetailInfo: UITextView!
    @IBOutlet weak var tmdbPuan: UILabel!
    @IBOutlet weak var tarih: UILabel!
    
    @IBOutlet weak var simillarCollection: UICollectionView!
    var move_id:Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesDetailsDataSource.delegate = self
        similarDataSource.delegate = self
        
        simillarCollection.delegate = self
        simillarCollection.dataSource = self
        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.async {
           self.simillarCollection.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if let move_id = self.move_id {
             //print("MOVE ID: \(move_id)")
            moviesDetailsDataSource.getMoviesDetails(movie_id:move_id)
            similarDataSource.getSimiliar(movie_id:move_id)
        }
        DispatchQueue.main.async {
           self.simillarCollection.reloadData()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! MovieDetailViewController
        guard let row = simillarCollection.indexPathsForSelectedItems?.first?.row  else { return }
        print("ROWWW   \(row) ")
        guard let urunID = self.similarData?.results[row].id else {return}
        vc.move_id = urunID
        
    }


}
extension MovieDetailViewController: MoviesDeatilsDelegate,SimilarMoviesDelegate{
    
    func GetMoviesDetails(moviesDataDetails:MoviesDetailsData){
        
        self.moviesDetailsData = moviesDataDetails
        let movDeatils = MoviesViewCell()
        movDeatils.configure(moviesDataDetails: moviesDetailsData, movDetailInfo: self.movDetailInfo, moveDetailDesc: self.moveDetailDesc, movDetailRes: self.movDetailRes, tmdbPuan: self.tmdbPuan, moviestarih: self.tarih)
    }
    
    func GetSimiliarMovies(similiarMovData:SimilarMoviesData){
        self.similarData = similiarMovData
        
    }
}
extension MovieDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let total = self.similarData?.results.count{
            return total
        }
        else{
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = simillarCollection.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! SimilarCollectionViewCell
    
        cell.configure(similarData: similarData, row: indexPath.row)
        
        return cell
    }
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
 */
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: simillarCollection.frame.width/2.5, height: simillarCollection.frame.width/2)
        
    }
     
}

