//
//  DenemeListSearchController.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 8.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit

class DenemeListSearchController: UIViewController {

     let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var listSearchTableView: UITableView!
    
    var searchDataSource = Search()
    var searchData:SearchData?
    var dataVeri:[String] = []
    var filterData: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = self.searchController
             view.backgroundColor = .white
             searchController.searchBar.delegate = self
        
        searchDataSource.delegate = self
        listSearchTableView.delegate = self
        listSearchTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
        
    }
}

extension DenemeListSearchController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell id: ",indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "othersCell", for: indexPath) as! ListSearchTableViewCell

        
        return cell
        
    }
}

extension DenemeListSearchController: SearchMoviesDelegate{
    

      func GetSearchMoviesName(searchData:SearchData){
        self.searchData = searchData
        print("searchData \(searchData)")
        if let total = self.searchData?.results.count {
            for i in 0..<total {
                
                if let searchTitle = self.searchData?.results[i].title{
                    
                    self.dataVeri.append(searchTitle)
                    
                }
            }
        }
        filterData = self.dataVeri
       
       
        DispatchQueue.main.async {
           
        }
                   
    }
    
}

extension DenemeListSearchController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        if searchBar.text == "" {
            filterData=dataVeri
            
        }
        // self.otherTableView.reloadData()
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
            print("filterData 1-> \(filterData.count) -> searchText : \(searchText) => searchText.count: \(searchText.count)")
        }else{
            filterData=dataVeri
             print("filterData 2-> \(filterData.count) -> searchText : \(searchText) => searchText.count: \(searchText.count)")
        }
      //  self.otherTableView.reloadData()
    }
    
}
