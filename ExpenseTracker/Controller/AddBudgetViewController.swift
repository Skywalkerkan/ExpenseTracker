//
//  GelirGiderViewController.swift
//  Expense Tracker
//
//  Created by Erkan on 7.05.2023.
//

import UIKit
import CoreData
import FSCalendar


class AddBudgetViewController: UIViewController, UITextFieldDelegate, FSCalendarDelegate, FSCalendarDataSource{

    var visualEffectView: UIVisualEffectView? 

   
    var tiklandi = ""
    var tutar: Float32 = 0
    var not: String = ""
    var id = UUID()
    var accountName = "Erkan"
    var selectedCategory = ""
    var categoryEachMoney = 0
    var selectedIndexPath: IndexPath?
    var colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple]

    
    
    private let calendar = FSCalendar(frame: .zero)

    
    
    var kategoriArray = [String]()
    var kategoriArrayLanguages = [String]()
    var kategorImages = [String]()
    
    
    
    
    var categories: [Money] = []
    
    
    
    var workings:String = ""
    var workingsAsil: String = ""
    var decimalAktifMi: Bool = false
    var isaretBasildiMi: Bool = true
    
    
    
    let gelirButton: UIButton = {
        let button = UIButton()
        button.setTitle("Income".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.75).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 179/255, green: 255/255, blue: 179/255, alpha: 0.6)
        //UIColor(red: 179/255, green: 255/255, blue: 179/255, alpha: 0.6)
        //UIColor(red: 239/255, green: 233/255, blue: 233/255, alpha: 1)// UIColor(red: 242/255, green: 243/255, blue: 244/255, alpha: 1)
        button.addTarget(self, action: #selector(gelirTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func gelirTapped(){
        gelirButton.setTitleColor(.black, for: .normal)
        
        if tiklandi == TrackerEnum.Gider.rawValue{
            selectedCategory = ""
            kategoriLabelButton.tintColor = .lightGray
            kategoriLabelButton.setTitle("Category".localized(), for: .normal)
            DispatchQueue.main.async {
                self.collectionViewCategory.reloadData()
            }
        }
      //  gelirButton.layer.borderColor = UIColor.green.cgColor
        gelirButton.backgroundColor = UIColor(red: 179/255, green: 255/255, blue: 179/255, alpha: 0.6)
        giderButton.setTitleColor(.black, for: .normal)
        giderButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
      //  giderButton.layer.borderColor = UIColor.black.cgColor
        havaleButton.setTitleColor(.black, for: .normal)
      // havaleButton.layer.borderColor = UIColor.black.cgColor
        tiklandi = TrackerEnum.Gelir.rawValue
        
        
        
        ////Collection View
        ///
        kategoriArray = ["Maaş", "Borsa", "Faiz", "Hediye", "Ek Gelir", "Harçlık", "Avans", "Diğer"]
        kategoriArrayLanguages = ["Salary", "Excange", "Interest", "Gift", "Passive Income", "Allowance", "Advance", "Other"]
        kategorImages = ["application","giftbox","interest-rate","money-exchange","salary"]
   
    }
    
    
    let giderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expense".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.75).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(giderTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func giderTapped(){
        if tiklandi == TrackerEnum.Gelir.rawValue{
            selectedCategory = ""
            kategoriLabelButton.tintColor = .lightGray
            kategoriLabelButton.setTitle("Category".localized(), for: .normal)
            DispatchQueue.main.async {
                self.collectionViewCategory.reloadData()
            }
        }
        gelirButton.setTitleColor(.black, for: .normal)
      //  gelirButton.layer.borderColor = UIColor.black.cgColor
      //  giderButton.setTitleColor(UIColor(red: 176/255, green: 217/255, blue: 162/255, alpha: 1), for: .normal)
        gelirButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
      //  giderButton.tintColor = UIColor(red: 176/255, green: 217/255, blue: 162/255, alpha: 1)
        giderButton.backgroundColor = UIColor(red: 255/255, green: 159/255, blue: 159/255, alpha: 0.8)
       // giderButton.layer.borderColor = UIColor.red.cgColor
        havaleButton.setTitleColor(.black, for: .normal)
        havaleButton.layer.borderColor = UIColor.black.cgColor
        tiklandi = TrackerEnum.Gider.rawValue
        
        
        
        ////CollectionView
        ///
        self.tiklandi = "Gider"
        kategoriArray = ["Sağlık", "Araba Masrafları","Ev Harcamaları", "Evcil Hayvan", "Ulaşım", "Dışarıda Yemek", "Spor", "Giyim", "Alışveriş", "Tatil", "Eğitim", "İş", "Diğer"]
        kategoriArrayLanguages = ["Health", "Car Expenses", "Household", "Pet Care", "Transport", "Dining Out", "Sports", "Clothing", "Shopping", "Vacation", "Education", "Work", "Other"]


        kategorImages = ["stethoscope.circle", "car", "house", "pawprint", "bus.fill", "fork.knife.circle", "figure.handball", "tshirt", "cart.circle", "application"]

    }
    
    
    let havaleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Havale".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 148/255, green: 68/255, blue: 173/255, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(havaleTapped), for: .touchUpInside)
        return button
    }()
    
   

    
    let segmentedControl: UISegmentedControl = {
        let items = ["Gelir", "Gider"] // Segmentlerin metinleri
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.tintColor = .green
        segmentedControl.selectedSegmentTintColor = .green
        let font = UIFont.boldSystemFont(ofSize: 20) // Font boyutunu 20 olarak ayarlayın
        segmentedControl.setTitleTextAttributes([.font: font], for: .normal)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0 // Başlangıçta seçili olan segmentin indeksi
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)



        
        return segmentedControl
    }()
    
    
    @objc func havaleTapped(){
        gelirButton.setTitleColor(.black, for: .normal)
        gelirButton.layer.borderColor = UIColor.black.cgColor
        giderButton.setTitleColor(.black, for: .normal)
        giderButton.layer.borderColor = UIColor.black.cgColor
        havaleButton.setTitleColor(.purple, for: .normal)
        havaleButton.layer.borderColor = UIColor.purple.cgColor
        tiklandi = TrackerEnum.Havale.rawValue
    }
    
    //Enüst Buraya kadar
    
    
    
    let notTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type a note".localized()
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .green
        return stackView
    }()
    
    let moneyLabel: UILabel = {
       let label = UILabel()
        label.text = "Amount:".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        return label
    }()
    
    let kategoriLabel: UILabel = {
       let label = UILabel()
        label.text = "Category:".localized()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.isUserInteractionEnabled = true

        return label
    }()
    
    
    let kategoriLabelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Category".localized(), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(kategoriButtonClicked), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        button.tintColor = .lightGray
        return button
    }()
    
    
    
    @objc func kategoriButtonClicked(){
        
        print("button basıldı")
        
        let bastakiFrameY = categoryView.frame.origin.y
        
        categoryView.frame.origin.y = UIScreen.main.bounds.height
        calculatorView.isHidden = true
       
        if categoryView.isHidden{
            karartmaView.isHidden = false

            let screenHeight = UIScreen.main.bounds.height
            karartmaView.backgroundColor = .black.withAlphaComponent(0.2)
            UIView.animate(withDuration: 0.3) {
                // UICollectionView'ı görünür hale getirin
                self.categoryView.isHidden = false
                self.kaydetButton.isEnabled = false
                // UICollectionView'ı ekranın yarısına kaydırın
                let halfScreenHeight = screenHeight / 2
              //  self.categoryView.frame.origin.y = halfScreenHeight - self.collectionViewCategory.frame.height
                
                // UICollectionView'ın alt kısmını ekranın altına yerleştirin
                self.categoryView.frame.origin.y = bastakiFrameY
                self.kategoriLabelButton.isEnabled = false
                self.moneyText.isEnabled = true
            }
            
            
            
            
        }else{
            print("Kapandı")
            categoryView.isHidden = true
            kaydetButton.isEnabled = true
            
        }
        
        
    }
    
    


    
    let hesapLabel: UILabel = {
       let label = UILabel()
        label.text = "Hesap:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        return label
    }()
    
    let notLabel: UILabel = {
        let label = UILabel()
        label.text = "Note:".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)

         return label
    }()
    
    let currencyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
        button.setTitle("TRY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
       // button.titleLabel?.font =
        return button
    }()
    
    
  /*  let moneyText: UITextField = {
       let text = UITextField()
        text.keyboardType = .decimalPad
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "0.00"
        
        text.resignFirstResponder()
        //text.layer.borderColor = UIColor.black.cgColor
       // text.layer.borderWidth = 2
        text.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        return text
    }()*/
    
    
    let moneyText: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0.00", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.isHighlighted = false
        button.addTarget(self, action: #selector(moneyClicked), for: .touchUpInside)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()
    
    var gozetle: Bool = false
    var bastakiFrameY: CGFloat = 0
    
    @objc func moneyClicked(){
        
       
        
        if gozetle == false{
            bastakiFrameY = calculatorView.frame.origin.y
            
        }
        
        gozetle = true
        

        
        print(bastakiFrameY)
        
        calculatorView.frame.origin.y = UIScreen.main.bounds.height
        print("aaaaa")
        print(calculatorView.isHidden)
        
        if calculatorView.isHidden{
        //    karartmaView.isHidden = false
            

            let screenHeight = UIScreen.main.bounds.height
            //karartmaView.backgroundColor = .black.withAlphaComponent(0.2)
            UIView.animate(withDuration: 0.3) {
                // UICollectionView'ı görünür hale getirin
                self.calculatorView.isHidden = false
                
                // UICollectionView'ı ekranın yarısına kaydırın
                let halfScreenHeight = screenHeight / 2
              //  self.categoryView.frame.origin.y = halfScreenHeight - self.collectionViewCategory.frame.height
                
                // UICollectionView'ın alt kısmını ekranın altına yerleştirin
                self.calculatorView.frame.origin.y = self.bastakiFrameY
              //  self.moneyText.isEnabled = false
            }
            
            
            
            
        }else{
            print("Kapandı")
            calculatorView.isHidden = true
            print(calculatorView.frame.origin.y)
        }
        
        print(calculatorView.frame.origin.y)
        
    }
     
    
    let backView: UIView = {
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
   //     backView.layer.borderWidth = 2
     //   backView.layer.borderColor = UIColor.black.cgColor
     //   backView.layer.cornerRadius = 50
       // backView.backgroundColor = .green
        return backView
    }()
    
    
    
    let kaydetButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       // let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.45)
        //UIColor(red: 179/255, green: 255/255, blue: 179/255, alpha: 0.6)
//UIColor(red: 45/255, green: 151/255, blue: 45/255, alpha: 1)
       // button.setBackgroundImage(imageView.image?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        
        return button
    }()
    
    
    let tarihLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date:".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    let tarihTextButton: UIButton = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: date)
        let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(formattedDate, for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(takvimAc), for: .touchUpInside)

         return button
    }()
    
    
    
    
    
    
    @objc func takvimAc(){
        calendarView.isHidden = false
        calendar.isHidden = false
        calculatorView.isHidden = true
        moneyText.isEnabled = true
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
            let dayOfWeekFormatter = DateFormatter()
            dayOfWeekFormatter.locale = Locale(identifier: preferredLanguage)
            dayOfWeekFormatter.dateFormat = "EEEE"
            let dayOfWeekString = dayOfWeekFormatter.string(from: dateBugun)
            print(dayOfWeekString)
            print(dayOfWeek2)
            gunAdLabel.text = dayOfWeekString
            

             
         }
        
    }
    
    
    @objc func saveButtonClicked(){
        
        let alertNumber = UIAlertController(title: "Wrong Input".localized(), message: "Please Type a Number".localized(), preferredStyle: .alert)
        let alertCategory = UIAlertController(title: "Wrong Input".localized(), message: "Please Select a Transaciton Category".localized(), preferredStyle: .alert)

        let action = UIAlertAction(title: "Okey".localized(), style: .cancel)
        alertNumber.addAction(action)
        alertCategory.addAction(action)
       
        print("\(asilSayi)")
        
        if self.asilSayi == 0{
            
                present(alertNumber, animated: true)
            
           
        }else if selectedCategory.isEmpty{
            
            present(alertCategory, animated: true)
            
        }else{
            addTrack()
            guard let storedTrack = UserDefaults.standard.object(forKey: "totalMoney") as? Float else{return}
           
           
        }
        
    }
    

    
    

    
    var bottomLine: UIView!
    
    lazy var collectionViewCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
      //  layout.scrollDirection = .horizontal
      //  layout.collectionView?.bounces = true
        //layout.itemSize = CGSize(width: 150, height: 50)
      //  layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
     //   collectionView.
    //    collectionView.contentInsetAdjustmentBehavior = .never



        return collectionView
    }()
    
    
    
  
    
    let viewAltAyrac: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let viewAltAyrac2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let viewAltAyrac3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    
    let categoryView: UIView = {
     
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
        
    }()
    
    
    let transactionsCategory: UILabel = {
       let label = UILabel()
        label.text = "Transaction Categories".localized()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //ALT TARAF FULL CALENDAR
    let calendarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        

        return view
    }()
    
    
    let gunAdLabel: UILabel = {
        let label = UILabel()
        label.text = "Pazartesi".localized()
        label.textAlignment = .center
        label.textColor = .white

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ayLabel: UILabel = {
        let label = UILabel()
        label.text = "Ekim".localized()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let gunLabel: UILabel = {
        let label = UILabel()
        label.text = "23"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
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
    
    var asilSayi: Float32 = 0.0
    
    
    func clearAll()
    {   isaretBasildiMi = true
        decimalAktifMi = false
        workings = ""
        workingsAsil = ""
        decimalNokta = 0
        calculatorWorkings.text = ""
        calculatorResults.text = "0.00"
    }
    
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // View Controller'ın üzerinde gösterin
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController { //Error
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    let button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

            // button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(birTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func birTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "1")

       
    }
    
    let button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(ikiTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func ikiTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "2")

    }
    
    let button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(ucTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func ucTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "3")

    }
    
    let button4: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(dortTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func dortTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "4")

    }

    let button5: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("5", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(besTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func besTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "5")

    }
    
    let button6: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("6", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(altiTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func altiTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "6")

    }
    
    let button7: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("7", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(yediTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func yediTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "7")

    }
    
    let button8: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("8", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(sekizTiklandi), for: .touchUpInside)
        return button
    }()
    
    
    @objc func sekizTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "8")


    }
    
    let button9: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("9", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(dokuzTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func dokuzTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "9")


    }
    
    let button0: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("0", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(sifirTiklandi), for: .touchUpInside)
        return button
    }()
    
    
    @objc func sifirTiklandi(){
        isaretBasildiMi = false

        
        addToWorkings(value: "0")

    }
    
    let buttonVirgul: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(",", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(virgulTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func virgulTiklandi(){
        decimalAktifMi = true
           if decimalNokta == 0{
               addToWorkings(value: ".")
               isaretBasildiMi = true
           }
           decimalNokta = 1
    }
    
    let buttonClearAll: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AC", for: .normal)
   //     button.tintColor = .gray
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.backgroundColor = UIColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 1)
        //UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)//UIColor(red: 255/255, green: 159/255, blue: 159/255, alpha: 1)
        button.addTarget(self, action: #selector(clearAllClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func clearAllClicked(){
        clearAll()
    }
    
   
    
    let buttonYuzde: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("%", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)

        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(yuzdeTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func yuzdeTiklandi(){
 
            
        if isaretBasildiMi == true{
            
        }else{
            addToWorkings(value: "%")
        }
    }
    
    
    let buttonBolu: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("/", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)

        button.backgroundColor =  UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)//UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(boluTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func boluTiklandi(){
        if isaretBasildiMi == true{
            
        }else{
            if decimalAktifMi == false{
                workingsAsil = workings
                addToWorkings2(value: ".0")
                addToWorkings(value: "/")
        }
            else{
                addToWorkings(value: "/")

            }
            isaretBasildiMi = true
        }

        print(isaretBasildiMi)
        decimalNokta = 0
        
      //  print(asilSayi)
    }
    
    let buttonCarpi: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)

        button.backgroundColor =  UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(carpiTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func carpiTiklandi(){
        

        
        if isaretBasildiMi == true{
            
        }else{
            if decimalAktifMi == false{
            //addToWorkings(value: ".0")
                addToWorkings2(value: ".0")

            addToWorkings(value: "*")
        }
            else{
                addToWorkings(value: "*")

            }
            isaretBasildiMi = true
        }
        decimalNokta = 0
        
      //  print(asilSayi)
    }

    let buttonEksi: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)

        button.backgroundColor =  UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(eksiTiklandi), for: .touchUpInside)
        return button
    }()
    
    
    @objc func eksiTiklandi(){
     
        if isaretBasildiMi == true{
            
        }else{
            if decimalAktifMi == false{
           // addToWorkings(value: ".0")
                addToWorkings2(value: ".0")

            addToWorkings(value: "-")
        }
            else{
                addToWorkings(value: "-")

            }
            isaretBasildiMi = true
        }
        decimalNokta = 0
       
    }

    let buttonArti: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)

        button.backgroundColor =  UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(artiTiklandi), for: .touchUpInside)

        return button
    }()
    
    @objc func artiTiklandi(){
        if isaretBasildiMi == true{
            
        }else{
            if decimalAktifMi == false{
           // addToWorkings(value: ".0")
                addToWorkings2(value: ".0")

            addToWorkings(value: "+")
        }
            else{
                addToWorkings(value: "+")

            }
            isaretBasildiMi = true
        }
        decimalNokta = 0
       
    }
    var decimalNokta = 0

    let buttonEsit: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("=", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(esitTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func esitTiklandi(){
        
        if workings.last == "." {
            print("alert")
        }else if workings.last == "+" || workings.last == "-" || workings.last == "/" || workings.last == "*"{
            
        }else if workings.isEmpty{
            print("Boş")
        }
        
        else{
            
            
            print(workings)
            print(workingsAsil)
            
            
            if validInput() {
                let checkedWorkingsForPercent = workingsAsil.replacingOccurrences(of: "%", with: "*0.01")
                let expression = NSExpression(format: checkedWorkingsForPercent)
                print(expression)
                if let result = expression.expressionValue(with: nil, context: nil) as? Double {
                    let resultString = formatResult(result: result)
                    calculatorResults.text = resultString
                    asilSayi = Float(resultString) ?? 0.0
                    moneyText.setTitle("\(asilSayi)", for: .normal)
                    
                } else {
                    showErrorAlert(message: "Hesaplama sonucu geçersiz bir sayı elde edildi.")
                }
            }
            else
            {
                let alert = UIAlertController(
                    title: "Invalid Input",
                    message: "Calculator unable to do math based on input",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    
    func validInput() ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings
        {
            if(specialCharacter(char: char))
            {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes
        {
            if(index == 0)
            {
                return false
            }
            
            if(index == workings.count - 1)
            {
                return false
            }
            
            if (previous != -1)
            {
                if(index - previous == 1)
                {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    func specialCharacter (char: Character) -> Bool
    {
        if(char == "*")
        {
            return true
        }
        if(char == "/")
        {
            return true
        }
        if(char == "+")
        {
            return true
        }
        return false
    }
    
    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }
    
    func flipTextYAxis(_ text: String) -> String {
        var flippedText = ""
        for character in text {
            if let unicodeScalar = character.unicodeScalars.first {
                let mirroredScalar = UnicodeScalar(0x2800 + (0x28FF - unicodeScalar.value))!
                flippedText.append(Character(mirroredScalar))
            }
        }
        return flippedText
    }
    
    
    let buttonSil: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⌦", for: .normal)
        button.transform = CGAffineTransform(rotationAngle: .pi)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)//UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(silTiklandi), for: .touchUpInside)
        return button
    }()
    
    @objc func silTiklandi(){
        if(!workings.isEmpty)
        {
            
            
            if workings.last == "."{
                decimalNokta = 0
            }
            
            workings.removeLast()
            workingsAsil.removeLast()
            calculatorWorkings.text = workings
        }
        
        
        
    }
    
    let button00: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("00", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        //     button.tintColor = .gray
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tiklandi00), for: .touchUpInside)

        return button
    }()
    
    @objc func tiklandi00(){
        isaretBasildiMi = false
        addToWorkings(value: "00")
    }
    
    
    func addToWorkings(value: String)
    {
        workings = workings + value
        workingsAsil = workingsAsil + value
        calculatorWorkings.text = workings
        
        if isaretBasildiMi == false{
            let charactersToRemove: [Character] = ["+", "-", "*", "/", ","]
            var workings2: String = workings
            
            for character in charactersToRemove {
                workings2 = workings2.replacingOccurrences(of: String(character), with: "")
            }
            print(workings2)
           // calculatorResults.text = workings2
            esitTiklandi()
        }
        
    }
    
    func addToWorkings2(value: String)
    {
        workingsAsil = workingsAsil + value
    }
    

    
    let calculatorView: UIView = {
       let calculator = UIView()
        calculator.translatesAutoresizingMaskIntoConstraints = false
       // calculator.backgroundColor = .red
       // calculator.backgroundColor = .clear
        return calculator
    }()
    
    
    let stackView1: UIStackView = {
       let sView = UIStackView()
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.spacing = 5
        return sView
    }()
    
    
    let stackView2: UIStackView = {
       let sView = UIStackView()
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.spacing = 5
        return sView
    }()
    
    let stackView3: UIStackView = {
       let sView = UIStackView()
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.spacing = 5
        return sView
    }()
    
    let stackView4: UIStackView = {
       let sView = UIStackView()
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.spacing = 5
    
        return sView
    }()
    
    let stackView5: UIStackView = {
       let sView = UIStackView()
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.spacing = 5
        return sView
    }()
  
    
    
    func calendarSetup(){
        view.addSubview(calendarView)
        
        calendarView.addSubview(calendar)
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
        calendar.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor).isActive = true
        gunLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 11)
        ayLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 33)
        yilLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.height / 33)
        gunLabelBackGround.anchor(top: calendarView.topAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 15)
        gunAdLabel.anchor(top: gunLabelBackGround.topAnchor, bottom: gunLabelBackGround.bottomAnchor, leading: gunLabelBackGround.leadingAnchor, trailing: gunLabelBackGround.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        takvimUstBackGround.anchor(top: gunLabelBackGround.bottomAnchor, bottom: yilLabel.bottomAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        ayLabel.anchor(top: gunLabelBackGround.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 2.5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        gunLabel.anchor(top: ayLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        yilLabel.anchor(top: gunLabel.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: -5, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)

        calendar.anchor(top: takvimUstBackGround.bottomAnchor, bottom: nil, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 3*view.frame.size.height / 8 - view.frame.size.height / 25)
        tamamButton.anchor(top: calendar.bottomAnchor, bottom: nil, leading: nil, trailing: calendarView.trailingAnchor, paddingTop: -5, paddingBottom: 0, paddingLeft: 0, paddingRight: -10, width: 0, height: 0)
        iptalButton.anchor(top: tamamButton.topAnchor, bottom: nil, leading: nil, trailing: tamamButton.leadingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 0, height: 0)
        
        calendarView.isHidden = true
    }
    
    
    
    

    
    
    
    func takvimAyarlamalari(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        

        calendar.translatesAutoresizingMaskIntoConstraints = false
        
       // collectionView.isHidden = true
        
        calendar.isHidden = true

        calendar.allowsMultipleSelection = true
        calendar.scope = .month
        calendar.headerHeight = 50
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 20)
        calendar.appearance.weekdayTextColor = .red
        calendar.appearance.todayColor = .red
        calendar.appearance.selectionColor = .purple
        calendar.appearance.borderRadius = 0.4
        calendar.scrollDirection = .horizontal
        calendar.allowsSelection = true
        calendar.allowsMultipleSelection = false
        
     //   view.addSubview(calendar)
        
   //     calendar.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 300, height: 400)
    //    calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //    calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    
    var selectedDate = Date()
    var tarihSecildiMi: Bool = false
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        print(selectedDate)
        
        tarihSecildiMi = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print(formattedDate)
        tarihTextButton.setTitle(formattedDate, for: .normal)
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
            print("\(dayOfWeek) daaaay")
             
             print("Gün: \(dayString)")
             print("Ay: \(monthString)")
             print("Yıl: \(yearString)")
            
            gunLabel.text = dayString
            ayLabel.text = monthString
            yilLabel.text = yearString
            gunAdLabel.text = dayOfWeek
             
         }
    }
    
    
    func findDayOfWeek(for date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        print("weekday \(weekday)")
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
    
    let karartmaView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  

        
    var sayi = 0
  

    
   
    override func viewWillDisappear(_ animated: Bool) {
        print("Kayboluyor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        //UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        tiklandi = TrackerEnum.Gelir.rawValue
        tabBarController?.tabBar.isHidden = true
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = .clear
            // Arka plan resmini yeşil bir resim veya renk olarak ayarlayın

          //  navigationBar.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            
            // Gölgeleri kaldırın (isteğe bağlı)
           // navigationBar.shadowImage = UIImage()
            
            // Metin rengini beyaz olarak ayarlayın (isteğe bağlı)
        //    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            // Geri düğmesi rengini beyaz olarak ayarlayın (isteğe bağlı)
          //  navigationBar.tintColor = UIColor.white
        }
        
        segmentedControl.tintColor = UIColor.clear // Seçilen segmentin altındaki efekti kaldırır
        segmentedControl.backgroundColor = UIColor.clear
  
        kategorImages = ["application","giftbox","interest-rate","money-exchange","salary"]
        kategoriArray = ["Maaş", "Borsa", "Faiz", "Hediye", "Ek Gelir", "Harçlık", "Avans", "Diğer"]
        kategoriArrayLanguages = ["Salary", "Exchange", "Interest", "Gift", "Passive Income", "Allowance", "Advance", "Other"]
        
        collectionViewCategory.delegate = self
        collectionViewCategory.dataSource = self
        
      //  moneyText.delegate = self

        barButtons()
        ustLayoutConstraints()
        ortaLayoutConstraints()
        
        
        view.addSubview(kaydetButton)
        
        view.bringSubviewToFront(collectionViewCategory)
        

        
        bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        let segmentWidth = segmentedControl.bounds.width / CGFloat(segmentedControl.numberOfSegments)

        kaydetButton.anchor(top: tarihLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 25, paddingBottom: 0, paddingLeft: 35, paddingRight: -35, width: 0, height: 0)

        collectionViewCategory.backgroundColor = .clear
        categoryView.isHidden = true
        kaydetButton.isEnabled = true
      //  calculatorView.isHidden = true
        
        takvimAyarlamalari()
        
        calendarSetup()
        
        
        view.addSubview(calculatorView)
        calculatorView.addSubview(stackView1)
        calculatorView.addSubview(stackView2)
        calculatorView.addSubview(stackView3)
        calculatorView.addSubview(stackView4)
        calculatorView.addSubview(stackView5)
        calculatorView.addSubview(calculatorGostergeView)
        calculatorView.addSubview(calculatorWorkings)
        calculatorView.addSubview(calculatorResults)

        /*categoryView.addSubview(buttonClearAll)
        categoryView.addSubview(buttonArtiEksi)
        categoryView.addSubview(buttonYuzde)
        categoryView.addSubview(buttonBolu)
        categoryView.addSubview(button7)
        categoryView.addSubview(button8)
        categoryView.addSubview(button9)
        categoryView.addSubview(buttonCarpi)
        categoryView.addSubview(button4)
        categoryView.addSubview(button5)
        categoryView.addSubview(button6)
        categoryView.addSubview(buttonEksi)
        categoryView.addSubview(button1)
        categoryView.addSubview(button2)
        categoryView.addSubview(button3)
        categoryView.addSubview(buttonArti)
        categoryView.addSubview(button0)
        categoryView.addSubview(buttonVirgul)
        categoryView.addSubview(buttonEsit)*/
        
        
        stackView1.addArrangedSubview(buttonClearAll)
        stackView1.addArrangedSubview(buttonYuzde)
        stackView1.addArrangedSubview(buttonSil)
        stackView1.addArrangedSubview(buttonBolu)
        
        
        stackView2.addArrangedSubview(button7)
        stackView2.addArrangedSubview(button8)
        stackView2.addArrangedSubview(button9)
        stackView2.addArrangedSubview(buttonCarpi)

        
        stackView3.addArrangedSubview(button4)
        stackView3.addArrangedSubview(button5)
        stackView3.addArrangedSubview(button6)
        stackView3.addArrangedSubview(buttonEksi)
        
        
        stackView4.addArrangedSubview(button1)
        stackView4.addArrangedSubview(button2)
        stackView4.addArrangedSubview(button3)
        stackView4.addArrangedSubview(buttonArti)
        
        
        stackView5.addArrangedSubview(buttonVirgul)
        stackView5.addArrangedSubview(button0)
        stackView5.addArrangedSubview(button00)
        stackView5.addArrangedSubview(buttonEsit)
        
        
        calculatorView.backgroundColor = .lightGray//UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1)
        calculatorView.layer.cornerRadius = 30
        //calculatorWorkings.backgroundColor = .red
       // calculatorResults.backgroundColor = .blue
        
        calculatorView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 15, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height / 2)
        calculatorGostergeView.anchor(top: calculatorView.topAnchor, bottom: nil, leading: calculatorView.leadingAnchor, trailing: calculatorView.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/10 - 5)
        calculatorWorkings.anchor(top: calculatorGostergeView.topAnchor, bottom: nil, leading: calculatorView.leadingAnchor, trailing: calculatorView.trailingAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, width: 0, height: 0)
        calculatorResults.anchor(top: nil, bottom: calculatorGostergeView.bottomAnchor, leading: calculatorView.leadingAnchor, trailing: calculatorView.trailingAnchor, paddingTop: 2, paddingBottom: -10, paddingLeft: 15, paddingRight: -15, width: 0, height: 0)

        stackView1.anchor(top: calculatorGostergeView.bottomAnchor, bottom: nil, leading: calculatorView.leadingAnchor, trailing: calculatorView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: -8, width: 0, height: view.frame.size.height/15)
        stackView2.anchor(top: stackView1.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: stackView1.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/15)
        stackView3.anchor(top: stackView2.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: stackView1.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/15)
        stackView4.anchor(top: stackView3.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: stackView1.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/15)
        stackView5.anchor(top: stackView4.bottomAnchor, bottom: nil, leading: stackView1.leadingAnchor, trailing: stackView1.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/15)

        
      
        
      
    }
    
    
    let calculatorGostergeView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let calculatorWorkings: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        
      //  label.text = "0.00"
        label.textColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let calculatorResults: UILabel = {
        let label = UILabel()
        //label.text = "Result"
        label.textAlignment = .right
        label.text = "0.00"

        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
       /* if moneyText.text == ""{
            moneyText.text = "0.00"
        }*/
        
        
        if moneyText.titleLabel?.text == ""{
            moneyText.setTitle( "0.00", for: .normal)
        }
    }
    
    
    

    
    
    
    
    fileprivate func ortaLayoutConstraints(){
      //  karartmaView.addSubview(backView)
        backView.addSubview(moneyLabel)
        backView.addSubview(kategoriLabel)
        backView.addSubview(notLabel)
       // backView.addSubview(collectionViewCategory)
        backView.addSubview(moneyText)
    //    backView.addSubview(hesapLabel)
        backView.addSubview(notTextField)
        backView.addSubview(kategoriLabelButton)
        backView.addSubview(viewAltAyrac)
        backView.addSubview(tarihLabel)
        backView.addSubview(tarihTextButton)
        backView.addSubview(viewAltAyrac2)
        backView.addSubview(viewAltAyrac3)
        karartmaView.addSubview(categoryView)
        
        categoryView.addSubview(transactionsCategory)
        categoryView.addSubview(collectionViewCategory)
        
       // tabBarController?.tabBar.isHidden = true

        
        collectionViewCategory.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        moneyLabel.anchor(top: backView.topAnchor, bottom: nil, leading: backView.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 110, height: 0)
        moneyText.anchor(top: moneyLabel.topAnchor, bottom: moneyLabel.bottomAnchor, leading: moneyLabel.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
        
      
        kategoriLabel.anchor(top: moneyLabel.bottomAnchor, bottom: nil, leading: moneyLabel.leadingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 90, height: 0)
        

        
        kategoriLabelButton.anchor(top: kategoriLabel.topAnchor, bottom: kategoriLabel.bottomAnchor, leading: moneyText.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        viewAltAyrac.anchor(top: kategoriLabelButton.bottomAnchor, bottom: nil, leading: kategoriLabelButton.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 1, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 0, height: 1)

        
       // collectionViewCategory.anchor(top: kategoriLabel.bottomAnchor, bottom: nil, leading: kategoriLabel.leadingAnchor, trailing: backView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 0, height: 260)
        
        
        ///CollectionViewBackgroundColor
        categoryView.backgroundColor = UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
        
        //UIColor(red: 141/255, green: 169/255, blue: 197/255, alpha: 0.2)
        
        
        
        
        categoryView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 12, paddingLeft: 0, paddingRight: 0, width: 0, height: 3*view.frame.height/6)
        transactionsCategory.anchor(top: categoryView.topAnchor, bottom: nil, leading: categoryView.leadingAnchor, trailing: categoryView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
       // categoryView.clipsToBounds = true
        
        
        
        collectionViewCategory.anchor(top: transactionsCategory.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: categoryView.leadingAnchor, trailing: categoryView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        //hesapLabel.anchor(top: viewAltAyrac.bottomAnchor, bottom: nil, leading: kategoriLabel.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 90, height: 0)
        
        viewAltAyrac2.anchor(top: kategoriLabel.bottomAnchor, bottom: nil, leading: viewAltAyrac.leadingAnchor, trailing: viewAltAyrac.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1)
        
        notLabel.anchor(top: viewAltAyrac2.bottomAnchor, bottom: nil, leading: kategoriLabel.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 90, height: 30)
        
        notTextField.anchor(top: notLabel.topAnchor, bottom: notLabel.bottomAnchor, leading: kategoriLabelButton.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        viewAltAyrac3.anchor(top: notLabel.bottomAnchor, bottom: nil, leading: viewAltAyrac.leadingAnchor, trailing: viewAltAyrac.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 1)

        
        tarihLabel.anchor(top: notLabel.bottomAnchor, bottom: nil, leading: notLabel.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        tarihTextButton.anchor(top: tarihLabel.topAnchor, bottom: tarihLabel.bottomAnchor, leading: notTextField.leadingAnchor, trailing: notTextField.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
        
        

  
    }
    
    let buttonStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 15
        view.distribution = .fillEqually
        return view
    }()
    
    
    
    fileprivate func barButtons(){
        let backItem = UIBarButtonItem()
        backItem.title = "Geri"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    
    fileprivate func ustLayoutConstraints(){
        
        
        
      /* view.addSubview(gelirButton)
        gelirButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.width/3 - 27, height: 40)

        
        
         view.addSubview(giderButton)
        giderButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: gelirButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.width/3 - 27, height: 40)
        
        
        view.addSubview(havaleButton)
        havaleButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: giderButton.trailingAnchor, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: view.frame.width/3 - 27, height: 40)*/
        
        
        ///Segmented Control
        
     //   view.addSubview(segmentedControl)
    //    segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, width: 0, height: view.frame.size.height/20)
        
       // view.addSubview(gelirButton)
      //  view.addSubview(giderButton)
        
        
        
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(gelirButton)
        buttonStackView.addArrangedSubview(giderButton)
        buttonStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: -15, width: 0, height: 0)
        
        //gelirButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 150, height: 0)
        
      // giderButton.anchor(top: gelirButton.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 150, height: 0)
        
        
        
        view.addSubview(backView)
    //   backView.backgroundColor = .red
        backView.anchor(top: gelirButton.bottomAnchor, bottom: view.lastBaselineAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 40, paddingLeft: -5, paddingRight: 5, width: 0, height: 0)
        
        
        view.addSubview(karartmaView)
        karartmaView.isHidden = true
        karartmaView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }

    
    

    
 
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           
           let bastakiFrame = categoryView.frame.origin.y
           
           if categoryView.isHidden == false{
               let touch = touches.first
               if touch?.view != self.categoryView
               { self.dismiss(animated: true, completion: nil)
                  // view.addSubview(kaydetButton)
                   UIView.animate(withDuration: 0.3, animations: {
                       // Animasyonun son pozisyonu - ekranın altı
                       self.categoryView.frame.origin.y = UIScreen.main.bounds.height
                   }, completion: { _ in
                       // Animasyon tamamlandığında çalışacak kod
                       self.categoryView.isHidden = true
                       self.kategoriLabelButton.isEnabled = true
                       self.categoryView.frame.origin.y = bastakiFrame
                       self.karartmaView.isHidden = true
                       self.kaydetButton.isEnabled = true
                      // karartmaView.backgroundColor = .lightGray.withAlphaComponent(0.6)

                   })
   
               }
           }
           
           if calendar.isHidden == false{
               let touch = touches.first
               if touch?.view != self.calendarView{
                   self.dismiss(animated: true, completion: nil)
                   self.calendarView.isHidden = true
               }
           }
           
           let bastakiFrameCalculator = calculatorView.frame.origin.y
           
           if calculatorView.isHidden == false{
               let touch = touches.first
               if touch?.view != self.calculatorView
               { self.dismiss(animated: true, completion: nil)
                   
                   UIView.animate(withDuration: 0.3, animations: {
                       // Animasyonun son pozisyonu - ekranın altı
                       self.calculatorView.frame.origin.y = UIScreen.main.bounds.height
                   }, completion: { _ in
                       // Animasyon tamamlandığında çalışacak kod
                       self.calculatorView.isHidden = true
                       self.moneyText.isEnabled = true
                       self.calculatorView.frame.origin.y = bastakiFrameCalculator
                      // self.karartmaView.isHidden = true
                      // karartmaView.backgroundColor = .lightGray.withAlphaComponent(0.6)

                   })
   
               }
           }
    
       }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Seçilen segmentin altına çizgiyi hareket ettirin
        
        
      //  moveBottomLine(toSegment: sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex{
        case 0:
            self.tiklandi = "Gelir"
            kategoriArray = ["Maaş", "Borsa", "Faiz", "Hediye", "Diğer", "Ek Gelir", "Harçlık", "Avans", "Diğer"]
            kategorImages = ["application","giftbox","interest-rate","money-exchange","salary"]
            DispatchQueue.main.async {
                self.collectionViewCategory.reloadData()
            }
            
            
        case 1:
            self.tiklandi = "Gider"
            kategoriArray = ["Sağlık", "Araba Masrafları","Ev Harcamaları", "Evcil Hayvan", "Ulaşım", "Dışarıda Yemek", "Spor", "Giyim", "Alışveriş", "Tatil", "Eğitim", "İş", "Diğer"]
            kategorImages = ["stethoscope.circle", "car", "house", "pawprint", "bus.fill", "fork.knife.circle", "figure.handball", "tshirt", "cart.circle", "application"]
            DispatchQueue.main.async {
                self.collectionViewCategory.reloadData()
            }
        default:
            print("cc")
        }
        
        
        print(sender.selectedSegmentIndex)

        
        
    }
    
    func moveBottomLine(toSegment segment: Int) {
        let segmentWidth = segmentedControl.bounds.width / CGFloat(segmentedControl.numberOfSegments)
        let xOffset = CGFloat(segment) * segmentWidth
        
        UIView.animate(withDuration: 0.21) {
            self.bottomLine.frame.origin.x = xOffset + 20
        }
    }
    
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            
            guard let sayi = Float(newText) else{
                self.tutar = 0
                return true
                
            }
            print(sayi)
            self.tutar = sayi
            print("Yazılan Metin: \(newText)")
        }
        
        
        
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == "0.00"{
            textField.text = ""
        }
        
        return true
    }
    

    
    
    func addTrack(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
    
        
        let dateString = dateFormatter.string(from: selectedDate)
        let date2 = dateFormatter.date(from: dateString)
        print(dateString) // "Jan 16, 2023"
        
        
        print(dateString)
        
        let date = Date()
        
        
        
        
        let newTrack = NSEntityDescription.insertNewObject(forEntityName: "Tracker", into: context)
        let storedTrack = UserDefaults.standard.object(forKey: "totalMoney")
        
        
        print("Seçilen tarih: \(selectedDate)")
        print("Seçilen tarih: \(date)")
        
        if tarihSecildiMi == false{
            selectedDate = Date()
            
        }
        
        print("Seçilen tarih: \(selectedDate)")
        print("Seçilen tarih: \(date)")
        
        print("Selected category\(selectedCategory)")
        newTrack.setValue(selectedDate, forKey: "date")
        newTrack.setValue(dateString, forKey: "datestring")
        newTrack.setValue(self.selectedCategory, forKey: "category")
        print("Buradaki not")
        print(notTextField.text)
        newTrack.setValue(notTextField.text, forKey: "note")
        newTrack.setValue(UUID(), forKey: "id")
        
        
        if tiklandi == TrackerEnum.Gider.rawValue{
            //newTrack.setValue(-self.tutar, forKey: "privatemoney")
            if asilSayi < 0{
                newTrack.setValue(self.asilSayi, forKey: "privatemoney")
            }else{
                newTrack.setValue(-self.asilSayi, forKey: "privatemoney")

            }
            
            UserDefaults.standard.set((storedTrack as? Float ?? 0.0)+(-self.asilSayi), forKey: "totalMoney")
            print("Güncel Eklenen tutar: \(-self.asilSayi)")

        }else{
          //  newTrack.setValue(self.tutar, forKey: "privatemoney")
            if asilSayi < 0{
                newTrack.setValue(-self.asilSayi, forKey: "privatemoney")
            }else{
                newTrack.setValue(self.asilSayi, forKey: "privatemoney")

            }
            UserDefaults.standard.set((storedTrack as? Float ?? 0.0)+(self.asilSayi), forKey: "totalMoney")
            print("Güncel Eklenen tutar: \(self.asilSayi)")

        }
        
        
     
        
        
        //bURASI ÇIKARILABİLİR
        
      //  newTrack.setValue((storedTrack as? Float ?? 0.0)+self.tutar, forKey: "totalmoney")
       

        
        
        do{
            try context.save()
            print("Saved")
        }catch{
            print("Error")
        }
        
        
        
        
    }
    
    




    


}


extension AddBudgetViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    

    

    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kategoriArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell()
        }
        
      //  let text = kategoriArray[indexPath.row]
        let text = kategoriArrayLanguages[indexPath.row]
        cell.categoryLabel.text = text.localized()
        print(text)
        
        
       // kategoriArray = ["Sağlık", "Araba Masrafları","Ev Harcamaları", "Evcil Hayvan", "Ulaşım", "Dışarıda Yemek", "Spor", "Giyim", "Alışvreriş"]
        
        if kategoriArray[indexPath.row] == "Sağlık"{
            cell.category.image = UIImage(named: "healthcare")
        }else if kategoriArray[indexPath.row] == "Araba Masrafları"{
            cell.category.image = UIImage(named: "car")
        }else if kategoriArray[indexPath.row] == "Ev Harcamaları"{
            cell.category.image = UIImage(named: "home")
        }else if kategoriArray[indexPath.row] == "Evcil Hayvan"{
            cell.category.image = UIImage(named: "pet")
        }else if kategoriArray[indexPath.row] == "Ulaşım"{
            cell.category.image = UIImage(named: "bus")
        }else if kategoriArray[indexPath.row] == "Dışarıda Yemek"{
            cell.category.image = UIImage(named: "cutlery")
        }else if kategoriArray[indexPath.row] == "Spor"{
            cell.category.image = UIImage(named: "sports")
        }else if kategoriArray[indexPath.row] == "Giyim"{
            cell.category.image = UIImage(named: "shirt")
        }else if kategoriArray[indexPath.row] == "Alışveriş"{
            cell.category.image = UIImage(named: "trolley")
        }else if kategoriArray[indexPath.row] == "Tatil"{
            cell.category.image = UIImage(named: "calendar")
        }else if kategoriArray[indexPath.row] == "Eğitim"{
            cell.category.image = UIImage(named: "mortarboard")
        }else if kategoriArray[indexPath.row] == "İş"{
            cell.category.image = UIImage(named: "working")//////Buraya kadar Giderler var
        }else if kategoriArray[indexPath.row] == "Maaş"{
            cell.category.image = UIImage(named: "salary")
        }else if kategoriArray[indexPath.row] == "Borsa"{
            cell.category.image = UIImage(named: "money-exchange")
        }else if kategoriArray[indexPath.row] == "Faiz"{
            cell.category.image = UIImage(named: "interest-rate")
        }else if kategoriArray[indexPath.row] == "Hediye"{
            cell.category.image = UIImage(named: "giftbox")
        }else if kategoriArray[indexPath.row] == "Diğer"{
            cell.category.image = UIImage(named: "application")
        }else if kategoriArray[indexPath.row] == "Ek Gelir"{
            cell.category.image = UIImage(named: "profits")
        }else if kategoriArray[indexPath.row] == "Harçlık"{
            cell.category.image = UIImage(named: "donation")
        }else if kategoriArray[indexPath.row] == "Avans"{
            cell.category.image = UIImage(named: "payment")
        }else{
            cell.category.image = UIImage(named: "application")

        }
        
        
        //  kategoriArray = ["Maaş", "Borsa", "Faiz", "Hediye", "Ek Gelir", "Harçlık", "Avans", "Diğer"]
        
        //          kategoriArray = ["Maaş", "Borsa", "Faiz", "Hediye", "Diğer"]
       // kategorImages = ["application","giftbox","interest-rate","money-exchange","salary"]

            
            
 
        
        
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(kategoriArray[indexPath.row])
        var indexPathOld: [IndexPath] = []
       if let selectedCell = collectionView.cellForItem(at: indexPath) {
           indexPathOld.append(indexPath)
           // selectedCell.backgroundColor = .cyan
            self.selectedCategory = kategoriArray[indexPath.row]
           let text = kategoriArrayLanguages[indexPath.row].localized()
           
           kategoriLabelButton.setTitle(text, for: .normal)
           kategoriLabelButton.contentHorizontalAlignment = .left
           kategoriLabelButton.tintColor = .black
           categoryView.isHidden = true
           kategoriLabelButton.isEnabled = true
           self.karartmaView.isHidden = true
           self.kaydetButton.isEnabled = true
           
       }
        
        
        
        
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/6 + 10, height: 70)
    }
    
    
}
