//
//  ViewController.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 5.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit
import Kingfisher


class ListViewController: UIViewController {

    
    
    var sliderMoivesDataSource = Slider()
    var otherMoviesDataSource = OtherData()
    var searchDataSource = Search()
    
    var othersData:OtherListData?
    var slidersData:SliderListData?
    var searchData:SearchData?
    
    
    var dataVeri:[String] = []
    var filterData: [String] = []
    var overviewData:[String] = []
    var movImgData:[String] = []
    var durum:Bool = true
    
    // VİEW
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var otherTableView: UITableView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var sliderCollection: UICollectionView!
    
    
    // Timer OLuştutma
    var timer = Timer()
    var sayac = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        navigationItem.searchController = self.searchController
        view.backgroundColor = .white
        searchController.searchBar.delegate = self
        
        
        sliderMoivesDataSource.delegate = self
        otherMoviesDataSource.delegate = self
        searchDataSource.delegate = self
        
        
        otherTableView.delegate = self
        otherTableView.dataSource = self

        sliderCollection.delegate = self
        sliderCollection.dataSource = self
    }
    
    @objc func changeImage(){
        
        if let toplam = self.slidersData?.results.count{
            if sayac < toplam{
                let index = IndexPath.init(item: sayac, section: 0)
                self.sliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                sayac += 1
                self.pageView.currentPage = sayac
            }else{
                sayac = 0
                let index = IndexPath.init(item: sayac, section: 0)
                self.sliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                self.pageView.currentPage = sayac
                //sayac = 1
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        otherMoviesDataSource.getOtherData()
        sliderMoivesDataSource.getSlider()
       
                
        DispatchQueue.main.async {
            self.otherTableView.reloadData()
            self.sliderCollection.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! MovieDetailViewController
        guard let row = otherTableView.indexPathForSelectedRow?.row   else { return }

        if  let yolla = self.othersData?.results[row].id{
            vc.move_id? = yolla
        }
                
    }
    

}

// “/movie/now_playing” , “/movie/upcoming”. veerilerini alma

extension ListViewController: SliderMoviesDelegate,OtherMoviesDelegate, SearchMoviesDelegate{
    
    func GetSliderMovies(sliderMovData: SliderListData){
       
          self.slidersData = sliderMovData
        
        if let total = slidersData?.results.count{
           self.pageView.numberOfPages = total
            self.pageView.currentPage = 0
        }
        DispatchQueue.main.async {
           self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
       
      }
       
      func GetOtherDataMovies(otherData:OtherListData){
          self.othersData = otherData
        print("othersData -> \(String(describing: othersData))")
        DispatchQueue.main.async {
            self.otherTableView.reloadData()
        }
      }
        
      func GetSearchMoviesName(searchData:SearchData){
        self.searchData = searchData
        print("searchData \(searchData)")
        if let total = self.searchData?.results.count {
            for i in 0..<total {
                
                if let searchTitle = self.searchData?.results[i].title,
                    let searchImg = self.searchData?.results[i].poster_path,
                let searchOverview = self.searchData?.results[i].overview{
                    self.dataVeri.append(searchTitle)
                    self.movImgData.append(searchImg)
                    self.overviewData.append(searchOverview)
                }
            }
        }
        filterData = self.dataVeri
       
        self.durum = false
        DispatchQueue.main.async {
            self.otherTableView.reloadData()
        }
                   
    }
    
}
// “/movie/now_playing”  verilerini gösterme
extension ListViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: sliderCollection.frame.width/2.5, height: sliderCollection.frame.width/2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let total = self.slidersData?.results.count{
            return total
        }else{
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCollectionViewCell
        
            cell.configure(slidersData: self.slidersData, row: indexPath.row)
        
        
        return cell
    }
    
    
    
}
// “/movie/upcoming” verilerini gösterme
extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell id: ",indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if (durum){
            guard let total = othersData?.results.count else {  return 1}
            return total
        
        }else{
             return filterData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "othersCell", for: indexPath) as! OtherListsTableViewCell

        if (durum){
            cell.config(othersData: self.othersData ,row: indexPath.row)
        
        }else{
            cell.config(titleData: self.dataVeri, overviewData: self.overviewData, imgData: self.movImgData, row: indexPath.row)
        }
        
        return cell
    }
}
// SEARCH BAR'DA ARAMA YAPTIRILARAK GÖSTERİM DİNMAİK OLARAK SAĞLANDI
extension ListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        if searchBar.text == "" {
            filterData=dataVeri
            self.durum = true
        }
         self.otherTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
        filterData = []
        if searchText != "" && searchText.count > 2{
            
            self.searchDataSource.getSearch(query: searchText)
            for ad in dataVeri{
                if ad.lowercased().contains(searchText.lowercased()){
                    filterData.append(ad)
                }
            }
        }else{
            filterData=dataVeri
            
        }
        self.otherTableView.reloadData()
    }
    
}
