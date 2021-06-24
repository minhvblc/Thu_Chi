//
//  extensionTextField.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 23/06/2021.
//

import Foundation
import UIKit

//MARK: ~ Extenstion add date picker to textfield
extension UITextField {
    
    func addInputViewDatePicker(target: Any) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self
                                            , action: #selector(getDate))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
        
        
        
    }
    
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
    @objc func getDate(){
        if let  datePicker = self.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            self.text = dateFormatter.string(from: datePicker.date)
        }
        self.resignFirstResponder()
    }
}
