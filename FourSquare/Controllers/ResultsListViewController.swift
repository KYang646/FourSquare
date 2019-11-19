//
//  ResultsListViewController.swift
//  FourSquare
//
//  Created by Kimball Yang on 11/13/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class ResultsListViewController: UIViewController {
    
    @IBOutlet weak var daTable: UITableView!
    
    var places: [Location]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daTable.delegate = self
        daTable.dataSource = self
        daTable.reloadData()
    }
    
    // Added animation to TableView appearing
    func viewWillAppear() {
        AnimatorFactory.scaleUp(view: daTable).startAnimation()
    }


}

extension ResultsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daTable.dequeueReusableCell(withIdentifier: "daTableCell", for: indexPath) as! ResultsTableViewCell
        let data = places![indexPath.row]
        cell.daName.text = data.name
        cell.daImage.image = UIImage(named: "noImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}
