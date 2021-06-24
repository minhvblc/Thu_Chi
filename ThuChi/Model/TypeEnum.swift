//
//  Type.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import Foundation


enum Chi: String, CaseIterable {
    
    case muaSam = "Mua sắm"
    case anUong = "Ăn uống"
    case diChuyen = "Di chuyển"
    case hoaDon = "Hoá đơn, Tiện ích"
    case banBeNguoiyeu = "Bạn bè, người yêu"
    case giaiTri = "Giải Trí"
    case sucKhoe = "Sức khoẻ"
    case quaTangQuyenGop = "Quà tặng, quyên góp"
    case giaDinh = "Gia đình"
    case giaoDuc = "Giáo dục"
    case dauTu = "Đầu tư"
    case khac = "Khác"
    static func element(at index: Int) -> Chi? {
        var elements = [Chi]()
        for i in Chi.allCases{
            elements.append(i)
        }
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}



enum Thu: String, CaseIterable {
    
    case tienLai = "Tiền lãi"
    case luong = "Lương"
    case duocTang = "Được tặng"
    case thuong = "Thưởng"
    case banDo = "Bán đồ"
    case khac = "Khác"
    static func element(at index: Int) -> Thu? {
        var elements = [Thu]()
        for i in Thu.allCases{
            elements.append(i)
        }
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
}

