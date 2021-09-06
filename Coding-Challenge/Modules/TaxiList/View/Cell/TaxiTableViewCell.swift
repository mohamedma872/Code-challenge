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
    @IBOutlet weak var taxiImg: UIImageView!
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
        switch viewModel?.status {
        case State.active.rawValue:
            taxiImg.image = Asset.taxiActive.image
        default:
            taxiImg.image = Asset.taxiInactive.image
        }
        idLabel.text = L10n.taxiid + "\(viewModel?.id ?? 0)"
        stateLabel.text = L10n.activationInfo + (viewModel?.status)! 
       
    }
}
