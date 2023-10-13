//
//  oylesineViewController.swift
//  ExpenseTracker
//
//  Created by Erkan on 30.08.2023.
//

import UIKit
import CoreData

class oylesineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{

    var fetchedResultsController: NSFetchedResultsController<Tracker>!


         let tableView1: UITableView = {
            let tableView = UITableView()
             tableView.bounces = false
             tableView.scrollsToTop = true
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
    
    

    
    
    var expensesByDate: [String: [Tracker]] = [:]
    var staredTracks: [savedTrack] = []

    
  /*  lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tracker")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading Core Data stores: \(error)")
            }
        }
        return container
    }()*/
    
    var yeniSon: [String: [Tracker]] = [:]
    var totalExpensesByDate: [String: Float] = [:]
    var chosenRow: String = ""
    var selectedInterval: String = "All"
    
    var gelir: Float = 0.0
    var gider: Float = 0.0
    
    func fetchExpenses(chosenRow: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
       // let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
           
           // Tarih aralığını sınırlamak için bir NSPredicate oluşturun
        //let datePredicate = NSPredicate(format: "date >= %@", oneWeekAgo! as NSDate)
       // fetchRequest.predicate = datePredicate
        //let moneySortDescriptor = NSSortDescriptor(key: "privatemoney", ascending: false)
        
        gelir = 0
        gider = 0
        
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
                    dateFormatter.dateFormat = "MM-dd-yyyy" // İstediğiniz tarih formatına uygun olarak değiştirin
                  //  dateFormatter.dateStyle = .long
                    let dateString = dateFormatter.string(from: date)
                    if expensesByDate[dateString] == nil {
                        expensesByDate[dateString] = []
                        print(dateString)
                    }
                   
      
                    if expense.privatemoney > 0{
                        gelir += expense.privatemoney
                    }else{
                        gider += expense.privatemoney

                    }
                    
                    
                  //  print(expensesByDate)
                    expensesByDate[dateString]?.append(expense)
                    
                    
                }
            }
            
          //  tableView1.reloadData()
            var sayac = 0
            

            
            
            for (dateString, expenses) in expensesByDate {
                let totalExpense = expenses.reduce(into: 0.0) { result, expense in
                    result += expense.privatemoney
                }
                totalExpensesByDate[dateString] = totalExpense
            }
            
            gelirTextLabel.text = "\(gelir)"
            giderTextLabel.text = "\(-gider)"
            totalMoneyTextLabel.text = "\(gider+gelir)"
          
