//
//  TableViewCell.swift
//  BeerCraft
//
//  Created by ARY@N on 28/07/19.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var quantity: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        views(view: containerView)
    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
    @IBAction func saveForLaterPressed(_ sender: Any) {
    }
}
