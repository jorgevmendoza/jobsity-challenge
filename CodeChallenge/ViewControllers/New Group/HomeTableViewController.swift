//
//  HomeTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var items:[Show]?{
        didSet{
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    var itemsCopy:[Show]?
    
    var filteredItems:[Show]?
    
    var currentPage:Int = 0
    
    let cellIdentifier = "ShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [Show]()
        
        itemsCopy = [Show]()
        
        filteredItems = [Show]()
        
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        getData()
        
        let searchController = UISearchController(searchResultsController: nil)
        
        refreshControl = UIRefreshControl()
        
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        refreshControl?.addTarget(self, action: #selector(refresData), for: .valueChanged)
    }
    
    //Move somewhere else
    
    @objc private func refresData(_ sender: Any) {
        // Fetch Weather Data
        getData()
    }
    
    func getData() {
        
        Services.shared.retriveShowList(page: currentPage){
            (show, error) in
            
            self.items = show
            
            self.itemsCopy = show
            
            self.currentPage = Int((self.items?.count ?? 0) / 250)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addImageTitle(name: "gray-text-logo-smaller")
        
        customLargeTitle(title:NSLocalizedString("Home", comment: ""))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
        
        cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row])
            //ShowCellData(show:items?[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = ShowDetailsViewController()
        
        detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row])
        
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}

extension HomeTableViewController:UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        filterByText(item: searchBar.text ?? "")
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        items = itemsCopy
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count != 0 {
            filterByText(item: searchBar.text ?? "")
        } else {
            items = itemsCopy
        }
    }
    
    func filterByText(item:String) {
        
        items = items?.filter{
            $0.name!.contains(item)
        } ?? []
    }
}