            DispatchQueue.main.async {
                self.tableView1.reloadData()

            }
        } catch {
            print("Error fetching expenses: \(error)")
        }
    }
    
    

    
    
    
    func configureTableView(){

        view.addSubview(tableView1)

         tableView1.dataSource = self
         tableView1.delegate = self
        
        

        tableView1.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView1.sectionHeaderTopPadding = 10

        tableView1.anchor(top: topView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        tableView1.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        // UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
        //UIColor(red: 251/255, green: 252/255, blue: 255/255, alpha: 1)
        //UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1) //UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
    }
    
    
    
    
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    let gelirLabel: UILabel = {
       let label = UILabel()
        label.text = "Income".localized()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let gelirTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Income".localized()
        label.textColor = UIColor(red: 101/255, green: 190/255, blue: 139/255, alpha: 1)
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let giderLabel: UILabel = {
       let label = UILabel()
        label.text = "Expense".localized()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let giderTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Income"
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalMoneyLabel: UILabel = {
       let label = UILabel()
        label.text = "Total".localized()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalMoneyTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Income"
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 16)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    let ayracUst = UIView()
    let ayracAlt = UIView()
    func topViewConfigure(){
        ayracUst.isHidden = true
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        view.addSubview(topView)
        topView.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 245/255, alpha: 1)
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/19)
        topView.addSubview(gelirLabel)
        topView.addSubview(giderLabel)
        topView.addSubview(totalMoneyLabel)
        topView.addSubview(gelirTextLabel)
        topView.addSubview(giderTextLabel)
        topView.addSubview(totalMoneyTextLabel)
        
        
        tabBarController?.tabBar.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)

        
    
        ayracAlt.translatesAutoresizingMaskIntoConstraints = false
        ayracAlt.backgroundColor = .gray
        
       
        ayracUst.translatesAutoresizingMaskIntoConstraints = false
        ayracUst.backgroundColor = .gray
        
        topView.addSubview(ayracAlt)
        topView.addSubview(ayracUst)
        
        ayracAlt.anchor(top: nil, bottom: topView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1)
        ayracUst.anchor(top: topView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1)
        

        gelirLabel.anchor(top: topView.topAnchor, bottom: nil, leading: topView.leadingAnchor, trailing: nil, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)
        gelirTextLabel.anchor(top: gelirLabel.bottomAnchor, bottom: topView.bottomAnchor, leading: gelirLabel.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)
        
        giderLabel.anchor(top: topView.topAnchor, bottom: nil, leading: gelirLabel.trailingAnchor, trailing: nil, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)
        giderTextLabel.anchor(top: giderLabel.bottomAnchor, bottom: topView.bottomAnchor, leading: giderLabel.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)
        
        totalMoneyLabel.anchor(top: topView.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)
        totalMoneyTextLabel.anchor(top: totalMoneyLabel.bottomAnchor, bottom: topView.bottomAnchor, leading: nil, trailing: totalMoneyLabel.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: view.frame.size.width/3, height: 0)

    }
    
    
    let tableViewSirala: UITableView = {
        let tableView2 = UITableView()
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        tableView2.bounces = false
        return tableView2
    }()
    
 
    
    
    
    var siralamaListesi = ["Daily", "Weekly", "Monthly", "Yearly"]
    override func viewDidLoad() {
            super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        //UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
        //UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
      //  tableView1.bounces = false
       // self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "All Transactions".localized()
        
      /*  if let navigationBar = navigationController?.navigationBar {
            // Arka plan resmini yeşil bir resim veya renk olarak ayarlayın
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            //navigationBar.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
            // UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
            //UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            
            // Gölgeleri kaldırın (isteğe bağlı)
            navigationBar.shadowImage = UIImage()
            
            // Metin rengini beyaz olarak ayarlayın (isteğe bağlı)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            
            // Geri düğmesi rengini beyaz olarak ayarlayın (isteğe bağlı)
          //  navigationBar.tintColor = UIColor.white
        }*/
    
        
        
        fetchExpenses(chosenRow: "All")
        topViewConfigure()
        
        gelirTextLabel.text = "\(gelir)"
        giderTextLabel.text = "\(gider)"
        totalMoneyTextLabel.text = "\(gider+gelir)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(filtreleme))
       
        tableViewSirala.delegate = self
        tableViewSirala.dataSource = self
        configureTableView()
        tableViewSirala.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")

        view.addSubview(tableViewSirala)
        tableViewSirala.backgroundColor = .red
        tableViewSirala.sectionHeaderTopPadding = 0
        tableViewSirala.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 2*view.frame.size.width/3 , height: 3*view.frame.size.height/10)
        tableViewSirala.isHidden = true
        
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
    
 
    
    var filterAcikMi = false
    
    @objc func filtreleme(){
        
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0

        
        let startingFrame = CGRect(x: view.frame.width,
                                    y: navigationBarHeight,
                                    width: tableViewSirala.frame.width,
                                    height: tableViewSirala.frame.height)
        let endingFrame = tableViewSirala.frame
        
        // Animasyon için yeni bir görünüm oluşturun ve başlangıç konumunu ayarlayın
        let animatedView = UIView(frame: startingFrame)
        animatedView.backgroundColor = .white
        view.addSubview(animatedView)
        
        if filterAcikMi == false{
            UIView.animate(withDuration: 0.1, animations: {
                // Yeni görünümü bitiş konumuna taşıyın
                animatedView.frame = endingFrame
            }) { _ in
                // Animasyon tamamlandığında yeni görünümü kaldırın ve tableView'ı görünür yapın
                animatedView.removeFromSuperview()
                self.tableViewSirala.isHidden = !self.filterAcikMi
            }
            
            // filterAcikMi durumunu tersine çevirin
            filterAcikMi = !filterAcikMi
        } else{
            tableViewSirala.isHidden = true
            filterAcikMi = !filterAcikMi
        }
        


    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // print(scrollView.contentOffset.y)
        let yOffset = scrollView.contentOffset.y
          
        var parallaxOffset: CGFloat = yOffset / 2.0
        
        let parallaxOffsetAsil: CGFloat = yOffset / 2.0
        
        let maxParallaxOffset: CGFloat = topView.frame.size.height // Örnek: 100 piksel
        
        parallaxOffset = min(parallaxOffset, maxParallaxOffset)

       // print("\(parallaxOffset) \(topView.frame.size.height)")
           
        
        if yOffset >= 0 {
            // UITableView'nin konumunu güncelleyin
            tableView1.transform = CGAffineTransform(translationX: 0, y: -parallaxOffset)
         //   print("Tamamen gitti1")

          //  print(yOffset)
            if yOffset >= 50{
                ayracUst.isHidden = true
            }else{
                ayracUst.isHidden = true

            }

            
            
            topView.isHidden = false

            if parallaxOffset < maxParallaxOffset {
                // Başka bir görünümün konumunu güncelleyin
               // print("Tamamen gitti2")
                topView.transform = CGAffineTransform(translationX: 0, y: -parallaxOffset)
            }else{
               // topView.isHidden = true
            }
            
            
        } else {
            // Eğer kullanıcı aşağı doğru sürüklüyorsa, her iki görünümü de sıfırlayın
            topView.transform = .identity
            tableView1.transform = .identity
           // print("Tamamen gitti3")

        }
        
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        let viewHeightFraction = view.frame.size.height / 15
        let itemCountFactor = expensesByDate.count+1 * 5
        
        


        let yOffsetLimit = CGFloat(contentHeight) - frameHeight //+ viewHeightFraction - CGFloat(itemCountFactor)

      

        /*if yOffset >= yOffsetLimit {
            print("aa")
            //scrollView.setContentOffset(CGPoint(x: 0, y: yOffsetLimit), animated: false)
            //tableView1.isScrollEnabled = false
            if expensesByDate.keys.count < 5{
                tableView1.isScrollEnabled = false
            }
        }*/

        
        
   
        
        
    }
    
    
    //SECTIONS
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView{
        case tableView1:
            return expensesByDate.keys.count
        case tableViewSirala:
            return 1
        default:
            return 0
        }
        }
        
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedDates = expensesByDate.keys.sorted(by: >)
        return sortedDates[section]
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView{
        case tableView1:
            return view.frame.size.height/15
        case tableViewSirala:
            return 0
        default:
            return 0
        }
    }
    
    
    

    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
     
        switch tableView{
        case tableViewSirala:
            return nil
        case tableView1:
         //   print(expensesByDate)
            
            let sortedDates = expensesByDate.keys.sorted(by: >)
            let dateString = sortedDates[section]
            var dateGosterilecek = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateStyle = .long
                let formattedDate = dateFormatter.string(from: date)
                print(formattedDate) // Bu, "01 Ekim 2023" çıktısını verecektir
                dateGosterilecek = formattedDate
            } else {
                print("Geçersiz tarih biçimi")
            }
            
            
            
            
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)) // Başlık görünümünün boyutunu ve konumunu ayarlayın
          //  headerView.layer.cornerRadius = 15
           // headerView.layer.cornerRadius = 15
      //          headerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 5).isActive = true
         //       headerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -5).isActive = true

          //  headerView.backgroundColor = .black
                
            
   
                headerView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)  //UIColor(red: 255/255, green: 250/255, blue: 245/255, alpha: 1)
            //UIColor(red: 208/255, green: 204/255, blue: 208/255, alpha: 1)
            //UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)// Başlık görünümünün arka plan rengini ayarlayın

           
            
                
        
            let label = UILabel() // Başlık metni için bir etiket oluşturun
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = dateGosterilecek
            headerView.addSubview(label)
            label.anchor(top: nil, bottom: nil, leading: headerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
                
           
                
            let totalMoneyByDateLabel = UILabel() // Başlık metni için bir etiket oluşturun
            totalMoneyByDateLabel.textAlignment = .right
            totalMoneyByDateLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(totalMoneyByDateLabel)
            
            totalMoneyByDateLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: headerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: -10, width: 0, height: 0)
            totalMoneyByDateLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            
            let sortedDates2 = expensesByDate.keys.sorted(by: >)
            let dateString2 = sortedDates2[section]
            
         //   print(dateString2)
            
            if let totalMoneyFloat = totalExpensesByDate[dateString2] {
                if totalMoneyFloat < 0{
                    totalMoneyByDateLabel.textColor = .red
                }else if totalMoneyFloat == 0{
                    totalMoneyByDateLabel.textColor = .lightGray
                }
                else{
                    totalMoneyByDateLabel.textColor = UIColor(red: 101/255, green: 190/255, blue: 139/255, alpha: 1)
                }
                let totalMoneyString = String(totalMoneyFloat)
                totalMoneyByDateLabel.text = "$\(totalMoneyString)"
            }
            return headerView
        default:
            break
        }
        
        
        
        // Başlık görünümünü döndürün
        
        return UIView()
        
    }
    
    
    
    
    
    
    
    
    //CELLLER
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch tableView{
            case tableViewSirala:
                return siralamaListesi.count
            case tableView1:
                let sortedDates = expensesByDate.keys.sorted(by: >)
                let date = sortedDates[section]
                return expensesByDate[date]?.count ?? 0
            default:
                return 0
            }


        }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView{
        case tableView1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
            
            let sortedDates = expensesByDate.keys.sorted(by: >)
            let date = sortedDates[indexPath.section]
            
            if let expense = expensesByDate[date]?[indexPath.row] {
                if expense.privatemoney > 0{
                    cell.moneyLabel.textColor =  UIColor(red: 101/255, green: 190/255, blue: 139/255, alpha: 1)
                    cell.moneyLabel.text = "\(expense.privatemoney)"
                    gelir += expense.privatemoney
                }else{
                    cell.moneyLabel.textColor = .red
                    cell.moneyLabel.text = "$\(-expense.privatemoney)"
                    gider += expense.privatemoney
                }
                if expense.note == ""{
                    cell.noteLabel.text = "Not yok"
                    cell.noteLabel.textColor = .lightGray
                }else{
                    cell.noteLabel.textColor = .black
                    cell.noteLabel.text = expense.note
                }
                
                if let categoryEach = expense.category{
                    cell.categoryLabel.text = "\(categoryEach)"
                    
                    
                    /*  kategorImages = ["stethoscope.circle", "car", "house", "pawprint", "bus.fill", "fork.knife.circle", "figure.handball", "tshirt", "cart.circle"]
                     
                     
                     
                     kategoriArray = ["Sağlık", "Araba Masrafları","Ev Harcamaları", "Evcil Hayvan", "Ulaşım", "Dışarıda Yemek", "Spor", "Giyim", "Alışvreriş"]*/
                    
                    
                    
                    switch categoryEach{
                    case "Sağlık":
                      //  print("Sağlık")
                       // cell.categoryView.image = UIImage(systemName: "stethoscope")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "healthcare")
                        cell.cellBackground.backgroundColor = UIColor(red: 255/255, green: 171/255, blue: 171/255, alpha: 0.5)
                    case "Araba Masrafları":
                      //  print("Araba Masrafları")
                        //cell.categoryView.image = UIImage(systemName: "car")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "car")
                        cell.cellBackground.backgroundColor = UIColor(red: 212/255, green: 230/255, blue: 223/255, alpha: 1)

                    case "Ev Harcamaları":
                      //  print("Ev Harcamaları")
                      //  cell.categoryView.image = UIImage(systemName: "house")?.withTintColor(.systemBrown, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "home")
                        cell.cellBackground.backgroundColor = UIColor(red: 246/255, green: 221/255, blue: 204/255, alpha: 1)

                    case "Evcil Hayvan":
                      //  print("Evcil Hayvan")
                      //  cell.categoryView.image = UIImage(systemName: "pawprint")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "pet")
                        cell.cellBackground.backgroundColor = UIColor(red: 252/255, green: 243/255, blue: 207/255, alpha: 1)

                    case "Ulaşım":
                      //  print("Ulaşım")
                     //   cell.categoryView.image = UIImage(systemName: "bus.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "bus")
                        cell.cellBackground.backgroundColor = UIColor(red: 250/255, green: 229/255, blue: 211/255, alpha: 1)

                    case "Dışarıda Yemek":
                      //  print("Dışarıda Yemek")
                     //   cell.categoryView.image = UIImage(systemName: "fork.knife.circle")?.withTintColor(.magenta, renderingMode: .alwaysOriginal)
                        cell.cellBackground.backgroundColor = UIColor(red: 235/255, green: 222/255, blue: 240/255, alpha: 1)
                        cell.categoryView.image = UIImage(named: "cutlery")

                    case "Spor":
                     //   print("Spor")
                     //   cell.categoryView.image = UIImage(systemName: "figure.handball")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "sports")
                        cell.cellBackground.backgroundColor = UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 1)

                    case "Giyim":
                      //  print("Giyim")
                     //   cell.categoryView.image = UIImage(systemName: "tshirt.fill")?.withTintColor(.purple, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "shirt")
                        cell.cellBackground.backgroundColor = UIColor(red: 215/255, green: 189/255, blue: 226/255, alpha: 1)

                    case "Alışveriş":
                       // print("Alışvreriş")
                     //   cell.categoryView.image = UIImage(systemName: "cart")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
                        cell.categoryView.image = UIImage(named: "trolley")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
            
                        
                        
                    case "Tatil":
                        cell.categoryView.image = UIImage(named: "calendar")
                        cell.cellBackground.backgroundColor = UIColor(red: 217/255, green: 255/255, blue: 255/255, alpha: 1)
                    
                    case "Eğitim":
                        cell.categoryView.image = UIImage(named: "mortarboard")
                        cell.cellBackground.backgroundColor = UIColor(red: 217/255, green: 221/255, blue: 255/255, alpha: 1)
                        
                    case "İş":
                        cell.categoryView.image = UIImage(named: "working")
                        cell.cellBackground.backgroundColor = UIColor(red: 181/255, green: 186/255, blue: 209/255, alpha: 1)
                        
                        
                    case "Faiz":
                        cell.categoryView.image = UIImage(named: "interest-rate")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Diğer":
                        cell.categoryView.image = UIImage(named: "application")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Maaş":
                        cell.categoryView.image = UIImage(named: "salary")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Borsa":
                        cell.categoryView.image = UIImage(named: "money-exchange")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Hediye":
                        cell.categoryView.image = UIImage(named: "giftbox")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Ek Gelir":
                        cell.categoryView.image = UIImage(named: "profits")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Harçlık":
                        cell.categoryView.image = UIImage(named: "donation")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                    case "Avans":
                        cell.categoryView.image = UIImage(named: "payment")
                        cell.cellBackground.backgroundColor = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
                        
                    default:
                        print("Öylesine")
                        print(categoryEach)
                        
                        
                        //Burayı ayarla///
                        //Burayı ayarla///

                        //Burayı ayarla///

                        //Burayı ayarla///

                        cell.categoryView.image = UIImage(systemName: "stethoscope.circle")
                    }
                    //cell.categoryView.backgroundColor = .cyan
                }
                
            }
            return cell
            
        case tableViewSirala:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = siralamaListesi[indexPath.row].localized()
            return cell
        default:
            return UITableViewCell()
        }
        

        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let navigationBar = navigationController?.navigationBar {
            // Arka plan resmini yeşil bir resim veya renk olarak ayarlayın
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.backgroundColor =  UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
            //UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            
            // Gölgeleri kaldırın (isteğe bağlı)
            navigationBar.shadowImage = UIImage()
            
            // Metin rengini beyaz olarak ayarlayın (isteğe bağlı)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            
            // Geri düğmesi rengini beyaz olarak ayarlayın (isteğe bağlı)
          //  navigationBar.tintColor = UIColor.white
        }
    }
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView{
        case tableView1:
            let sortedDates = expensesByDate.keys.sorted(by: >)
            let date = sortedDates[indexPath.section]
            print("aaaa")
            
         //   print(sortedDates[indexPath.section])
         
        
            if let expense = expensesByDate[date]?[indexPath.row] {
                
                let VC = ExpensesDetailController()
                VC.category = "All Transactions".localized()
                VC.uuid = expense.id
                navigationController?.pushViewController(VC, animated: true)
                
            }
        case tableViewSirala:
            chosenRow = siralamaListesi[indexPath.row]
            if chosenRow == "Weekly"{
                fetchExpenses(chosenRow: "Weekly")
                selectedInterval = "Weekly"
                title = "Transactions for a week".localized()
                tableView1.isScrollEnabled = true

            }else if chosenRow == "Monthly" {
                fetchExpenses(chosenRow: "Monthly")
                tableView1.isScrollEnabled = true
                title = "Transactions for a month".localized()

                selectedInterval = "Monthly"


            }
            else if chosenRow == "Yearly" {
                fetchExpenses(chosenRow: "Yearly")
                tableView1.isScrollEnabled = true
                title = "Transactions for a year".localized()

                selectedInterval = "Yearly"


            }
            else if chosenRow == "Daily"{
                fetchExpenses(chosenRow: "Daily")
                tableView1.isScrollEnabled = true
                title = "Transactions for a day".localized()

                selectedInterval = "Daily"


            }
            print(chosenRow)
            tableViewSirala.isHidden = true
            
            
            filterAcikMi = false
            
        
            
     
        default:
            break
        }

    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        
        fetchExpenses(chosenRow: selectedInterval)
        
        staredTracks.removeAll()
        fetchStaredTrackes()
        
        
        
        DispatchQueue.main.async {
            self.tableView1.reloadData()
        }
    }

    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("aaaa")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
            let sortedDates = self.expensesByDate.keys.sorted(by: >)
            let date = sortedDates[indexPath.section]
            print("aaaa")
            
         //   print(sortedDates[indexPath.section])
         
        
            if let expense = self.expensesByDate[date]?[indexPath.row] {

                deleteExpense(id: expense.id!)
                
                print("Silindi")
                
               /* DispatchQueue.main.async {
                    
                   // self.savedTracks.remove(at: indexPath.item)
                    print("expensesSilindi")
                    self.expensesByDate[date]?.remove(at: indexPath.row)
                    print("expenses")
                    print(self.expensesByDate[date])
                    
                    if (self.expensesByDate[date] == []){
                        self.expensesByDate.removeValue(forKey: date)
                    }
                    
                    self.tableView1.reloadData()
                }*/
            }
        }
        
        
        
        let contextItem2 = UIContextualAction(style: .normal, title: "Yıldızla") { (contextualAction, view, boolValue) in
            // Yıldız işlemini burada gerçekleştirin
    
            let sortedDates = self.expensesByDate.keys.sorted(by: >)
            let date = sortedDates[indexPath.section]
            
            guard let id = self.expensesByDate[date]![indexPath.row].id else { return }
                    self.addStarTrack(id: id)
            
        }
        
        let sortedDates = expensesByDate.keys.sorted(by: >)
        let date = sortedDates[indexPath.section]
        
        if staredTracks.contains(where: {$0.id == expensesByDate[date]![indexPath.row].id}) {
            print("a")
             contextItem2.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
         }else{
             print("b")

             contextItem2.image = UIImage(systemName: "star")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
         }
        contextItem.image = UIImage(systemName: "trash.fill")
        print("c")

       
        
    

        




        

        //contextItem2.title = "Yıldızla"


        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, contextItem2])

        return swipeActions
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView{
            
        case tableView1:
            return 55
        case tableViewSirala:
            return 3*view.frame.size.height/40
            
            
        default:
            return CGFloat()
        }
        
    }
    
    
    
    func fetchStaredTrackes(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.predicate = NSPredicate(format: "yildizmi == %@", NSNumber(value: true))

        do {
            let filteredTasks = try context.fetch(fetchRequest)
            print(filteredTasks)

            for task in filteredTasks as! [NSManagedObject] {
                guard let category = task.value(forKey: "category") as? String else {return}
                guard let id = task.value(forKey: "id") as? UUID else {return}
                guard let note = task.value(forKey: "note") as? String else {return}
                guard let moneyEach = task.value(forKey: "privatemoney") as? Float else {return}
                guard let date = task.value(forKey: "date") as? Date else {return}
                guard let dateString = task.value(forKey: "datestring") as? String else {return}
                guard let yildizMi = task.value(forKey: "yildizmi") as? Bool else{return}
                print("yildizMi \(yildizMi)")

               // self.savedTracks.append(savedTrack(category: category, id: id, note: note, moneyEach: moneyEach, date: date, dateString: dateString))
                self.staredTracks.append(savedTrack(category: category, id: id, note: note, moneyEach: moneyEach, date: date, dateString: dateString))
                
            }
           
        } catch {
            print("Veri çekilemedi: \(error)")
        }

    }
    
    
    func addStarTrack(id: UUID){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let result = try context.fetch(fetchRequest)
            if let objectToUpdate = result.first {
                // Veriyi güncelleyin
                
                
                if objectToUpdate.yildizmi == true{
                    objectToUpdate.yildizmi = false
                }else{
                    objectToUpdate.yildizmi = true
                }
            
                try context.save()
            }
        } catch {
            print("Hata: Veri güncellenemedi - \(error)")
        }

      //  newTrack.setValue(id, forKey: "id")

    }
  
        
  
        
        
        
        
        
    }
    
    

    

    
    
    
    
    
    








    
    
    
    
    
    func fetchDatas(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                  //  guard let moneyEach = result.value(forKey: "privatemoney") as? Float else{return}
                    guard let date = result.value(forKey: "date") as? Date else{return}
                    
                   // print(date)
                    
                    
                   // print(date)
                    fetchCategory(date: date)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                
                    
                    let dateString = dateFormatter.string(from: date)
                 //   print(dateString) // "Jan 16, 2023"

                    
                //    self.dateSections = DateSection(date: date, expenses: <#T##[Expense]#>)
                }
            }
            
        }catch{
            
        }
    }

    
    
    
    
    func fetchCategory(date: Date){
        
       
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        
        
        let dateString = "2023-08-30"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        fetchRequest.predicate = NSPredicate(format: "date = %@", "\(dateString)")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            let filteredTasks = try context.fetch(fetchRequest)
            for task in filteredTasks as! [NSManagedObject] {
                
                guard let moneyEach = task.value(forKey: "privatemoney") as? Float else {return}


                print(moneyEach)
                
                
                
            }
           
        } catch {
            print("Veri çekilemedi: \(error)")
        }
        
    }



func deleteExpense(id: UUID){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    do {
        let filteredTasks = try context.fetch(fetchRequest)
        for task in filteredTasks as! [NSManagedObject] {
            

            guard let idGelen = task.value(forKey: "id") as? UUID else {return}
            guard let money = task.value(forKey: "privatemoney") as? Float else{return}
            
          //  if let expenseToDelete = result.first
                
                if idGelen == id{
                    print(task)
                    context.delete(task)
                

                    do {
                         try context.save()
                            print("Expense başarıyla silindi.")
                    } catch {
                        print("Expense silinirken bir hata oluştu: \(error)")
                    }
                }
            }
            
        
        // Eğer nesne bulunduysa, sil

    }catch{
        
    }
    
    
    
}






extension UIImage {
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}



