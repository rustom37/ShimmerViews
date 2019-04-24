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
            
            var lowestBottomView: UIView? = nil
            
            for subview in cell2.contentView.subviews {
                
                if let label = subview as? UILabel {
                    let textSize = CGSize(width: CGFloat(label.frame.size.width), height: CGFloat(MAXFLOAT))
                    let rHeight: Int = lroundf(Float(label.sizeThatFits(textSize).height))
                    let charSize: Int = lroundf(Float(label.font.pointSize))
                    let numberOfLines = rHeight / charSize

                    var y = subview.frame.origin.y
                    for _ in 1...numberOfLines {
                        let tempView: UIView = UIView(frame: CGRect(x: subview.frame.origin.x,  y: y, width: CGFloat(subview.frame.size.width), height: CGFloat(charSize) * 0.7))
                        tempView.translatesAutoresizingMaskIntoConstraints = false
                        cell.contentView.addSubview(tempView)
                        tempView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: subview.frame.origin.x).isActive = true
                        tempView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: y).isActive = true
                        
                        if lowestBottomView == nil || ((tempView.frame.origin.y + tempView.frame.size.height) > ((lowestBottomView?.frame.origin.y)! + (lowestBottomView?.frame.size.height)!)) {
                            lowestBottomView = tempView
                        }
                        
                        tempView.widthAnchor.constraint(equalToConstant: subview.frame.size.width).isActive = true
                        tempView.heightAnchor.constraint(equalToConstant: CGFloat(charSize) * 0.7).isActive = true

                        y += CGFloat(charSize)
                    }
                } else {
                    let tempView = UIView(frame: CGRect(x: subview.frame.origin.x,  y: subview.frame.origin.y, width: subview.frame.size.width, height: subview.frame.size.height))
                    tempView.translatesAutoresizingMaskIntoConstraints = false
                    cell.contentView.addSubview(tempView)
                    tempView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: subview.frame.origin.x).isActive = true
                    tempView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: subview.frame.origin.y).isActive = true
                    
                    if lowestBottomView == nil || ((tempView.frame.origin.y + tempView.frame.size.height) > ((lowestBottomView?.frame.origin.y)! + (lowestBottomView?.frame.size.height)!)) {
                        lowestBottomView = tempView
                    }
                    
                    tempView.widthAnchor.constraint(equalToConstant: subview.frame.size.width).isActive = true
                    tempView.heightAnchor.constraint(equalToConstant: subview.frame.size.height).isActive = true
                }
            }
            if let lowestBottomView = lowestBottomView {
                lowestBottomView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10).isActive = true
            }
            
            if cell.contentView.subviews.count > 1 {

                cell.startShimmering(color: UIColor.white)
                
                for subview in cell.contentView.subviews {
                    subview.startShimmering()
                    subview.stopShimmering()
                }
                
            } else {
                for subview in cell.contentView.subviews {
                    subview.startShimmering()
                }
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
        tableView.estimatedRowHeight = 250.0
    }
}
