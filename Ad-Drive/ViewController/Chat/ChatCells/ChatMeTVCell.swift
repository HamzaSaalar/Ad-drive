//
//  ChatMeTVCell.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 13/07/2022.
//

import UIKit

class ChatMeTVCell: UITableViewCell {

    
    @IBOutlet weak var labelMessage     : UILabel!
    @IBOutlet weak var labelTime        : UILabel!
    @IBOutlet weak var viewBack         : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
