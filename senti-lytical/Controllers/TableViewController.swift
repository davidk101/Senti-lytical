//
//  TableViewController.swift
//  senti-lytical
//
//  Created by David Kumar on 4/17/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchArticles()
        
    }
    
    func fetchArticles(){
        
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4755c5670e6b4ee3b10c550bee497a1c")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil{
                
                print(error!)
                return
            }
            
            self.articles = [Article]()
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers ) as! [String: AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]]{
                    
                    for articleFromJson in articlesFromJson{
                        
                        let article = Article()
                        
                        if let title = articleFromJson["title"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String{
                            
                            article.headline = title
                            article.imageUrl = urlToImage
                        }
                        
                        self.articles?.append(article)
                    }
                }
                
                DispatchQueue.main.async{
                    
                    self.tableView.reloadData()
                
                }
            }
            
            catch let error{
                
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
                
        cell.title.text = self.articles?[indexPath.item].headline
                
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    


}
