//
//  ChatMainVC.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 13/07/2022.
//

import UIKit

class ChatMainVC: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = 70
        tableView.separatorStyle    = .none
        tableView.register(UINib(nibName: "ChatMainTVCell", bundle: nil), forCellReuseIdentifier: "ChatMainTVCell")
    }
}

extension ChatMainVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMainTVCell", for: indexPath) as? ChatMainTVCell {
            //            cell.labelName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessagingVC") as? MessagingVC {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
