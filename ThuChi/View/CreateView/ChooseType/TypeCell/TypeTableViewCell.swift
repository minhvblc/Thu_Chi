//
//  TypeTableViewCell.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
    //IBoutlet
    @IBOutlet weak var tyleCellLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    var isThu : Bool = true
    var index : Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func initUI(){
        if isThu {
            self.tyleCellLabel.text = Thu.element(at: index)?.rawValue
            self.imageCell.image = UIImage(named: Thu.element(at: index)!.rawValue)
        }
        else{
            self.tyleCellLabel.text = Chi.element(at:index)?.rawValue
            self.imageCell.image = UIImage(named: Chi.element(at: index)!.rawValue)
        }
    }
    
}
