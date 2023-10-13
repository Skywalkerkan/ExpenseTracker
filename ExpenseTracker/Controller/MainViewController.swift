//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Erkan on 26.08.2023.
//

import UIKit
import CoreData
import SwipeCellKit



class MainViewController: UIViewController, UIScrollViewDelegate, NSFetchedResultsControllerDelegate{

 
    
    
    
    
    
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(imageView.image?.withTintColor(UIColor(red: 165/255, green: 105/255, blue: 189/255, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    

    
    @objc fileprivate func addTapped(){
        print("Basıldı")
        let controller = AddBudgetViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }


    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollStackViewContainer: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
    //    view.backgroundColor = .green
        return view
    }()


    let backCurrencyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    
    var currencyView: UIView = {
        let currencyView = UIView()
        
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        //  view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        currencyView.layer.cornerRadius = 15
        currencyView.clipsToBounds = true

        
        return currencyView
    }()
    
    
    
    
    
    
    
    //////////////////
    
    let currencyLabel: UILabel = {
        
        let currencyLabel = UILabel()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.text = "Current Balance".localized()
        currencyLabel.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return currencyLabel
    }()
    
    

    
    
    
    let moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.text = "15000$"
        moneyLabel.textColor = UIColor.black
        moneyLabel.font = UIFont.systemFont(ofSize: 30, weight: .black)
        return moneyLabel
    }()
    
    
    

    
    
    
    let incomeLabel: UILabel = {
        let incomeLabel = UILabel()
        
        incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeLabel.text = "Income".localized()
        incomeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        return incomeLabel
    }()
    
   
    
    let incomeMoneyLabel: UILabel = {
        
        let incomeMoneyLabel = UILabel()
        
       
        incomeMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        incomeMoneyLabel.text = "20000"
        incomeMoneyLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        incomeMoneyLabel.textColor = .white
        
        return incomeMoneyLabel
    }()
    
    
  
    
    
    
    let incomeBackImageView: UIView = {
        let incomeBackImageView = UIView()
        incomeBackImageView.translatesAutoresizingMaskIntoConstraints = false
        incomeBackImageView.backgroundColor = UIColor(red: 179/255, green: 255/255, blue: 179/255, alpha: 0.6)
        incomeBackImageView.layer.cornerRadius = 15
        return incomeBackImageView
    }()
    

    
    
    
    let incomeImageView: UIImageView = {
        let incomeImageView = UIImageView()
        incomeImageView.translatesAutoresizingMaskIntoConstraints = false
        incomeImageView.image = UIImage(systemName: "shift.fill")
        incomeImageView.tintColor = UIColor(red: 0/255, green: 162/255, blue: 1/255, alpha: 1)
        return incomeImageView
        
    }()
    


    
    
    
    let expenseLabel: UILabel = {
        let expenseLabel = UILabel()

        expenseLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseLabel.text = "Expense".localized()
        expenseLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return expenseLabel
    }()
    

    
    
    let expenseMoneyLabel: UILabel = {
        let expenseMoneyLabel = UILabel()
        expenseMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        expenseMoneyLabel.text = "5000"
        expenseMoneyLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        expenseMoneyLabel.textColor = .white

        return expenseMoneyLabel
    }()
    

    
    let expenseImageBackView: UIView = {
        let expenseImageBackView = UIView()
        expenseImageBackView.translatesAutoresizingMaskIntoConstraints = false
        //expenseImageBackView.backgroundColor = UIColor.init(white: 0.95, alpha: 0.6)
        expenseImageBackView.layer.cornerRadius = 15
        expenseImageBackView.backgroundColor = UIColor(red: 255/255, green: 159/255, blue: 159/255, alpha: 0.6)
        return expenseImageBackView
    }()
    

    
    
    let expenseImageView: UIImageView = {
        let expenseImageView = UIImageView()
        expenseImageView.translatesAutoresizingMaskIntoConstraints = false
        expenseImageView.image = UIImage(systemName: "shift.fill")
        expenseImageView.tintColor = UIColor(red: 209/255, green: 14/255, blue: 14/255, alpha: 1)
        expenseImageView.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        return expenseImageView
    }()
    
    
    
    
 
    let backBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let menuView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    var idArray = [UUID]()
    var totalMoney: Float = 0.0
    var incomeMoney: Float = 0.0
    var expenseMoney: Float = 0.0
    var isMenuHidden: Bool = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    var fetchedResultsController: NSFetchedResultsController<Tracker>!


    
    
    var savedTracks: [savedTrack] = []
    var staredTracks: [savedTrack] = []
    var filteredTracks: [String] = []
    
    
    var fetchController: NSFetchedResultsController<Tracker>!
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
       /* backgroundView.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)// İstediğiniz rengi burada ayarlayabilirsiniz
        tableView.backgroundView = backgroundView
        backgroundView.frame = tableView.bounds*/

        return tableView
        
    }()
    
    
 
    
    
