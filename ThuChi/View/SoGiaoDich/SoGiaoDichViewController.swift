//
//  SoGiaoDichViewController.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import UIKit

class SoGiaoDichViewController: UIViewController {
    //IBOutlet
    @IBOutlet weak var moneyOutLabel: UILabel!
    @IBOutlet weak var moneyInLabel: UILabel!
    @IBOutlet weak var fromTime: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var toTimeTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var motherVIewHeadStackView: UIView!
    
    //Moddel
    var giaoDichs : Array<GiaoDichModel>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        setData()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        giaoDichs = GiaoDichModel.fetch(from: nil, to: nil)
        self.setTongThuChiSoDu(from: self.fromTime.text?.stringIntoDate(), to: self.toTimeTF.text?.stringIntoDate())
        self.tableView.reloadData()
    }
    
    
    
    func setData(){
        giaoDichs = GiaoDichModel.fetch(from: nil, to: nil)
    }
    
    
    
    func initUI() {
        self.title = "Lịch sử"
        toTimeTF.layer.borderWidth = 1
        toTimeTF.layer.borderColor = UIColor.systemGreen.cgColor
        toTimeTF.layer.cornerRadius = CGFloat(10)
        toTimeTF.addInputViewDatePicker(target: self)
        fromTime.addInputViewDatePicker(target: self)
        fromTime.layer.borderWidth = 1
        fromTime.layer.borderColor = UIColor.systemGreen.cgColor
        fromTime.layer.cornerRadius = CGFloat(10)
        setTongThuChiSoDu(from: nil, to: nil)
        
    }
    
    
    
    func setTongThuChiSoDu(from: Date?, to : Date?){
        let moneyIn = GiaoDichModel.getTongThuHoacChi(isThu: true, from: from, to: to)
        let moneyOut = GiaoDichModel.getTongThuHoacChi(isThu: false, from: from, to: to)
        moneyInLabel.text = String(moneyIn)
        moneyOutLabel.text = String(moneyOut)
        let balance = moneyIn + moneyOut
        balanceLabel.text = String(balance)
    }
    
    
    
    @IBAction func filter(_ sender: Any) {
        if let from = fromTime.text?.stringIntoDate(), let to = toTimeTF.text?.stringIntoDate(){
            giaoDichs = GiaoDichModel.fetch(from: from, to: to)
            self.tableView.reloadData()
        }else{
            return
        }
    }
    
    
   
}



//MARK: ~ TableView Datasource, TableViewDelegate
extension SoGiaoDichViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giaoDichs?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        cell.initUI(giaoDich: (giaoDichs?[indexPath.row])!, index: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CreateViewController()
        vc.giaoDich = giaoDichs?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let del = UIContextualAction(style: .destructive, title: "Delete") { (context, view, completion) in
            if let giaoDich = self.giaoDichs?[indexPath.row]{
                GiaoDichModel.delete(giaoDich: giaoDich)
                self.giaoDichs = GiaoDichModel.fetch(from: self.fromTime.text?.stringIntoDate(), to: self.toTimeTF.text?.stringIntoDate())
                self.setTongThuChiSoDu(from: self.fromTime.text?.stringIntoDate(), to: self.toTimeTF.text?.stringIntoDate())
                self.tableView.reloadData()
                
            }
            
        }
        return UISwipeActionsConfiguration(actions:[del])
    }
    
    
    //Animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height)
        UIView.animate(withDuration: 1, delay: 0.05*Double(indexPath.row), usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1, options: .curveEaseInOut) {
//            cell.alpha = 1
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}


