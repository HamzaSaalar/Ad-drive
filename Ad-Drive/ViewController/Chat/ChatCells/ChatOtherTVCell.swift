//
//  ChatOtherTVCell.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 13/07/2022.
//

import UIKit

class ChatOtherTVCell: UITableViewCell {

    @IBOutlet weak var labelMessage     : UILabel!
    @IBOutlet weak var labelTime        : UILabel!
    @IBOutlet weak var imageViewUser    : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
