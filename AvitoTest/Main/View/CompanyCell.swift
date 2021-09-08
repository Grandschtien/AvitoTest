//
//  CompanyCell.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 08.09.2021.
//

import UIKit

class CompanyCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    static let nib = "CompanyCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
