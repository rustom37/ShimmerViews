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
    var count = 2
    
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
        return count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCellThree", for: indexPath) as! CustomTableViewCellThree
            
            let cell2 = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CustomTableViewCellTwo

            for subview in cell2.contentView.subviews {
                cell.contentView.addSubview(UIView(frame: CGRect(x: subview.frame.origin.x,  y: subview.frame.origin.y, width: subview.frame.size.width, height: subview.frame.size.height)))
            }
            
            for subview in cell.contentView.subviews {
                subview.configureAndStartShimmering()
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1 {
            count += 1
            let indexPathOfLastRow = NSIndexPath.init(row: count - 1, section: 0)
            tableView.insertRows(at: [indexPathOfLastRow as IndexPath], with: .bottom)
        }
        
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150.0
    }
}
