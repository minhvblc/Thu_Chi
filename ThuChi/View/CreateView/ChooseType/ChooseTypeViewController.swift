//
//  ChooseTypeViewController.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import UIKit

class ChooseTypeViewController: UIViewController {
    
    var isThu = false
    var completionHadler : ((String)->Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TypeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        initData()
        self.title = "Chọn loại"
      
    
    }
    func initData(){
      
        tableView.reloadData()
    }


}
extension ChooseTypeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isThu {
            return Thu.allCases.count
        }
        return Chi.allCases.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TypeTableViewCell
        cell.isThu = isThu
        cell.index = indexPath.row
        cell.initUI()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TypeTableViewCell
        let text = cell.tyleCellLabel.text
        self.completionHadler?(text!)
        dismiss(animated: true, completion: nil)
    }
    
    
}
