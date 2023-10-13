//
//  ViewControllerDeneme.swift
//  ExpenseTracker
//
//  Created by Erkan on 27.08.2023.
//

import UIKit
import CoreData
import DGCharts
import FSCalendar


struct MyData {
    var value: Float
    var label: String
}










class PieChartViewController: UIViewController, ChartViewDelegate, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, NSFetchedResultsControllerDelegate {


    var pieChart = PieChartView()
    
    var selectedIntervalDate: String = ""
    var percentTotal: Float = 0.0
    var timeNumber = 0
    var timeChosen: String = ""
    var degistiMi: Bool = true
    
    var today = Date()
    var categories = [Category]()
    
    
    private let calendarcik = FSCalendar(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width - 40, height: 300))

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    let expensesTodayButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(expensesTodayClicked), for: .touchUpInside)
        button.setTitle("Daily".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
      //  button.backgroundColor = .red
        return button
    }()
    
    
    
    
    @objc func expensesTodayClicked(){
        
        
        expensesTodayButton.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        expensesOneWeekButton.backgroundColor = .white
        expensesOneMonthButton.backgroundColor = .white
        expensesOneYearButton.backgroundColor = .white
        takvimButton.backgroundColor = .white
           
           // Tarih biçimleyici oluşturun ve tarihi istediğiniz formata dönüştürün
           let dateFormatter = DateFormatter()
         //   dateFormatter.dateFormat = "dd/MM/yyyy" // Tarih formatını ayarlayabilirsiniz
            dateFormatter.dateStyle = .medium
           // Biçimlenmiş tarihi UILabel üzerinde görüntüleyin
            timeChosen = dateFormatter.string(from: today)
        
        
        if selectedIntervalDate != "Day"{
            timeNumber = 1
            fetchByDate(date: 1)
            
            fetchPieChart()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pieChart.notifyDataSetChanged()
        }

        
        self.selectedIntervalDate = "Day"
        
    }
    
    
    let expensesOneWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(expensesOneWeekClicked), for: .touchUpInside)
        button.setTitle("Weekly".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
      //  button.backgroundColor = .red
        button.layer.cornerRadius = 5

        return button
    }()
    
    @objc func expensesOneWeekClicked(){
        expensesOneWeekButton.backgroundColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        expensesTodayButton.backgroundColor = .white
        expensesOneMonthButton.backgroundColor = .white
        expensesOneYearButton.backgroundColor = .white
        takvimButton.backgroundColor = .white

     //   if number != 1 {
        if selectedIntervalDate != "Week"{
            timeNumber = 2
            fetchByDate(date: 2)
            
            fetchPieChart()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pieChart.notifyDataSetChanged()
        }

        
        self.selectedIntervalDate = "Week"
    //    }
        
  

        
        
        
        
    }
    
    
    let expensesOneMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Monthly".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
      //  button.backgroundColor = .red

        button.addTarget(self, action: #selector(expensesOneMonthClicked), for: .touchUpInside)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5

        return button
    }()
    
    @objc func expensesOneMonthClicked(){
        expensesOneMonthButton.backgroundColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        expensesTodayButton.backgroundColor = .white
        expensesOneWeekButton.backgroundColor = .white
        expensesOneYearButton.backgroundColor = .white
        takvimButton.backgroundColor = .white
        if selectedIntervalDate != "Month"{
            timeNumber = 3
            fetchByDate(date: 3)
            
            fetchPieChart()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pieChart.notifyDataSetChanged()
        }

        
        self.selectedIntervalDate = "Month"
        
    }
    
  /*  func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Bu metot, kullanıcının collectionView içinde kaydırma işlemi yaptığında çağrılır.
        // Burada üstteki görünümü yukarı kaydırabilirsiniz.
        // Örneğin, üstteki görünümünüzü yukarı taşımak için aşağıdaki gibi bir kod kullanabilirsiniz:

         print(scrollView.contentOffset.y)

        if scrollView.contentOffset.y > 0 {
            print("Babaaa")
            
            
            
            let yOffset = scrollView.contentOffset.y
            let translationY = -yOffset
            print(translationY)
            
            
            
            self.backPieChartView.transform = CGAffineTransform(translationX: 0, y: -yOffset)
            self.collectionView.anchor(top: backPieChartView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        }


    }*/
    
    
    
    
    let expensesOneYearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yearly".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
       // button.backgroundColor = .red
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(expensesOneYearClicked), for: .touchUpInside)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5

        return button
    }()
    
    @objc func expensesOneYearClicked(){
        
        expensesOneYearButton.backgroundColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        expensesTodayButton.backgroundColor = .white
        expensesOneWeekButton.backgroundColor = .white
        expensesOneMonthButton.backgroundColor = .white
        takvimButton.backgroundColor = .white
     //   print("hoop")
        if selectedIntervalDate != "Year"{
            timeNumber = 4
            fetchByDate(date: 4)
            
            fetchPieChart()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pieChart.notifyDataSetChanged()
        }

        
        self.selectedIntervalDate = "Year"
        
    }
    
    
    
    // Veri noktalarını oluşturun
    var dataPoints: [MyData] = [
        MyData(value: 18.5, label: "Green"),
        MyData(value: 26.7, label: "Yellow"),
        MyData(value: 24.0, label: "Red"),
        MyData(value: 1, label: "Blue")
    ]
    
    
    let backPieChartView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
      //  view.backgroundColor =  UIColor(red: 200/255, green: 200/255, blue: 209/255, alpha: 1)
        return view
    }()
    
    var oylesinView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor =  UIColor(red: 200/255, green: 200/255, blue: 209/255, alpha: 1)
        return view
    }()
    
    
    let backCollectionView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor =  UIColor(red: 200/255, green: 200/255, blue: 209/255, alpha: 1)
        return view
    }()
    
    let takvimButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All Times".localized(), for: .normal)
        button.addTarget(self, action: #selector(takvimAcildi), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    @objc func takvimAcildi(){
        
        
        takvimButton.backgroundColor =  UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        expensesOneYearButton.backgroundColor = .white
        expensesTodayButton.backgroundColor = .white
        expensesOneWeekButton.backgroundColor = .white
        expensesOneMonthButton.backgroundColor = .white
    
     //   print("hoop")
        if selectedIntervalDate != "All"{
            timeNumber = 5
            fetchByDate(date: 5)
            
            fetchPieChart()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            pieChart.notifyDataSetChanged()
        }

        
        self.selectedIntervalDate = "All"
        
        
        
      /*  takvimButton.backgroundColor = .lightGray
        expensesTodayButton.backgroundColor = .white
        expensesOneWeekButton.backgroundColor = .white
        expensesOneMonthButton.backgroundColor = .white
        expensesOneYearButton.backgroundColor = .white

        calendarView.isHidden = false
        calendarcik.isHidden = false
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        let calendar = Calendar.current
        let dateBugun = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: preferredLanguage)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedSelectedDay = dateFormatter.string(from: selectedDate)
        let dateSimdi = dateFormatter.string(from: dateBugun)
        print("selected:  \(formattedSelectedDay)")
        print("selected:  \(dateSimdi)")

        var components2 = calendar.dateComponents([.day, .month, .year], from: dateBugun)

        if formattedSelectedDay == dateSimdi {
             components2 = calendar.dateComponents([.day, .month, .year], from: dateBugun)
        }else{
             components2 = calendar.dateComponents([.day, .month, .year], from: selectedDate)
        }
        
        
        

        
        if let day = components2.day, let month = components2.month, let year = components2.year {
             let dayString = String(format: "%02d", day) // Günü iki haneli bir string olarak al
             
             let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: preferredLanguage)
             dateFormatter.dateFormat = "MMMM" // Ayı tam adı olarak almak için "MMMM" formatını kullanın
            let monthString = dateFormatter.string(from: dateBugun)
             
             let yearString = String(format: "%04d", year) // Yılı dört haneli bir string olarak al
            let dayOfWeek = findDayOfWeek(for: dateBugun)
             
             print("Gün: \(dayString)")
             print("Ay: \(monthString)")
             print("Yıl: \(yearString)")
            
            gunAdLabel.text = dayOfWeek
            ayLabel.text = monthString
            yilLabel.text = yearString
            gunLabel.text = dayString
            
            
            let dayOfWeek2 = findDayOfWeek(for: dateBugun)
            
         /*   let dayOfWeekFormatter = DateFormatter()
            dayOfWeekFormatter.locale = Locale(identifier: preferredLanguage)
            dayOfWeekFormatter.dateFormat = "EEEE"
            let dayOfWeekString = dayOfWeekFormatter.string(from: dateBugun)
            print(dayOfWeekString)
            print(dayOfWeek2)
            gunAdLabel.text = dayOfWeekString*/
            

             
         }*/
        

    }
    
    
    let calendarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        

        return view
    }()
    
    
    let gunAdLabel: UILabel = {
        let label = UILabel()
        label.text = "Pazartesi"
        label.textAlignment = .center
        label.textColor = .white

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ayLabel: UILabel = {
        let label = UILabel()
        label.text = "Ekim"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let gunLabel: UILabel = {
        let label = UILabel()
        label.text = "23"
        label.textAlignment = .center

        label.font = UIFont.systemFont(ofSize: 65)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let yilLabel: UILabel = {
        let label = UILabel()
        label.text = "2023"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gunLabelBackGround: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let takvimUstBackGround: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 147/255, green: 225/255, blue: 229/255, alpha: 1)
        return view
    }()

    
    
    

    
    
    var selectedStartDate: Date?
    var selectedEndDate: Date?


    var selectedDate: Date = Date()
    

    
 

    

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date
            print(selectedDate)
            
          //  tarihSecildiMi = true
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormatter.string(from: selectedDate)
            print(formattedDate)
          //  tarihTextButton.setTitle(formattedDate, for: .normal)
            //calendar.isHidden = true
            
            
             let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: selectedDate)
            

             
            if let day = components.day, let month = components.month, let year = components.year {
                 let dayString = String(format: "%02d", day) // Günü iki haneli bir string olarak al
                 
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MMMM" // Ayı tam adı olarak almak için "MMMM" formatını kullanın
                let monthString = dateFormatter.string(from: selectedDate)
                 
                 let yearString = String(format: "%04d", year) // Yılı dört haneli bir string olarak al
                let dayOfWeek = findDayOfWeek(for: selectedDate)
                 
                 print("Gün: \(dayString)")
                 print("Ay: \(monthString)")
                 print("Yıl: \(yearString)")
                
                gunLabel.text = dayString
                ayLabel.text = monthString
                yilLabel.text = yearString
                gunAdLabel.text = dayOfWeek
                 
             }
        }
   /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let yOffset = scrollView.contentOffset.y
          
        var parallaxOffset: CGFloat = yOffset / 2.0
        
        let parallaxOffsetAsil: CGFloat = yOffset / 2.0
        
        let maxParallaxOffset: CGFloat = topView.frame.size.height // Örnek: 100 piksel
        
        parallaxOffset = min(parallaxOffset, maxParallaxOffset)

        print("\(parallaxOffset) \(topView.frame.size.height)")
           
        if yOffset >= 0 {
            // UITableView'nin konumunu güncelleyin
            collectionView.transform = CGAffineTransform(translationX: 0, y: -parallaxOffset)
            print("Tamamen gitti1")


 
            
      

            if parallaxOffset <= maxParallaxOffset {
                // Başka bir görünümün konumunu güncelleyin
                print("Tamamen gitti2")
              //  topView.transform = CGAffineTransform(translationX: 0, y: -parallaxOffset)
                backPieChartView.transform = CGAffineTransform(translationX: 0, y: -parallaxOffset)
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            }else{

            }
            
            
        } else {
            // Eğer kullanıcı aşağı doğru sürüklüyorsa, her iki görünümü de sıfırlayın
         //   topView.transform = .identity
            collectionView.transform = .identity
            backPieChartView.transform = .identity
            print("Tamamen gitti3")

        }
    }*/
    
    
    
    func findDayOfWeek(for date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 1:
            return "Sunday".localized()
        case 2:
            return "Monday".localized()
        case 3:
            return "Tuesday".localized()
        case 4:
            return "Wednesday".localized()
        case 5:
            return "Thursday".localized()
        case 6:
            return "Friday".localized()
        case 7:
            return "Saturday".localized()
        default:
            return "Bilinmeyen".localized()
        }
    }
    
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      // view.backgroundColor = .red
        return view
    }()
    
    
    let tamamButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 147/255, green: 225/255, blue: 229/255, alpha: 1)
        button.setTitle("Tamam".localized(), for: .normal)
        button.addTarget(self, action: #selector(iptalTiklandi), for: .touchUpInside)
       
        return button
        
    }()
    
    let iptalButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 147/255, green: 225/255, blue: 229/255, alpha: 1)
        button.setTitle("İptal".localized(), for: .normal)
        button.addTarget(self, action: #selector(iptalTiklandi), for: .touchUpInside)
      
        return button
    }()
    
    @objc func iptalTiklandi(){
        calendarView.isHidden = true
    }
    

    
    
    
    func calendarSetup(){
        view.addSubview(calendarView)
        calendarcik.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.addSubview(calendarcik)
        calendarView.addSubview(gunLabelBackGround)
        calendarView.addSubview(takvimUstBackGround)
        calendarView.addSubview(gunLabel)
        calendarView.addSubview(ayLabel)
        calendarView.addSubview(yilLabel)
        calendarView.addSubview(iptalButton)
        calendarView.addSubview(tamamButton)
        gunLabelBackGround.addSubview(gunAdLabel)
        
        calendarView.backgroundColor = .white
        calendarView.widthAnchor.constraint(equalToConstant: 2.1*view.frame.size.width/3).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 7*view.frame.height/12).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendarcik.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor).isActive = true
        gunLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 11)
        ayLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 33)
        yilLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 33)
        gunLabelBackGround.anchor(top: calendarView.topAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 15)
        gunAdLabel.anchor(top: gunLabelBackGround.topAnchor, bottom: gunLabelBackGround.bottomAnchor, leading: gunLabelBackGround.leadingAnchor, trailing: gunLabelBackGround.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        takvimUstBackGround.anchor(top: gunLabelBackGround.bottomAnchor, bottom: yilLabel.bottomAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        ayLabel.anchor(top: gunLabelBackGround.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 2.5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        gunLabel.anchor(top: ayLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        yilLabel.anchor(top: gunLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: -5, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)

        calendarcik.anchor(top: takvimUstBackGround.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3*view.frame.size.height / 8 - view.frame.size.height / 25)
        tamamButton.anchor(top: calendarcik.bottomAnchor, bottom: nil, leading: nil, trailing: calendarView.trailingAnchor, paddingTop: -5, paddingBottom: 0, paddingLeft: 0, paddingRight: -10, width: 0, height: 0)
        iptalButton.anchor(top: tamamButton.topAnchor, bottom: nil, leading: nil, trailing: tamamButton.leadingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 0, height: 0)
        
        calendarView.isHidden = true
    }
    
    
    
    let noDataView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    let backView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        return view
    }()
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        view.addSubview(backView)
        backView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        calendarcik.delegate = self
        calendarcik.dataSource = self
        calendarcik.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")

        self.navigationController?.navigationBar.prefersLargeTitles = true

        tabBarController?.tabBar.backgroundColor =  UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)//UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 0.8)

        
       // collectionView.isHidden = true
        
        calendarView.isHidden = true

            calendarcik.allowsMultipleSelection = true
         calendarcik.scope = .month
        
         calendarcik.headerHeight = 50
         calendarcik.appearance.headerTitleColor = .black
         calendarcik.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 20)
         calendarcik.appearance.weekdayTextColor = .red
         calendarcik.appearance.todayColor = .red
         calendarcik.appearance.selectionColor = .purple
         calendarcik.appearance.borderRadius = 0.4
         calendarcik.scrollDirection = .horizontal
         calendarcik.allowsSelection = true
         calendarcik.allowsMultipleSelection = false
        // calendarcik.swipeToChooseGesture.isEnabled = true
        

      //  collectionView.bounces = false
    
        
     
        
        view.addSubview(topView)
        
        
        
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 60)
        
        
        topView.addSubview(expensesTodayButton)
        topView.addSubview(expensesOneWeekButton)
        topView.addSubview(expensesOneMonthButton)
        topView.addSubview(expensesOneYearButton)
        topView.addSubview(takvimButton)
        
 
       
        view.addSubview(collectionView)
        view.addSubview(backPieChartView)
        view.addSubview(backCollectionView)
        calendarSetup()
       /* view.addSubview(calendarView)
        calendarcik.translatesAutoresizingMaskIntoConstraints = false
        calendarView.addSubview(calendarcik)

        calendarView.addSubview(gunLabelBackGround)
        calendarView.addSubview(takvimUstBackGround)
        calendarView.addSubview(gunLabel)
        calendarView.addSubview(ayLabel)
        calendarView.addSubview(yilLabel)
        
        gunLabelBackGround.addSubview(gunAdLabel)

        calendarView.backgroundColor = .white
        calendarView.widthAnchor.constraint(equalToConstant: 2.1*view.frame.size.width/3).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 7*view.frame.height/12).isActive = true
        calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendarcik.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor).isActive = true
        gunLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 10)
        ayLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 30)
        yilLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 30)
        gunLabelBackGround.anchor(top: calendarView.topAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 15)
        gunAdLabel.anchor(top: gunLabelBackGround.topAnchor, bottom: gunLabelBackGround.bottomAnchor, leading: gunLabelBackGround.leadingAnchor, trailing: gunLabelBackGround.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        takvimUstBackGround.anchor(top: gunLabelBackGround.bottomAnchor, bottom: calendarcik.topAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        ayLabel.anchor(top: gunLabelBackGround.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        gunLabel.anchor(top: ayLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        yilLabel.anchor(top: gunLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 5, paddingBottom: -5, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)

        calendarcik.anchor(top: nil, bottom: calendarView.bottomAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3*view.frame.size.height / 8 - view.frame.size.height / 25)*/
        
        
        backPieChartView.addSubview(pieChart)
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        

        
        collectionView.register(PieChartCollectionViewCell.self, forCellWithReuseIdentifier: "pieChartCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        expensesTodayButton.anchor(top: topView.topAnchor, bottom: nil, leading: topView.leadingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 6, paddingRight: -5, width: view.frame.size.width / 5 - 5, height: 50)
        expensesOneWeekButton.anchor(top: topView.topAnchor, bottom: nil, leading: expensesTodayButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: view.frame.size.width / 5 - 7.5, height: 50)
        expensesOneMonthButton.anchor(top: topView.topAnchor, bottom: nil, leading: expensesOneWeekButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: view.frame.size.width / 5 - 7.5, height: 50)
        expensesOneYearButton.anchor(top: topView.topAnchor, bottom: nil, leading: expensesOneMonthButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: view.frame.size.width / 5 - 7.5, height: 50)
        takvimButton.anchor(top: topView.topAnchor, bottom: nil, leading: expensesOneYearButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: view.frame.size.width / 5 - 5, height: 50)
        

      
        backPieChartView.anchor(top: topView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: self.view.frame.size.width*0.66)
        
        pieChart.backgroundColor = UIColor.clear
    
      //  backPieChartView.backgroundColor = .red
        
        pieChart.anchor(top: backPieChartView.topAnchor, bottom: backPieChartView.bottomAnchor, leading: backPieChartView.leadingAnchor, trailing: backPieChartView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0 , height: 0)
       
        
        //pieChart.extraBottomOffset = 10
      //  pieChart.extraLeftOffset = 15
        pieChart.extraTopOffset = 6
        pieChart.extraBottomOffset = 8
        pieChart.drawCenterTextEnabled = true
       
        
        
       // collectionView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 209/255, alpha: 1)
        
        collectionView.anchor(top: backPieChartView.bottomAnchor, bottom: view.lastBaselineAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, width: 0, height: 0)
        //collectionView.anchor(top: backPieChartView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, width: 0, height: 0)
        
        
        
        ///Datanın getirilmesi
        //fetchDatas()
        fetchByDate(date: 1)
        fetchPieChart()
        
        view.addSubview(noDataView)
        noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.size.height/6).isActive = true
        noDataView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 200)
        let labelNoData: UILabel = {
            let labelNoData = UILabel()
            labelNoData.font = .italicSystemFont(ofSize: 20)
            labelNoData.text = "No transactions were found".localized()
            labelNoData.textAlignment = .center
            labelNoData.translatesAutoresizingMaskIntoConstraints = false
            return labelNoData
        }()
        let noDataImage: UIImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "doc.text.magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        noDataView.addSubview(labelNoData)
        noDataView.addSubview(noDataImage)
        
        noDataImage.anchor(top: noDataView.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 60, height: 60)
        noDataImage.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        labelNoData.anchor(top: noDataImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        
        

        
        pieChart.delegate = self
        selectedIntervalDate = "Day"
       // pieChart.backgroundColor = .cyan
        
      
        collectionView.backgroundColor = .clear
       // collectionView.layer.shadowColor = UIColor.lightGray.cgColor
       // collectionView.layer.shadowRadius = 3
       // collectionView.layer.shadowOpacity = 1
       
        self.view.bringSubviewToFront(topView)
        
        
        //ChangeObserver
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
               fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
               
               fetchedResultsController = NSFetchedResultsController(
                   fetchRequest: fetchRequest,
                   managedObjectContext: context,
                   sectionNameKeyPath: nil,
                   cacheName: nil
               )
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Hata: Veri getirme hatası - \(error)")
        }
        
        
        
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchByDate(date: timeNumber)
        
        fetchPieChart()
        
        pieChart.notifyDataSetChanged()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController<Tracker>!

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
      //  print("aaa")
       // fetchDatas()
 
        
        
        /*fetchByDate(date: timeNumber)
        
        fetchPieChart()
        
        pieChart.notifyDataSetChanged()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }*/
        
        
        
        //fetchDatas()
        
       // self.pieChart.reloadInputViews()
        /*var entries: [ChartDataEntry] = []

        //var entry: ChartDataEntry?
        
        
        for (category, totalExpense) in categoryExpenses {
            
          //  print(totalExpense/percentTotal)
            
           let percentage = (totalExpense / percentTotal) * 100.0
            
            entries.append(PieChartDataEntry(value: Double(percentage), label: category))
            

        }
        


        

        let dataSet = PieChartDataSet(entries: entries)
        
        
        
        
        
        
        let data = PieChartData(dataSet: dataSet)
        

        dataSet.colors = ChartColorTemplates.colorful()
        


        self.pieChart.data = data


        self.pieChart.drawHoleEnabled = false
        
        dataSet.colors = ChartColorTemplates.material()
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLineWidth = 1
       // dataSet.yValuePosition = .outsideSlice
        dataSet.automaticallyDisableSliceSpacing = true
        dataSet.sliceSpace = 7
        dataSet.formLineWidth = 20
        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 10)
        dataSet.valueTextColor = .black*/


        
    }
    
    
   /* override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
       /* pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        
        fetchDatas()
        
        var entries = [ChartDataEntry]()
        
        
        
        for data in dataPoints {
            entries.append(PieChartDataEntry(value: Double(data.value), label: data.label))
        }

        let dataSet = PieChartDataSet(entries: entries, label: "My Chart")
        let data = PieChartData(dataSet: dataSet)
        
        
        
        
        
        pieChart.data = data*/
        


   

        // Veri noktalarını grafik veri setine ekleyin
        var entries: [ChartDataEntry] = []

       /* for data in dataPoints {
            entries.append(PieChartDataEntry(value: Double(data.value), label: data.label))
        }*/
        
  
        
        for (category, totalExpense) in categoryExpenses {
            
           // print(totalExpense/percentTotal)
            
           let percentage = (totalExpense / percentTotal) * 100.0
            
            
            
            
            entries.append(PieChartDataEntry(value: Double(percentage), label: category))
            
            categories.append(Category(category: category, totalExpenses: totalExpense, percentage: percentage))
            
        }
        
        
      //  print(categoryExpenses.keys)
        
        

        let dataSet = PieChartDataSet(entries: entries, label: "My Chart")
        
        
        
        dataSet.label = ""
        
      //  let colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.gray, UIColor.cyan, UIColor.black]
        

        let data = PieChartData(dataSet: dataSet)
        
        
        //dataSet.setColors(NSUIColor.red, NSUIColor.black, NSUIColor.cyan)
        
     //   dataSet.colors = ChartColorTemplates.material()
        
     //   dataSet.colors = colors
        

        
        dataSet.xValuePosition = .outsideSlice
       // dataSet.yValuePosition = .outsideSlice
      //  dataSet.automaticallyDisableSliceSpacing = true
        dataSet.sliceSpace = 7
        dataSet.formLineWidth = 20
        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 10)
        dataSet.valueTextColor = .black
        pieChart.legend.enabled = false

        
        
       //  pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
  
        pieChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       // pieChart.center = view.center
         view.addSubview(pieChart)

        // Grafiği veriyle doldurun
        self.pieChart.data = data

        // İsteğe bağlı olarak diğer grafik ayarlarını yapılandırabilirsiniz
        self.pieChart.drawHoleEnabled = false

        // Grafiği görüntülemek için uygun bir yere ekleyin
        // Örneğin, bir view controller'ın view'ına eklemek isterseniz:
        // self.view.addSubview(chartView)

        
        print(categories)
        
        
    }*/
    
    
    var colors: [UIColor] = []
    
    struct Category{
        
        var category: String
        var totalExpenses: Float
        var percentage: Float
        
    }
    
    

    func fetchPieChart() {
        var entries: [ChartDataEntry] = []
        colors = []
        categories = []
        var sayi: Float = 0.0
        
        
        // Buralar olmayabilirdi
        let sortedExpenses = categoryExpenses.sorted { $0.value > $1.value }
        let sortedCategoryExpenses = Dictionary(uniqueKeysWithValues: sortedExpenses)
       //
       // print(sortedCategoryExpenses)
        print(sortedExpenses)
        
                                    //categoryExpenses
        for (category, totalExpense) in sortedExpenses {
            let percentage = (totalExpense / percentTotal) * 100.0
            
            /*if percentage < 1.5{
                entries.append(PieChartDataEntry(value: Double(1.5), label: "\(category)".localized()))
                sayi = Float(1.5) - percentage

            }else if percentage > 1.5 && percentage < 3 {
                entries.append(PieChartDataEntry(value: Double(percentage - sayi), label: "\(category)".localized()))
            }else{
                entries.append(PieChartDataEntry(value: Double(percentage - sayi - 1.5), label: "\(category)".localized()))
                sayi = 0
                
            }*/
            if percentage > 1.5{
                entries.append(PieChartDataEntry(value: Double(percentage), label: "\(category)".localized()))
                
                
            }
            
            
            categories.append(Category(category: category, totalExpenses: totalExpense, percentage: percentage))


            var color: UIColor

            // Kategoriye göre renk seçimi
            if category == "Sağlık" {
                color = UIColor(red: 255/255, green: 171/255, blue: 171/255, alpha: 0.5)
            } else if category == "Araba Masrafları"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 212/255, green: 230/255, blue: 223/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Spor"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Ulaşım"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 250/255, green: 229/255, blue: 211/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Evcil Hayvan"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 252/255, green: 243/255, blue: 207/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Alışveriş"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Dışarıda Yemek"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 235/255, green: 222/255, blue: 240/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Ev Harcamaları"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 246/255, green: 221/255, blue: 204/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Giyim"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Tatil"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 217/255, green: 255/255, blue: 255/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Eğitim"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 217/255, green: 221/255, blue: 255/255, alpha: 1)// Diğer renk seçimi
            }else if category == "İş"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 181/255, green: 186/255, blue: 209/255, alpha: 1)// Diğer renk seçimi
            }else if category == "Diğer"{
                // Diğer kategoriler için farklı renkler kullanabilirsiniz
                color = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)// Diğer renk seçimi
            }
            else{
                color = UIColor.white
            }
            
            /*   case "Tatil":
             cell.categoryImage.image = UIImage(named: "calendar")
             cell.categoryBackView.backgroundColor = UIColor(red: 217/255, green: 255/255, blue: 255/255, alpha: 1)
             
         case "Eğitim":
             cell.categoryImage.image = UIImage(named: "mortarboard")
             cell.categoryBackView.backgroundColor = UIColor(red: 217/255, green: 221/255, blue: 255/255, alpha: 1)
         case "İş":
             cell.categoryImage.image = UIImage(named: "working")
             cell.categoryBackView.backgroundColor = UIColor(red: 181/255, green: 186/255, blue: 209/255, alpha: 1)
         case "Diğer":
             cell.categoryImage.image = UIImage(named: "application")
             cell.categoryBackView.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
*/
            if percentage > 1.5{
                colors.append(color)
            }
            
        }
        
        
        categories.sort { $0.percentage > $1.percentage }

      //  print(categories)
        
       /* let entriesForNoLine = entries.filter { entry in
            // Line çubuğunu devre dışı bırakmak istediğiniz koşulları burada belirleyin
            // Örneğin, value değeri 1.5'in altındaysa bu dilimi çizimden hariç tutabilirsiniz
            
            return entry.y > 3
        }

        // entries dizisini yeniden tanımlayın, belirli dilimleri hariç tutun
        entries = entriesForNoLine*/

        // PieChartDataSet'i oluşturun
       // let dataSet = PieChartDataSet(entries: entries, label: "My Chart")
        
        

        let dataSet = PieChartDataSet(entries: entries, label: "My Chart")
        
        dataSet.label = ""
        dataSet.colors = colors
        

        let data = PieChartData(dataSet: dataSet)
        
        
        dataSet.xValuePosition = .outsideSlice
    //    dataSet.yValuePosition = .insideSlice
   //     dataSet.enab
        dataSet.drawValuesEnabled = false
        //dataSet.valueLinePart1OffsetPercentage = 0.65
        dataSet.valueLinePart2Length = 0.4
        dataSet.valueLinePart1Length = 0.7
        
        
        
        

     
        
        dataSet.sliceSpace = 3
       // dataSet.formLineWidth = 20
        dataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        dataSet.valueTextColor = .black
        pieChart.legend.enabled = false
        self.pieChart.data = data
        self.pieChart.drawHoleEnabled = false
    }


    
    
    
    

    
    
    
    
    
    
    var categoryExpenses = [String: Float]() // Kategori bazlı harcamaları tutmak için bir sözlük
 
    
    func fetchDatas(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        categoryExpenses = [:]
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        
        
        
        
        fetchRequest.returnsObjectsAsFaults = false

        
        do{
            
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    guard let moneyEach = result.value(forKey: "privatemoney") as? Float else{return}
                    guard let category = result.value(forKey: "category") as? String else{return}
                    guard let date = result.value(forKey: "date") as? Date else{return}

                    
                 //  print(result)
                    
                    
                    if moneyEach < 0 {
                        if let existingExpense = categoryExpenses[category] {
                            categoryExpenses[category] = existingExpense + moneyEach
                            
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .medium
                        
                            
                            let dateString = dateFormatter.string(from: date)
                         //   print(dateString)
                            
                            
                        } else {                                                //SADECE GİDERLERİN YAPILDIĞI CHART DATA
                            categoryExpenses[category] = moneyEach
                            
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .medium
                        
                            
                            let dateString = dateFormatter.string(from: date)
                         //   print(dateString)
                        }
                    }
                    

                }
            }
            
            
            
            self.percentTotal = 0
            for (category, totalExpense) in categoryExpenses {
              //  print("\(category): \(totalExpense)")
                self.percentTotal += totalExpense

                
                
            }
            
           // print(percentTotal)
        
            
        }catch{
            
        }
    }
    
    
    
    
    func fetchByDate(date: Int){
        
        categoryExpenses = [:]
        

        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        
        
        
       // let sortDecriptors = NSSortDescriptor(key: "privatemoney", ascending: false)
       
        
        
       // fetchRequest.sortDescriptors = [sortDecriptors]
        
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: today) // Günün başlangıcı
        var endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)! // Günün sonu
      
        
        /* do{
            let filteredTasks = try context.fetch(fetchRequest)
            print("kadkfdskgaksd")
            for task in filteredTasks as! [NSManagedObject] {
                guard let category = task.value(forKey: "category") as? String else {return}
                print(category)
                guard let moneyEach = task.value(forKey: "privatemoney") as? Float else {return}
                print(moneyEach)

                guard let date = task.value(forKey: "date") as? Date else {return}
                print(date)
                
                
            }
            print("kadkfdskgaksd")
            
        }catch{
            print("absadkgdas")
        }*/

    

        switch date{
            
        case 1:
         //   print("aaaaaaaaa")
            endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        case 2:
         //   print("bbbbbbbb")

              let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: startOfDay)!
                endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
              //  print(oneWeekAgo)
              fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", oneWeekAgo as NSDate, endOfDay as NSDate)
        case 3:
            let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: startOfDay)!
          //  print(oneMonthAgo)
            endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", oneMonthAgo as NSDate, endOfDay as NSDate)
        case 4:
           
            let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: startOfDay)!
        //    print(oneYearAgo)
            endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", oneYearAgo as NSDate, endOfDay as NSDate)
     
            
        default:
            print("All")
        }
        
        
        fetchRequest.returnsObjectsAsFaults = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
    
        
    //   print("AEvet")
        
        
      //  guard let date = date else{return}
        

        
        
        
        //fetchRequest.predicate = NSPredicate(format: "date = %@", dateString)
        
        

        
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            
            let filteredTasks = try context.fetch(fetchRequest)
            for task in filteredTasks as! [NSManagedObject] {
                
               // print(task)
                
                guard let category = task.value(forKey: "category") as? String else {return}
              //  print(category)
                guard let moneyEach = task.value(forKey: "privatemoney") as? Float else {return}
              //  print(moneyEach)

                guard let date = task.value(forKey: "date") as? Date else {return}
             //   print(date)

               
                
             //   print(date)

               // print(date)
                let dateString = dateFormatter.string(from: date)
               // print(dateString)
                
               // print(category)
                
                
                if moneyEach < 0 {
                    if let existingExpense = categoryExpenses[category] {
                        categoryExpenses[category] = existingExpense + moneyEach
                     //   print(date)
                    } else {                                                //SADECE GİDERLERİN YAPILDIĞI CHART DATA
                        categoryExpenses[category] = moneyEach
                   //     print(date)
                    }
                }
              
                
                
            }
            
            self.percentTotal = 0
            for (category, totalExpense) in categoryExpenses {
              //  print("\(category): \(totalExpense)")
                self.percentTotal += totalExpense
                
            }
   
        } catch {
            print("Veri çekilemedi: \(error)")
        }
        
        
        if categoryExpenses.isEmpty{
            noDataView.isHidden = false
        }else{
            noDataView.isHidden = true
        }
    
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}


