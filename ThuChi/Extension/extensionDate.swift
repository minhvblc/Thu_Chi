//
//  extension.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 21/06/2021.
//

import Foundation
import UIKit
 //MARK: ~ Extenstion turn date into string
extension Date{
    func dateIntoString () -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: self)
    }
    func checkDayOfWeek() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/YYYY"
        let myCalendar = Calendar(identifier: .gregorian)
        let day = myCalendar.component(.weekday, from: self)
      
        switch day {
        case 1:
            return "Chủ nhật"
        case 2:
            return "Thứ 2"
        case 3:
            return "Thứ 3"
        case 4:
            return "Thứ 4"
        case 5:
            return "Thứ 5"
        case 6:
            return "Thứ 6"
        case 7:
            return "Thứ 7"
        default:
            return ""
        }
    }
    
}


