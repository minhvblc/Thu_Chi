//
//  ViewController.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 22/06/2021.
//

import UIKit
import UserNotifications
class TabbarViewController: UITabBarController {
    let soGiaoDich = UINavigationController(rootViewController: SoGiaoDichViewController())
    let taoGiaoDich = UINavigationController(rootViewController: CreateViewController())
    let baoCaoView = UINavigationController(rootViewController: ReportViewController())
    let titleAttribute = [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!,
                           NSAttributedString.Key.foregroundColor: UIColor.red]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [soGiaoDich, taoGiaoDich, baoCaoView]
        initUI()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        let contents = UNMutableNotificationContent()
        contents.title = "Nay bạn chưa thu chi?"
        contents.body = "Ghi chép thu chi ngay thôi"
        contents.badge = NSNumber(value: 12)
     
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 9
        dateComponents.minute = 30
           
    
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: contents, trigger: trigger)
        
        center.add(request) { (error) in
           if error != nil {
             print(error)
           }
           else{
            print("ok")
           }
           
        }
    }

    func initUI(){
        guard let items = self.tabBar.items else {
            return
        }
        items[0].image = UIImage(systemName: "book.fill")
        items[1].image = UIImage(systemName: "plus.circle.fill")
        items[2].image = UIImage(systemName: "chart.pie.fill")
        
        soGiaoDich.navigationController?.navigationBar.titleTextAttributes = titleAttribute
        taoGiaoDich.navigationController?.navigationBar.titleTextAttributes = titleAttribute
        baoCaoView.navigationController?.navigationBar.titleTextAttributes = titleAttribute
      
        self.tabBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.tabBar.tintColor = .white
        soGiaoDich.navigationBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        taoGiaoDich.navigationBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        baoCaoView.navigationBar.barTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        soGiaoDich.navigationBar.tintColor = .white
        taoGiaoDich.navigationBar.tintColor = .white
        baoCaoView.navigationBar.tintColor = .white
        soGiaoDich.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        baoCaoView.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        taoGiaoDich.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
