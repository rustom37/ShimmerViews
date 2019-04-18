//
//  CustomTableViewCellTwo.swift
//  ShimmerViews
//
//  Created by Steve Rustom on 4/17/19.
//  Copyright © 2019 Steve Rustom. All rights reserved.
//

import UIKit

class CustomTableViewCellTwo: UITableViewCell {

    @IBOutlet weak var imageExample: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
