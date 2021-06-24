//
//  BaocaoViewController.swift
//  ThuChi
//
//  Created by Nguyễn Minh on 18/06/2021.
//

import UIKit
import Charts

class ReportViewController: UIViewController, ChartViewDelegate {
    
    //IBOutlet
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var thunhapRongLabel: UILabel!
    @IBOutlet weak var thuLabel: UILabel!
    @IBOutlet weak var thuChartDescription: UILabel!
    @IBOutlet weak var chiLabel: UILabel!
    @IBOutlet weak var thuChart: PieChartView!
    @IBOutlet weak var chiChart: PieChartView!
    @IBOutlet weak var tongChart: PieChartView!
    @IBOutlet weak var chiChartDescription: UILabel!
    @IBOutlet weak var tongChartDescription: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromDate: UITextField!
    
    // variable
    var thuGiaoDich: [GiaoDichModel]?
    var tongGiaoDichs: [GiaoDichModel]?
    var tongThu: Int = 0
    var tongChi: Int = 0
    var chiGiaoDich: [GiaoDichModel]?
    let formatter = NumberFormatter()
    var xStartPosition = -UIScreen.main.bounds.width
    var xEndPosition : CGFloat?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tongChart.delegate = self
        thuChart.delegate = self
        chiChart.delegate = self
        scrollView.delegate = self
        
        setUpData()
        initUI()
     
    }
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    func startAnimation(){
        tongChart.frame.origin.x = xStartPosition
        chiChart.frame.origin.x = xStartPosition
        thuChart.frame.origin.x = xStartPosition
        tongChart.alpha = 0
        thuChart.alpha = 0
        chiChart.alpha = 0
        UIView.animate(withDuration: 1) {
            self.tongChart.frame.origin.x = self.xEndPosition!
            self.chiChart.frame.origin.x = self.xEndPosition!
            self.thuChart.frame.origin.x = self.xEndPosition!
            self.tongChart.alpha = 1
            self.thuChart.alpha = 1
            self.chiChart.alpha = 1
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpData()
        initUI()
    }
    func initUI(){
        //Add input textfield
        fromDate.addInputViewDatePicker(target: self)
        toDateTF.addInputViewDatePicker(target: self)

        updateChart()
        toDateTF.layer.borderWidth = 1
        self.title = "Báo cáo"
        toDateTF.layer.borderColor = UIColor.systemGreen.cgColor
        toDateTF.layer.cornerRadius = CGFloat(10)
        fromDate.layer.borderWidth = 1
        fromDate.layer.borderColor = UIColor.systemGreen.cgColor
        fromDate.layer.cornerRadius = CGFloat(10)
        chiLabel.text = String(tongChi)
        chiLabel.textColor = .red
        thuLabel.text = String(tongThu)
        thuLabel.textColor = .green
        thunhapRongLabel.text = String(tongThu-tongChi)
        thunhapRongLabel.textColor = (tongThu-tongChi > 0)  ? .green : .red
        tongChartDescription.text = "Tỉ lệ thu chi từ \(String(describing: (fromDate.text != "") ? fromDate.text! : Date().dateIntoString())) tới \(String(describing: (toDateTF.text != "") ? toDateTF.text! : Date().dateIntoString()))"
        thuChartDescription.text = "Tỉ lệ các khoản thu từ \(String(describing: (fromDate.text != "") ? fromDate.text! : Date().dateIntoString())) tới \(String(describing: (toDateTF.text != "") ? toDateTF.text! : Date().dateIntoString()))"
        chiChartDescription.text = "Tỉ lệ các khoản chi từ \(String(describing: (fromDate.text != "") ? fromDate.text! : Date().dateIntoString())) tới \(String(describing: (toDateTF.text != "") ? toDateTF.text! : Date().dateIntoString()))"
    }
    
    func setUpData(){
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        setTongThuChiSoDu(from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
        xEndPosition = self.view.center.x - self.tongChart.frame.width/2
        tongGiaoDichs = GiaoDichModel.fetch(from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
        tongThu = GiaoDichModel.getTongThuHoacChi(isThu: true, from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
        tongChi = -GiaoDichModel.getTongThuHoacChi(isThu: false, from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
        thuGiaoDich = GiaoDichModel.fetchThu( from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
        chiGiaoDich = GiaoDichModel.fetchThu( from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())
    }
    
    
    func updateChart(){
        updateThuChart()
        updateChiChart()
        updateTongChart()
    }
    
    
    func updateChiChart(){
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<Chi.allCases.count{
            let dataEntry = PieChartDataEntry(value:Double(-GiaoDichModel.getTongMotLoai(type: Chi.element(at: i)!.rawValue, from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())), label: Chi.element(at: i)!.rawValue)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.joyful()
        let chartData = PieChartData(dataSet: chartDataSet)
        chiChart.drawEntryLabelsEnabled = false
        chiChart.usePercentValuesEnabled = true
        chiChart.data = chartData
        chiChart.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
    }
    
    
    
    func updateThuChart(){
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<Thu.allCases.count{
            let dataEntry = PieChartDataEntry(value:Double(GiaoDichModel.getTongMotLoai(type: Thu.element(at: i)!.rawValue, from: fromDate.text?.stringIntoDate(), to: toDateTF.text?.stringIntoDate())), label: Thu.element(at: i)!.rawValue)
            dataEntries.append(dataEntry)
            
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(dataSet: chartDataSet)
        thuChart.drawEntryLabelsEnabled = false
        thuChart.data = chartData
        thuChart.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        thuChart.usePercentValuesEnabled = true
    }
    
    
    
    func updateTongChart(){
        let dataEntries: [PieChartDataEntry] = [PieChartDataEntry(value: Double(tongThu), label: "Thu")
                                                ,PieChartDataEntry(value: Double(tongChi), label: "Chi")]
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        tongChart.data = chartData
        tongChart.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        chartDataSet.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
        tongChart.usePercentValuesEnabled = true
    }
    
    
    
    func setTongThuChiSoDu(from: Date?, to : Date?){
        let moneyIn = GiaoDichModel.getTongThuHoacChi(isThu: true, from: from, to: to)
        let moneyOut = GiaoDichModel.getTongThuHoacChi(isThu: false, from: from, to: to)
        thuLabel.text = String(moneyIn)
        chiLabel.text = String(moneyOut)
        let balance = moneyIn + moneyOut
        thunhapRongLabel.text = String(balance)
    }
    
    @IBAction func filter(_ sender: Any) {
        setUpData()
        initUI()
    }
    
    
}



extension ReportViewController: UIScrollViewDelegate {
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (tongChart.window != nil) {
            UIView.animate(withDuration: 0.5) {
                self.tongChart.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
            UIView.animate(withDuration: 0.5, delay: 0.2) {
                self.tongChart.transform = CGAffineTransform.identity
            }
            
        }
        if (thuChart.window != nil) {
            UIView.animate(withDuration: 0.5) {
                self.thuChart.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
            UIView.animate(withDuration: 0.5, delay: 0.2) {
                
                self.thuChart.transform = CGAffineTransform.identity
            }
            
        }
        if (chiChart.window != nil) {
            UIView.animate(withDuration:0.5) {
                self.chiChart.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
            UIView.animate(withDuration: 0.5, delay: 0.2) {
                self.chiChart.transform = CGAffineTransform.identity
            }
        
            
        }
        
    }
    
    
    
}
