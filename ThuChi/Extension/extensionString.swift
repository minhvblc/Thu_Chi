//
//  extensionString.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 23/06/2021.
//

import Foundation

//Êxtension turn string into Date
extension String{
    func stringIntoDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if self != nil{
            return dateFormatter.date(from: self)}
        else{
            return nil
        }
    }
}
