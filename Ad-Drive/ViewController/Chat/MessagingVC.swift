//
//  MessagingVC.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 13/07/2022.
//

import UIKit

class MessagingVC: UIViewController {
    
    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet weak var textViewMessage  : UITextView!
    @IBOutlet weak var buttonSend       : UIButton!
    
    var countval                        = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.separatorStyle        = .none
        
        tableView.register(UINib(nibName: "ChatMeTVCell", bundle: nil), forCellReuseIdentifier: "ChatMeTVCell")
        tableView.register(UINib(nibName: "ChatOtherTVCell", bundle: nil), forCellReuseIdentifier: "ChatOtherTVCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.countval = 15
            self.tableView.reloadData()
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSend(_ sender: Any) {
     
    }
}

extension MessagingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return countval
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row % 2 == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMeTVCell", for: indexPath) as? ChatMeTVCell {
                cell.viewBack.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 8)    
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOtherTVCell", for: indexPath) as? ChatOtherTVCell {
                cell.viewBack.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8)
                return cell
            }
        }
        return UITableViewCell()
    }
}
