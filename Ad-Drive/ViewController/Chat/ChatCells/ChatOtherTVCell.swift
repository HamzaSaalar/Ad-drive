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
    @IBOutlet weak var viewBack         : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        imageViewUser.backgroundColor = .lightGray
        imageViewUser.layer.cornerRadius = 12.5
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension UIView {

    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

}
