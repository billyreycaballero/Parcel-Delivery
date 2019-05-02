//
//  ParcelCellTableViewCell.swift
//  Parcel Delivery
//
//  Created by alcoderithm on 8/4/19.
//  Copyright © 2019 alcoderithm. All rights reserved.
//

import UIKit

@objc protocol ParcelCellDelegate: class {

}

class ParcelCellTableViewCell: UITableViewCell {
    var deleagte: ParcelCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var status: UILabel!
    
}
