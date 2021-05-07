//
//  CabTableViewCell.swift
//  CabTab
//
//  Created by Prasad Parab on 07/05/21.
//

import UIKit

class CabTableViewCell: UITableViewCell {
	@IBOutlet weak var cabTypeImageView: UIImageView!
	@IBOutlet weak var cabTypeLabel: UILabel!
	@IBOutlet weak var cabIDLabel: UILabel!
	@IBOutlet weak var cabDistanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		cabTypeImageView.layer.cornerRadius = 8
		if #available(iOS 13.0, *) {
			cabTypeImageView.layer.borderColor = UIColor.label.cgColor
		} else {
			// Fallback on earlier versions
			cabTypeImageView.layer.borderColor = UIColor.black.cgColor
		}
		cabTypeImageView.layer.borderWidth = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