extension PieChartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VC = EachCategoryViewController()
        print(categories[indexPath.row].category)
        VC.category = categories[indexPath.row].category
        VC.chosenInterval = selectedIntervalDate
        VC.title = categories[indexPath.row].category.localized()
        
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieChartCell", for: indexPath) as? PieChartCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        
        
        let categoryEach = categories[indexPath.row].category
            
        switch categoryEach{
        case "Sağlık":
          //  print("Sağlık")
           // cell.categoryView.image = UIImage(systemName: "stethoscope")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "healthcare")
            cell.categoryBackView.backgroundColor = UIColor(red: 255/255, green: 171/255, blue: 171/255, alpha: 0.5)
        case "Araba Masrafları":
          //  print("Araba Masrafları")
            //cell.categoryView.image = UIImage(systemName: "car")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "car")
            cell.categoryBackView.backgroundColor = UIColor(red: 212/255, green: 230/255, blue: 223/255, alpha: 1)

        case "Ev Harcamaları":
          //  print("Ev Harcamaları")
          //  cell.categoryView.image = UIImage(systemName: "house")?.withTintColor(.systemBrown, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "home")
            cell.categoryBackView.backgroundColor = UIColor(red: 246/255, green: 221/255, blue: 204/255, alpha: 1)

        case "Evcil Hayvan":
          //  print("Evcil Hayvan")
          //  cell.categoryView.image = UIImage(systemName: "pawprint")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "pet")
            cell.categoryBackView.backgroundColor = UIColor(red: 252/255, green: 243/255, blue: 207/255, alpha: 1)

        case "Ulaşım":
          //  print("Ulaşım")
         //   cell.categoryView.image = UIImage(systemName: "bus.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "bus")
            cell.categoryBackView.backgroundColor = UIColor(red: 250/255, green: 229/255, blue: 211/255, alpha: 1)

        case "Dışarıda Yemek":
          //  print("Dışarıda Yemek")
         //   cell.categoryView.image = UIImage(systemName: "fork.knife.circle")?.withTintColor(.magenta, renderingMode: .alwaysOriginal)
            cell.categoryBackView.backgroundColor = UIColor(red: 235/255, green: 222/255, blue: 240/255, alpha: 1)
            cell.categoryImage.image = UIImage(named: "cutlery")

        case "Spor":
         //   print("Spor")
         //   cell.categoryView.image = UIImage(systemName: "figure.handball")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "sports")
            cell.categoryBackView.backgroundColor = UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 1)

        case "Giyim":
          //  print("Giyim")
         //   cell.categoryView.image = UIImage(systemName: "tshirt.fill")?.withTintColor(.purple, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "shirt")
            cell.categoryBackView.backgroundColor = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1)

        case "Alışveriş":
           // print("Alışvreriş")
         //   cell.categoryView.image = UIImage(systemName: "cart")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            cell.categoryImage.image = UIImage(named: "trolley")
            cell.categoryBackView.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
        
        case "Tatil":
            cell.categoryImage.image = UIImage(named: "calendar")
            cell.categoryBackView.backgroundColor = UIColor(red: 217/255, green: 255/255, blue: 255/255, alpha: 1)
            
        case "Eğitim":
            cell.categoryImage.image = UIImage(named: "mortarboard")
            cell.categoryBackView.backgroundColor = UIColor(red: 217/255, green: 221/255, blue: 255/255, alpha: 1)
        case "İş":
            cell.categoryImage.image = UIImage(named: "working")
            cell.categoryBackView.backgroundColor = UIColor(red: 181/255, green: 186/255, blue: 209/255, alpha: 1)
        case "Diğer":
            cell.categoryImage.image = UIImage(named: "application")
            cell.categoryBackView.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)

        default:
           // print("Öylesine")
            
            
            //Burayı ayarla///
            //Burayı ayarla///

            //Burayı ayarla///

            //Burayı ayarla///

            cell.categoryImage.image = UIImage(systemName: "stethoscope.circle")
        }
    
        
            let stringTotalExpense = String(format: "%.2f", categories[indexPath.row].totalExpenses)
            cell.totalExpense.text = stringTotalExpense
            let formattedString = String(format: "%.2f", categories[indexPath.row].percentage)
            cell.percentageLabel.text = "%\(formattedString)"
            let categoryLanguage = categories[indexPath.row].category
            cell.categoryLabel.text = categoryLanguage.localized()
           // cell.categoryBackView.backgroundColor = colors[indexPath.row]
        

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    
    
    
    
    
    
}










extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
