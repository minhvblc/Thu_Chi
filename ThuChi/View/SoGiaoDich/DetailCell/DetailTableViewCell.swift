//
//  DetailTableViewCell.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 19/06/2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    //IBOutlet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Model
    var giaoDich : GiaoDichModel?
    
    
    var index = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let giaoDich = giaoDich{
            initUI(giaoDich: giaoDich, index: index)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageType.layer.cornerRadius = 5
    }
    
    
    func initUI(giaoDich: GiaoDichModel, index : Int){
        self.cellView.layer.shadowColor = UIColor.black.cgColor
        self.cellView.layer.shadowOpacity = 0.5
        self.cellView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.cellView.layer.shadowRadius = 4.0
        self.descriptionLabel.text = giaoDich.descriptionGD
        self.typeLabel.text = giaoDich.nameType
        self.valueLabel.text = String((giaoDich.value))
        self.valueLabel.textColor = (giaoDich.value) > 0 ? .green : .red
        let imageName = (giaoDich.value > 0) ? Thu.element(at: index)?.rawValue : (Chi.element(at: index)?.rawValue ?? "") as String
        if let imageName = imageName{
            self.imageType.image = UIImage(named: imageName)
        }
        let dateString = giaoDich.dateCreate.dateIntoString()
        self.dateLabel.text = dateString
        let dayOfWeek = giaoDich.dateCreate.checkDayOfWeek()
        self.dayLabel.text = dayOfWeek
    }
}
