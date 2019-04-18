//
//  ViewController.swift
//  ShimmerViews
//
//  Created by Steve Rustom on 4/17/19.
//  Copyright © 2019 Steve Rustom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let square1 = CGRect(x: 15, y: 0, width: 44, height: 43)
    let square2 = CGRect(x: 170, y: 0, width: 44, height: 43)
    let square3 = CGRect(x: 330, y: 0, width: 44, height: 43)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        configureTableView()
        
    }
    
    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! CustomTableViewCell
            cell.one = RayShimmerView(frame: square1)
            cell.one.awakeFromNib()
            cell.addSubview(cell.one)
            
            
            cell.two = RayShimmerView(frame: square2)
            cell.two.awakeFromNib()
            cell.addSubview(cell.two)
            
            cell.three = RayShimmerView(frame: square3)
            cell.three.awakeFromNib()
            cell.addSubview(cell.three)
            
            return cell
            
        } else if indexPath.row == 1 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCellTwo", for: indexPath) as! CustomTableViewCellTwo
            cell.label.adjustsFontSizeToFitWidth = true
            
            return cell
        } else {
            fatalError("Couldn't return the proper UIImageViewCell.")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCellTwo
            
            cell.imageExample.image = nil
            cell.imageExample.configureAndStartShimmering()

            cell.label.text = nil
            cell.label.configureAndStartShimmering()
        }
        
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150.0
    }
}
