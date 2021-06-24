//
//  CreateViewController.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import UIKit
import SkyFloatingLabelTextField
class CreateViewController: UIViewController {
    //Model
    var giaoDich : GiaoDichModel?
    
   
    //IBOutlet
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var dateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var thuChiSegment: UISegmentedControl!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (giaoDich == nil) ? "Tạo" : "Cập nhật"
        dateTF.addInputViewDatePicker(target: self)
        saveBtn.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        updateUI(giaoDich: giaoDich)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
       
    }
   
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        dateTF.resignFirstResponder()
        moneyTF.resignFirstResponder()
        descriptionTF.resignFirstResponder()
        
    }
    @IBAction func segmentCOntrol(_ sender: Any) {
        typeTF.text = ""
    }
    @IBAction func saveBtn(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let text = self.dateTF.text else { return }
        let date: Date? = dateFormatter.date(from: text)
        if let date = date, let descriptionGD = descriptionTF.text, let nameType = typeTF.text, let value = Int(self.moneyTF.text!){
            if thuChiSegment.selectedSegmentIndex == 0{
                GiaoDichModel.add(dateCreate: date, descriptionGD: descriptionGD, nameType: nameType, value: value)
            }
            else{
                GiaoDichModel.add(dateCreate: date, descriptionGD: descriptionGD, nameType: nameType, value: -value)
            }
            let alert = UIAlertController(title: "Lưu giao dịch", message: "Lưu thành công!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Oke", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Lưu giao dịch", message: "Lưu thất bại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Oke", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        updateUI(giaoDich: giaoDich)
        
    }
    
    
    
    @IBAction func chooseTypeBtn(_ sender: Any) {
        let vc = ChooseTypeViewController()
        if(thuChiSegment.selectedSegmentIndex == 0){
            vc.isThu = true
            
        }
        vc.completionHadler = { text in
            self.typeTF.text = text
        }
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func updateGD(_ sender: Any) {
        if let giaoDich = giaoDich, let des = descriptionTF.text, let type = typeTF.text, let val = Int(moneyTF.text ?? "0"){
            GiaoDichModel.update(giaoDich: giaoDich, dateCreate: dateTF.text?.stringIntoDate() ?? Date(), descriptionGD: des, nameType: type, value: (thuChiSegment.selectedSegmentIndex == 0) ? val : -val )
            let alert = UIAlertController(title: "Cập nhật giao dịch", message: "Cập nhật thành công!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Oke", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.giaoDich = nil
            updateUI(giaoDich: nil)
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Cập nhật giao dịch", message: "Cập nhật thất bại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Oke", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func updateUI(giaoDich : GiaoDichModel?){
        if let giaoDich = giaoDich{
            moneyTF.text = String(giaoDich.value > 0 ? giaoDich.value : -giaoDich.value)
            typeTF.text = giaoDich.nameType
            descriptionTF.text = giaoDich.descriptionGD
            dateTF.text = String(giaoDich.dateCreate.dateIntoString())
            thuChiSegment.selectedSegmentIndex = (giaoDich.value > 0) ? 0 : 1
            updateBtn.isHidden = false
            saveBtn.isHidden = true
            moneyTF.textColor = (giaoDich.value > 0) ? .green : .red
        }else{
            moneyTF.text = ""
            typeTF.text = ""
            descriptionTF.text = ""
            dateTF.text = ""
            updateBtn.isHidden = true
            saveBtn.isHidden = false
        }
    }
    
    
}
