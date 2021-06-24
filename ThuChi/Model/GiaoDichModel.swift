//
//  GiaoDichModel.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 19/06/2021.
//

import Foundation
import RealmSwift

class GiaoDichModel: Object{

    
    @objc dynamic var dateCreate: Date = Date()
    @objc dynamic var descriptionGD: String = ""
    @objc dynamic var nameType: String = ""
    @objc dynamic var value: Int = 0
    convenience init(dateCreate: Date, descriptionGD: String, nameType: String, value: Int) {
        self.init()
        self.dateCreate = dateCreate
        self.descriptionGD = descriptionGD
        self.nameType = nameType
        self.value = value
    }
  
}
extension GiaoDichModel{
    static func add(dateCreate: Date, descriptionGD: String, nameType: String, value: Int){
        do {
            // realm
            let newGD = GiaoDichModel(dateCreate: dateCreate, descriptionGD: descriptionGD, nameType: nameType, value: value)
            let realm = try Realm()
            // results
            try realm.write {
                realm.add(newGD)
            }
            
            
        } catch {
            // call back
            
        }
    }
    static func update(giaoDich: GiaoDichModel,dateCreate: Date, descriptionGD: String, nameType: String, value: Int){
        do {
            // realm
           
            let realm = try Realm()
            // results
            try realm.write {
                giaoDich.dateCreate = dateCreate
                giaoDich.descriptionGD = descriptionGD
                giaoDich.nameType = nameType
                giaoDich.value = value
            }
            
            
        } catch {
            // call back
            
        }
    }
    static func delete(giaoDich: GiaoDichModel){
        do {
            // realm
           
            let realm = try Realm()
            // results
            try realm.write {
                realm.delete(giaoDich)
            }
            
            
        } catch {
            // call back
            
        }
    }
    static func fetch(from: Date?, to: Date?)->[GiaoDichModel]?{
        do {
            // realm
            let realm = try Realm()
            // results
            if let from = from, let to = to {
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@}", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }else{
                let to = Date()
                let from = Calendar.current.date(byAdding: .day, value: -30, to: to)!
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@}", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }
        } catch {
            // call back
           print("error")
            return nil
        }
    }
    static func fetchThu(from: Date?, to: Date?)->[GiaoDichModel]?{
        do {
            // realm
            let realm = try Realm()
            // results
            if let from = from, let to = to {
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value >= 0", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }else{
                let to = Date()
                let from = Calendar.current.date(byAdding: .day, value: -30, to: to)!
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value >= 0", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }
        } catch {
            // call back
           print("error")
            return nil
        }
    }
    static func fetchChi(from: Date?, to: Date?)->[GiaoDichModel]?{
        do {
            // realm
            let realm = try Realm()
            // results
            if let from = from, let to = to {
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value <= 0", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }else{
                let to = Date()
                let from = Calendar.current.date(byAdding: .day, value: -30, to: to)!
                let results = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value <= 0", from, to).sorted(byKeyPath: "dateCreate", ascending: false)
                let giaoDichs = Array(results)
                return giaoDichs
            }
        } catch {
            // call back
           print("error")
            return nil
        }
    }
    static func getTongThuHoacChi(isThu: Bool, from: Date?, to: Date?) -> Int{
        do {
            // realm
            let realm = try Realm()
            // results
            
            if let from = from, let to = to {
                
                let dataBetweenTime = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value \(isThu ? ">" : "<") 0", from, to)
                let result : Int = dataBetweenTime.sum(ofProperty: "value")
                
                return result
            }else{
                let to = Date()
                let from = Calendar.current.date(byAdding: .day, value: -30, to: to)!
                let dataBetweenTime = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND value \(isThu ? ">" : "<") 0" , from, to)
                let result : Int = dataBetweenTime.sum(ofProperty: "value")
                return result
            }
        } catch {
            // call back
           print("error")
            return 0
        }
    }
    static func getTongMotLoai(type: String, from: Date?, to: Date?) -> Int{
        do {
            // realm
            let realm = try Realm()
            // results
            
            if let from = from, let to = to {
                
                let dataBetweenTime = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND nameType == %@", from, to, type)
                let result : Int = dataBetweenTime.sum(ofProperty: "value")
                
                return result
            }else{
                let to = Date()
                let from = Calendar.current.date(byAdding: .day, value: -30, to: to)!
                let dataBetweenTime = realm.objects(GiaoDichModel.self).filter("dateCreate BETWEEN {%@, %@} AND nameType == %@", from, to, type)
                let result : Int = dataBetweenTime.sum(ofProperty: "value")
                return result
            }
        } catch {
            // call back
           print("error")
            return 0
        }
    }
    
}
