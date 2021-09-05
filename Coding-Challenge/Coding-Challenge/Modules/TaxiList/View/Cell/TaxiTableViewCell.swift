//
//  TaxiTableViewCell.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import UIKit

class TaxiTableViewCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var viewModel: TaxiCellViewModel? {
        didSet {
            bindViewmodel()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindViewmodel() {
        idLabel.text = "\(viewModel?.id ?? 0)"
        stateLabel.text = viewModel?.status
        typeLabel.text =  viewModel?.type
    }
}
