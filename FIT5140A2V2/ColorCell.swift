//
//  ColorCell.swift
//  FIT5140A2V2
//
//  Created by duo pan on 20/9/17.
//  Copyright © 2017 duo pan. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    @IBOutlet var colorView: UIView!
    @IBOutlet var labelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