    let collectionView: UICollectionView = {
        
        
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    
    
    
    
    
    let seeAllTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View all".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .italicSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllTransactionButtonClicked), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1), for: .normal)
        return button
    }()
    
    let recentTransactionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 21)
        label.text = "Recent Transactions".localized()
        return label
    }()
    
    @objc func seeAllTransactionButtonClicked() {
        
    //    performSegue(withIdentifier: "toAllTransaction", sender: nil)
        
        
      //  let VC =  NSFetchedViewController()
        let VC = oylesineViewController()
        
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    let noDataView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    let labelNoData: UILabel = {
        let labelNoData = UILabel()
        labelNoData.font = .italicSystemFont(ofSize: 20)
        labelNoData.numberOfLines = 0
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
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

 
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchStaredTrackes()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
             windowScene.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
         }

        

  
        
        scrollView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.register(RecentTransactionCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = UIColor.clear

      

        scrollView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
    
        

        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addArrangedSubview(backView)
        
        
        backView.addSubview(backCurrencyView)
        view.addSubview(addButton)
        backCurrencyView.addSubview(currencyView)
        
        
        scrollView.addSubview(backBottomView)
      //  backBottomView.backgroundColor = .red
  
        backBottomView.addSubview(collectionView)
        backBottomView.addSubview(recentTransactionLabel)


        view.bringSubviewToFront(addButton)
        
        layoutSubviews()
        
        
        
        
        addButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: currencyView.trailingAnchor, paddingTop: 0, paddingBottom: -15, paddingLeft: 0, paddingRight: -5, width: 45, height: 45)
        
        
        
      //  backBottomView.backgroundColor = .red
        backBottomView.anchor(top: backCurrencyView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 30, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        recentTransactionLabel.anchor(top: backBottomView.topAnchor, bottom: collectionView.topAnchor, leading: backCurrencyView.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: -10, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        backBottomView.addSubview(seeAllTransactionButton)
      //  backBottomView.backgroundColor = UIColor(red: 213/255, green: 219/255, blue: 219/255, alpha: 0.7)
        backBottomView.layer.cornerRadius = 40
        
        seeAllTransactionButton.anchor(top: backBottomView.topAnchor, bottom: nil, leading: nil, trailing: backCurrencyView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        collectionView.anchor(top: seeAllTransactionButton.bottomAnchor, bottom:view.safeAreaLayoutGuide.bottomAnchor, leading: backCurrencyView.leadingAnchor, trailing: backCurrencyView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
       // collectionView.backgroundColor = .red
        
        home = scrollView.transform
        
        
        //fetchCategory()
        
        view.addSubview(noDataView)
        
        
        noDataView.centerYAnchor.constraint(equalTo: backBottomView.centerYAnchor, constant: -55).isActive = true
        noDataView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 200)
        
        
        noDataView.addSubview(labelNoData)
        noDataView.addSubview(noDataImage)
        
        noDataImage.anchor(top: noDataView.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 60, height: 60)
        noDataImage.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        labelNoData.anchor(top: noDataImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 30, paddingLeft: 30, paddingRight: -30, width: 0, height: 90)
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
               fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
               
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
        
        
        savedTracks.removeAll()
        fetchItems()
        staredTracks.removeAll()
        fetchStaredTrackes()
        
        savedTracks = Array(savedTracks.prefix(8))
        
        
        if savedTracks.isEmpty{
            noDataView.isHidden = false
        }else{
            noDataView.isHidden = true
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    func showMenu(){
        self.scrollView.layer.cornerRadius = 40
      //  self.tableView.layer.cornerRadius = self.scrollView.layer.cornerRadius
        
        let x = screen.width * 0.8
        let originalTransform = self.scrollView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.4) {
            self.tabBarController?.tabBar.isHidden = true
            self.isMenuHidden = false
            self.scrollView.transform = scaledAndTranslatedTransform
            self.scrollView.isUserInteractionEnabled = false
        }
        
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.4) {
            self.isMenuHidden = false
            self.tabBarController?.tabBar.isHidden = false
            self.scrollView.transform = self.home
            self.scrollView.layer.cornerRadius = 0
          //  self.tableView.layer.cornerRadius = 0
            self.scrollView.isUserInteractionEnabled = true

            
        }
        
        
    }
    

    
    
    
    
    
    func layoutSubviews(){
        
        
        //ScrollView
        scrollView.anchor(top: view.firstBaselineAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        //StackView
        
        scrollStackViewContainer.anchor(top: scrollView.firstBaselineAnchor, bottom: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: scrollStackViewContainer.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
 
    
        
        //CurrencyView
        backCurrencyView.anchor(top: backView.topAnchor, bottom: nil, leading: backView.leadingAnchor, trailing: backView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: 0, height: 165)
        
        currencyView.anchor(top: backCurrencyView.topAnchor, bottom: backCurrencyView.bottomAnchor, leading: backCurrencyView.leadingAnchor, trailing: backCurrencyView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
        //Adding
        currencyView.addSubview(currencyLabel)
        currencyView.addSubview(moneyLabel)
        currencyView.addSubview(incomeLabel)
        currencyView.addSubview(incomeMoneyLabel)
        currencyView.addSubview(incomeBackImageView)
        incomeBackImageView.addSubview(incomeImageView)
        currencyView.addSubview(expenseLabel)
        currencyView.addSubview(expenseMoneyLabel)
        currencyView.addSubview(expenseImageBackView)
        expenseImageBackView.addSubview(expenseImageView)


        
        
        
        //CardViewInside
        currencyLabel.centerXAnchor.constraint(equalTo: currencyView.centerXAnchor, constant: 0).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: currencyView.topAnchor, constant: 15).isActive = true
        
        moneyLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 10).isActive = true
        moneyLabel.centerXAnchor.constraint(equalTo: currencyView.centerXAnchor).isActive = true
        
        incomeLabel.anchor(top: moneyLabel.bottomAnchor, bottom: nil, leading: currencyView.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeft: 60, paddingRight: 0, width: 0, height: 0)
        
        incomeMoneyLabel.anchor(top: incomeLabel.bottomAnchor, bottom: nil, leading: incomeLabel.leadingAnchor, trailing: nil, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        incomeBackImageView.anchor(top: incomeLabel.bottomAnchor, bottom: nil, leading: nil, trailing: incomeMoneyLabel.leadingAnchor, paddingTop: -8, paddingBottom: 0, paddingLeft: 0, paddingRight: -10, width: 30, height: 30)
        
        incomeImageView.centerYAnchor.constraint(equalTo: incomeBackImageView.centerYAnchor).isActive = true
        incomeImageView.centerXAnchor.constraint(equalTo: incomeBackImageView.centerXAnchor).isActive = true
        
        expenseLabel.anchor(top: moneyLabel.bottomAnchor, bottom: nil, leading: nil, trailing: currencyView.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: -60, width: 0, height: 0)
        
        expenseMoneyLabel.anchor(top: expenseLabel.bottomAnchor, bottom: nil, leading: expenseLabel.leadingAnchor, trailing: nil, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        expenseImageBackView.anchor(top: expenseLabel.bottomAnchor, bottom: nil, leading: nil, trailing: expenseMoneyLabel.leadingAnchor, paddingTop: -8, paddingBottom: 0, paddingLeft: 0, paddingRight: -10, width: 30, height: 30)
        
        expenseImageView.centerYAnchor.constraint(equalTo: expenseImageBackView.centerYAnchor).isActive = true
        expenseImageView.centerXAnchor.constraint(equalTo: expenseImageBackView.centerXAnchor).isActive = true
        
        
        
        gradientLayer()
    
        
    }
    

    
    
    
    func gradientLayer(){
        
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.currencyView.bounds
           
            
            let color1 = UIColor(red: 248/255, green: 205/255, blue: 157/255, alpha: 1)
              let color2 = UIColor(red: 255/255, green: 195/255, blue: 0/255, alpha: 1)
              let color3 = UIColor(red: 246/255, green: 172/255, blue: 90/255, alpha: 1)
            
            
            gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
           //Use diffrent colors
           gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
           gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            self.currencyView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func gradientLayerBackground(){
        
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.scrollView.bounds
            
            let color1 = UIColor(red: 187/255, green: 143/255, blue: 206/255, alpha: 1)
            let color2 = UIColor(red: 165/255, green: 105/255, blue: 189/255, alpha: 1)
            let color3 = UIColor(red: 143/255, green: 68/255, blue: 173/255, alpha: 1)
            let color4 = UIColor(red: 125/255, green: 60/255, blue: 152/255, alpha: 1)

            
            gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor, color4.cgColor]
           //Use diffrent colors
           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            self.scrollView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    
    
    
    
    
    
    
    func fetchCategory(){
        
        savedTracks.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        fetchRequest.returnsObjectsAsFaults = false
        
        fetchRequest.predicate = NSPredicate(format: "category = %@", "Sağlık")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            let filteredTasks = try context.fetch(fetchRequest)
            for task in filteredTasks as! [NSManagedObject] {
                
                guard let category = task.value(forKey: "category") as? String else {return}
                guard let id = task.value(forKey: "id") as? UUID else {return}
                guard let note = task.value(forKey: "note") as? String else {return}
                guard let moneyEach = task.value(forKey: "privatemoney") as? Float else {return}
              //  guard let totalMoney = task.value(forKey: "totalmoney") as? Float else {return}
                totalMoney = 5.0
                guard let date = task.value(forKey: "date") as? Date else {return}
                guard let dateString = task.value(forKey: "datestring") as? String else {return}

                self.savedTracks.append(savedTrack(category: category, id: id, note: note, moneyEach: moneyEach, date: date, dateString: dateString))
                
                
            }
            print(savedTracks.count)
        } catch {
            print("Veri çekilemedi: \(error)")
        }
        
    }
    
    
    
    func fetchItems(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsObjectsAsFaults = false
        
  
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                self.incomeMoney = 0.0
                self.expenseMoney = 0.0
      
                for result in results as! [NSManagedObject] {

                    
                //    print(result)
                    
                    guard let category = result.value(forKey: "category") as? String else {return}
                    guard let id = result.value(forKey: "id") as? UUID else {return}
                    guard let note = result.value(forKey: "note") as? String else {return}
                    guard let moneyEach = result.value(forKey: "privatemoney") as? Float else {return}
                //    guard let totalMoney = result.value(forKey: "totalmoney") as? Float else {return}
                    guard let date = result.value(forKey: "date") as? Date else {return}
                    guard let dateString = result.value(forKey: "datestring") as? String else {return}


                    
                    if moneyEach > 0{
                        incomeMoney += moneyEach

                    }else{
                        expenseMoney += moneyEach
                    }

                    totalMoney = 5
                    self.savedTracks.append(savedTrack(category: category, id: id, note: note, moneyEach: moneyEach, date: date, dateString: dateString))
                    
                   
                    
                }
                incomeMoneyLabel.text = "\(incomeMoney)"
                expenseMoneyLabel.text = "\(expenseMoney)"
                moneyLabel.text = "\(incomeMoney + expenseMoney)"

                print(savedTracks.count)
            }
            
            
        }catch{
            print("VALLA HATA OLUŞTU")
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .clear
        title = "Budget Control".localized()
        savedTracks.removeAll()
        fetchItems()
        savedTracks = Array(savedTracks.prefix(8))
        
        if savedTracks.isEmpty{
            noDataView.isHidden = false
        }else{
            noDataView.isHidden = true
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()

        }
        tabBarController?.tabBar.isHidden = false
    }
    
    
    

    
    
    
    
    

    
    
    

    
}




extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SwipeCollectionViewCellDelegate{
   
    
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
                        
                        if money < 0{
                            expenseMoney -= money
                            expenseMoneyLabel.text = "\(expenseMoney)"
                        }else{
                            incomeMoney -= money
                            incomeMoneyLabel.text = "\(incomeMoney)"
                        }
                        moneyLabel.text = "\(incomeMoney + expenseMoney)"

                        
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
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.backgroundColor = .green
       // options.transitionStyle = .reveal
        
        
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "Sil".localized()) { action, indexPath in
    
            
            guard let id = self.savedTracks[indexPath.row].id else {return}

            self.deleteExpense(id: id)
           /* self.savedTracks.remove(at: indexPath.item)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }*/


            print("Expenseee")
            
        }
        
        
        
       
        
        let addAction = SwipeAction(style: .default, title: "Yıldızla".localized()) { action, indexPath in
            
            action.textColor = .red
            guard let id = self.savedTracks[indexPath.row].id else { return }
                    self.addStarTrack(id: id)
                    print("a")
            
            

            
                    // Yıldızlı simgeyi doldur.

        
            
        }
        print("b")

        print(staredTracks.count)
        
        
      //  addAction.backgroundColor = .cyan
        deleteAction.backgroundColor = .red
        
       if staredTracks.contains(where: {$0.id == savedTracks[indexPath.row].id}) {
            addAction.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        }else{
            addAction.image = UIImage(systemName: "star")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")



        deleteAction.transitionDelegate = ScaleTransition.default

        return [deleteAction, addAction]
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
            print(savedTracks.count)
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

    
 
    func visibleRect(for collectionView: UICollectionView) -> CGRect? {
        return collectionView.safeAreaLayoutGuide.layoutFrame
    }
    
    

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? RecentTransactionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
     
        if let moneyEach = savedTracks[indexPath.row].moneyEach{
            
            if moneyEach < 0{
                cell.moneyLabel.textColor = UIColor(red: 226/255, green: 159/255, blue: 159/255, alpha: 1)
            }else{
                cell.moneyLabel.textColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
            }
            cell.moneyLabel.text = "\(moneyEach)"
            
            

        }
        if let categoryEach = savedTracks[indexPath.row].category{
            cell.categoryLabel.text = "\(categoryEach)"
           // print(categoryEach)
            
            
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
      //  cell.backgroundView?.layer.cornerRadius = 10
        
        
        let gosterilecekDate = savedTracks[indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: gosterilecekDate!)
        
        
        cell.dateLabel.text = formattedDate
        
        
        if savedTracks[indexPath.row].note == ""{
            cell.noteLabel.text = "No note".localized()
            cell.noteLabel.textColor = .lightGray
        }else{
            
            cell.noteLabel.text = savedTracks[indexPath.row].note
            cell.noteLabel.textColor = .black

        }
        

    

        
        
        
        cell.contentView.backgroundColor = UIColor.clear

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width+10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        let VC = ExpensesDetailController()
        guard let id = savedTracks[indexPath.row].id else{return}
        VC.category = "Home".localized()
        VC.uuid = id
        
        navigationController?.pushViewController(VC, animated: true)
        
        
        print(savedTracks[indexPath.row].category)
        
        let dataFormatter = DateFormatter()
        
        //dataFormatter.locale = Locale(identifier: "tr_TR")
       // dataFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        
      //  dataFormatter.locale = Locale(identifier: "en_US")
      // dataFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss"
      //  print(Locale.current)
        
        dataFormatter.dateStyle = .long
        dataFormatter.timeStyle = .short
        
       // dataFormatter.dateStyle = .medium
        let formattedDate = dataFormatter.string(from: savedTracks[indexPath.row].date!)
        
        print(formattedDate)
        
        
        
        
        
        
    }
    
    
    
    
    

    
    


    
}






