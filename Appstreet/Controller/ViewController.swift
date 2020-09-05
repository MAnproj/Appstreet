//
//  ViewController.swift
//  Appstreet
//
//  Created by abc on 27/08/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var arrFacts:Facts?
    var appData = [Hit]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
        setupSearchBar()
        dataModelSetup()
    }
    
    private func setupSearchBar(){
        //searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    private func dataModelSetup(){
        var facts = self.arrFacts!.hits
        facts = [Hit]()
    }
    
    func jsonParsing(){
        
        let url = Bundle.main.path(forResource: "facts", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url!), options: .alwaysMapped)
            self.arrFacts = try JSONDecoder().decode(Facts.self, from:data)
            guard let facts = self.arrFacts?.hits else{return}
            for _ in facts{
//                print(arr.tags ?? "No Description")
//                print(arr.previewURL ?? "No Image")
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }catch {
    print("parse error: \(error.localizedDescription)")
    }
    
   }
}

extension ViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        if searchText == ""{
            dataModelSetup()
        }else{
            dataModelSetup()
            //appData = appData.filter{
             //   $0.tags!.contains(searchText)
          var facts = arrFacts!.hits.filter(){
            $0.tags!.contains(searchText)
            }
            
        }
        self.tableview.reloadData()
    }
    
   
}


 extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let facts = self.arrFacts!.hits
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let facts = self.arrFacts!.hits
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblTags.text = facts[indexPath.row].tags
        let url = URL(string: facts[indexPath.row].previewURL ?? "")
        cell.img.kf.setImage(with: url)
        return cell
    }
}

extension ViewController: UISearchBarDelegate,UISearchControllerDelegate{
    
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
//
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        <#code#>
//    }
    
    
    
}
