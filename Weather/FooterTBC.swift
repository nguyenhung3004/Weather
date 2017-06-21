//
//  FooterTBC.swift
//  Weather
//
//  Created by Hung Nguyen on 5/28/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class FooterTBC: UITableViewCell {

    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var winSpeed: UILabel!
    @IBOutlet weak var visibility: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
