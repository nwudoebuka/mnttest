//
//  ViewController.swift
//  mintbank
//
//  Created by Chukwuebuka Nwudo on 21/09/2020.
//  Copyright © 2020 Chukwuebuka Nwudo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,RepoModelOutput{

    
    @IBOutlet weak var tableV:UITableView!
    var numberOfItems = 0;
    var jsonOBJ = JSON()
    let repoModel = RepooModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        repoModel.delegate = self
        showLoading()
        repoModel.getCommits()
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellTableViewCell
        cell.date.text = jsonOBJ[indexPath.row]["commit"]["author"]["date"].stringValue
        cell.author.text = jsonOBJ[indexPath.row]["commit"]["author"]["name"].stringValue
        cell.message.text = jsonOBJ[indexPath.row]["commit"]["message"].stringValue
        return cell

    }
//
    
    func successRepo(_ response: JSON, _ requestCode: Int, _ statusCode: Int) {
        hideLoading()
        if statusCode == 200{
            jsonOBJ = response
            numberOfItems =  jsonOBJ.count
           tableV.reloadData()
        }else{
            alertWithoutAction("failed", "unable to get commits")
            
        }
    }
    
    func failRepo(_ response: JSON, _ requestCode: Int, _ statusCode: Int) {
        hideLoading()
         alertWithoutAction("failed", "unable to get commits")
    }

}

