//
//  LineChartViewController.swift
//  ExpenseTracker
//
//  Created by Erkan on 13.10.2023.
//

import UIKit
import DGCharts
import CoreData


class LineChartViewController: UIViewController, ChartViewDelegate {

    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.drawGridBackgroundEnabled = false
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
      //  yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue
        chartView.animate(xAxisDuration: 0.3)
        chartView.legend.enabled = false

        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    
    
    var expensesByDate: [String: [Tracker]] = [:]
    var totalExpensesByDate: [String: Float] = [:]
    var sortedExpensesByDate: [String: [Tracker]] = [:]
    var dateStringList: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        view.addSubview(lineChartView)
        lineChartView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 300)

        fetchExpenses()

        
        setData()
        lineChartView.animate(xAxisDuration: TimeInterval(yValues.count/16))
        

    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    
    func setData(){
        let set1 = LineChartDataSet(entries: yValues2) // Etiket olarak nil kullanarak label'ı kaldır
       //    set1.mode = .cubicBezier
        set1.mode = .linear
           set1.lineWidth = 2
        //   set1.setColor(.red) // İçindeki çizginin rengi
           set1.fill = ColorFill(color: .white)
           set1.fillAlpha = 0.8
           set1.drawFilledEnabled = true
           set1.drawCirclesEnabled = false
           set1.drawHorizontalHighlightIndicatorEnabled = false

           let data = LineChartData(dataSet: set1)
           data.setDrawValues(false)
           lineChartView.data = data

           // x ekseni değerlerini ayarla
        let xValues: [String] = dateStringList
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
    }
    
    
    let yValues: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 10.0),
                                     ChartDataEntry(x: 1.0, y: 20.0),
                                     ChartDataEntry(x: 2.0, y: 1000),
                                     ChartDataEntry(x: 3.0, y: 45.0),
                                     ChartDataEntry(x: 4.0, y: 52.0),
                                     ChartDataEntry(x: 5.0, y: 61.0),
                                     ChartDataEntry(x: 6.0, y: 61.0),
                                     ChartDataEntry(x: 7.0, y: 61.0),
                                     ChartDataEntry(x: 8.0, y: 61.0),
                                     ChartDataEntry(x: 9.0, y: 61.0),
                                     ChartDataEntry(x: 10.0, y: 61.0),
                                     ChartDataEntry(x: 11.0, y: 61.0),
                                     ChartDataEntry(x: 12.0, y: 120),
                                     ChartDataEntry(x: 13.0, y: 135),
                                     ChartDataEntry(x: 14.0, y: 61.0),
                                     ChartDataEntry(x: 15.0, y: 206),
                                     ChartDataEntry(x: 16.0, y: 307),
                                     ChartDataEntry(x: 17.0, y: 505),]
    
    
    var yValues2: [ChartDataEntry] = []
    
    
    
    func fetchExpenses(chosenRow: String = "All") {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
       // let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
           
           // Tarih aralığını sınırlamak için bir NSPredicate oluşturun
        //let datePredicate = NSPredicate(format: "date >= %@", oneWeekAgo! as NSDate)
       // fetchRequest.predicate = datePredicate
        //let moneySortDescriptor = NSSortDescriptor(key: "privatemoney", ascending: false)
        
        dateStringList.removeAll()
        
        switch chosenRow{
        case "All":
            print("Eveet")
            
        case "Daily":
            print("DAİLY")
            let dayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())
            let datePredicate = NSPredicate(format: "date >= %@", dayAgo! as NSDate)
            fetchRequest.predicate = datePredicate
        case "Weekly":
            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
            let datePredicate = NSPredicate(format: "date >= %@", oneWeekAgo! as NSDate)
            fetchRequest.predicate = datePredicate
        case "Monthly":
            print("DAİLY")
            let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())
            let datePredicate = NSPredicate(format: "date >= %@", oneMonthAgo! as NSDate)
            fetchRequest.predicate = datePredicate

        case "Yearly":
            print("DAİLY")
            let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date())
            let datePredicate = NSPredicate(format: "date >= %@", oneYearAgo! as NSDate)
            fetchRequest.predicate = datePredicate

            
        default:
            print("okey")
        }
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        expensesByDate = [:]
        
        do {
            let expenses = try context.fetch(fetchRequest)
            for expense in expenses {
            //    print(expense.privatemoney)
                if let date = expense.date {
                 //   print(date)
                    let dateFormatter = DateFormatter()
                  //  dateFormatter.dateFormat = "MM-dd-yyyy" // İstediğiniz tarih formatına uygun olarak değiştirin
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                  //  dateFormatter.dateStyle = .long
                    let dateString = dateFormatter.string(from: date)
                    if expensesByDate[dateString] == nil {
                        expensesByDate[dateString] = []
                    //    print(dateString)
                       // dateStringList.append(dateString)
                    }
                   
      
                 
                //    print(dateString)
                    
                    
                
                    expensesByDate[dateString]?.append(expense)
                    
                    
                    
                }

            }
         //   print(expensesByDate)
            

            
            
          //  tableView1.reloadData()
            
            
            let sortedDates = expensesByDate.keys.sorted()
           // print(sortedDates)
            // Sıralanmış verilere erişmek için yeni bir sıralanmış sözlük oluşturun
            var sortedExpensesByDate: [String: [Tracker]] = [:]
            

            for dateString in sortedDates {
                if let trackerData = expensesByDate[dateString] {
                    // Eğer veriler bulunursa, yeni sözlüğe ekleyebilirsiniz
                    sortedExpensesByDate[dateString] = trackerData
                   // print(dateString)
                }
            }
            
          //  print(sortedExpensesByDate)
            
                        
         
            
            
            for (dateString, expenses) in sortedExpensesByDate {
               // print(dateString)
                let totalExpense = expenses.reduce(into: 0.0) { result, expense in
                    
                    if expense.privatemoney < 0.0 {
                        result -= Double(expense.privatemoney) // Burası değişti
                    }
                    
                 //   result += expense.privatemoney
                }
                totalExpensesByDate[dateString] = Float(totalExpense)
            }
         //  print(totalExpensesByDate)
            
            let sortedTotalExpenses = totalExpensesByDate.sorted { $0.key < $1.key }
            var i = 0.0
            var previousMonth = ""
            for (dateString, totalExpense) in sortedTotalExpenses {
                print("Tarih: \(dateString), Toplam Gider: \(totalExpense)")
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd"


                if let date = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "MMMM"
                    let monthName = dateFormatter.string(from: date)
                    
                    
                    
                    
                    
                    dateStringList.append(monthName)
                    
                    
                    
                } else {
                    print("Tarih dönüşümü başarısız.")
                }
                yValues2.append(ChartDataEntry(x: Double(i), y: Double(totalExpense)))
                i+=1
            }
            
            print(yValues2)
            
            
            
       
     
        } catch {
            print("Error fetching expenses: \(error)")
        }
    }
    

  //  ["09-26-2023": -1202.0, "09-21-2023": 500.0, "09-27-2023": -1934.0, "10-13-2023": 200.0, "09-25-2023": 1918.0]
    
    //3984
    //-4708
    
    //["09-01-2023": -100.0, "10-13-2023": 200.0, "08-16-2023": -1.0, "08-08-2023": -105.0, "09-27-2023": -1934.0, "09-26-2023": -1202.0, "09-21-2023": 500.0, "09-25-2023": 1918.0]
}
