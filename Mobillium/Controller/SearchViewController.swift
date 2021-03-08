//
//  SearchViewController.swift
//  Mobillium
//
//  Created by Mansur Emin  Kaya on 6.03.2021.
//  Copyright © 2021 Mansur Emin  Kaya. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    // modals
    var searchDataSource = Search()
    var searchsData:SearchData?
    
    var dataVeri:[String] = []
    var filterData: [String] = []
    
    // views
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var warmingLbl: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.searchController = self.searchController
        view.backgroundColor = .white
        searchController.searchBar.delegate = self
        

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchDataSource.delegate = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if filterData.count == 0 {
                self.searchTableView.isHidden = true
                self.warmingLbl.isHidden = true//false
        }else{
            self.searchTableView.isHidden = false
            self.warmingLbl.isHidden = true
        }
       
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
         
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailViewController
        guard let row = searchTableView.indexPathForSelectedRow?.row   else { return }

        if  let yolla = self.searchsData?.results[row].id{
            vc.move_id? = yolla
        }
    }
 

}
// “/search/movie”. verileri alındı modaldan
extension SearchViewController: SearchMoviesDelegate{
    
    func GetSearchMoviesName(searchData:SearchData){
        self.searchsData = searchData
        if let total = self.searchsData?.results.count {
            for i in 0..<total {
                if let searchTitle = self.searchsData?.results[i].title{
                    self.filterData.append(searchTitle)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    
    
}
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell id: ",indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        if filterData.count != 0 {
           return filterData.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchPagesCell", for: indexPath) as! SearchTableViewCell
        
        
        if filterData.count != 0 {
            cell.searhTitle.text = self.filterData[indexPath.row]
        }else{
            self.warmingLbl.isHidden = true//false
            self.searchTableView.isHidden = true
        }
       
        return cell
        
    }
}
// SEARCH İŞLMLERİ TAMAMLANDI
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if searchBar.text == "" {
            
            self.searchTableView.isHidden = true
            self.warmingLbl.isHidden = true//false
           
        }
         self.searchTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
        
        if searchText != "" && searchText.count > 2 {
            
            self.searchDataSource.getSearch(query: searchText)
           // print("filterData.count -> \(filterData.count)")
            if filterData.count == 0 {
                self.searchTableView.isHidden = true
                self.warmingLbl.isHidden = true//false
            }else{
                self.warmingLbl.isHidden = true
                self.searchTableView.isHidden = false
            }
        }else{
            self.searchTableView.isHidden = true
            self.warmingLbl.isHidden = true//false
        }
        self.searchTableView.reloadData()
        
    }
    
}
