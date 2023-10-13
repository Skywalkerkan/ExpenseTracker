//
//  StarsViewController.swift
//  ExpenseTracker
//
//  Created by Erkan on 2.10.2023.
//

import UIKit
import CoreData
import SwipeCellKit


class StarsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    
    
    var starredTracks: [savedTrack] = []
    
    var fetchedResultsController: NSFetchedResultsController<Tracker>!

    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
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
        labelNoData.text = "No transactions were starred"
        labelNoData.textAlignment = .center
        labelNoData.translatesAutoresizingMaskIntoConstraints = false
        return labelNoData
    }()
    let noDataImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "doc.text.magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 248/255, alpha: 1)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Stars".localized()
        
        
       collectionViewSetup()
        
        
        fetchStarsTracker()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
       
        
        
        fetchResultController()
        
       
        
  
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Stars".localized()

    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(noDataView)
        
        noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.size.height/6).isActive = true
        noDataView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 200)
        
        
        noDataView.addSubview(labelNoData)
        noDataView.addSubview(noDataImage)
        
        noDataImage.anchor(top: noDataView.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 60, height: 60)
        noDataImage.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        labelNoData.anchor(top: noDataImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        
        starredTracks.removeAll()
        fetchStarsTracker()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
       
    }
    
    
    func fetchResultController(){
        
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
               fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
               
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
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
    
    
    func collectionViewSetup(){
        collectionView.register(EachCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 7, paddingRight: -7, width: 0, height: 0)
        
    }
    
    
    
    
    func fetchStarsTracker(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracker")
        fetchRequest.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.predicate = NSPredicate(format: "yildizmi == %@", NSNumber(value: true))
        fetchRequest.sortDescriptors = [sortDescriptor]

        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                
                for result in results as! [NSManagedObject]{
                    
                    guard let category = result.value(forKey: "category") as? String else {return}
                    guard let id = result.value(forKey: "id") as? UUID else {return}
                    guard let note = result.value(forKey: "note") as? String else {return}
                    guard let moneyEach = result.value(forKey: "privatemoney") as? Float else {return}
                //    guard let totalMoney = result.value(forKey: "totalmoney") as? Float else {return}
                    guard let date = result.value(forKey: "date") as? Date else {return}
                    guard let dateString = result.value(forKey: "datestring") as? String else {return}
                    
                    starredTracks.append(savedTrack(category: category, id: id, note: note, moneyEach: moneyEach, date: date, dateString: dateString))
                    
                    
                }
                
                
                
                
                
                noDataView.isHidden = true
                print(starredTracks)
            }else{
                noDataView.isHidden = false
            }
            
            
            
            
        }catch{
            
            print("Hata oluştu")
            
        }
    }
    
    
    
}


extension StarsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SwipeCollectionViewCellDelegate{
   
    
    func removeStarTrack(id: UUID){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let result = try context.fetch(fetchRequest)
            if let objectToUpdate = result.first {
                // Veriyi güncelleyin
                
                
                if objectToUpdate.yildizmi == true{
                    objectToUpdate.yildizmi = false //////Buradad kaldın
                }
            
                try context.save()
            }
        } catch {
            print("Hata: Veri güncellenemedi - \(error)")
        }

      //  newTrack.setValue(id, forKey: "id")

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
    
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.backgroundColor = .green
       // options.transitionStyle = .reveal
        
        
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "Sil".localized()) { action, indexPath in
    
            
            let alert = UIAlertController(title: "Deleting", message: "Are you sure you want to delete the starred part?".localized(), preferredStyle: .alert)
            let actionYes = UIAlertAction(title: "Yes".localized(), style: .destructive) { alert in
                self.deleteExpense(id: self.starredTracks[indexPath.row].id!)
            }
            let actionCancel = UIAlertAction(title: "Cancel".localized(), style: .default)
            
            alert.addAction(actionCancel)
            alert.addAction(actionYes)

          
            
            
            self.present(alert, animated: true)
            


            print("Expenseee")
            
        }
        
        
        
       
        
        let addAction = SwipeAction(style: .default, title: "Yıldızla".localized()) { action, indexPath in
            
            
            
            self.removeStarTrack(id: self.starredTracks[indexPath.row].id!)
            
            
        
            
            
            

            
            

        
            
        }
        print("b")

        
     
        addAction.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .red


        deleteAction.transitionDelegate = ScaleTransition.default

        return [deleteAction, addAction]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EachCategoryCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: starredTracks[indexPath.row].date!)
        cell.dateLabel.text = formattedDate
        
        if starredTracks[indexPath.row].moneyEach! < 0{
            cell.moneyLabel.textColor = UIColor(red: 226/255, green: 159/255, blue: 159/255, alpha: 1)
        }else{
            cell.moneyLabel.textColor = UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
        }
        
        let money = String(starredTracks[indexPath.row].moneyEach!)

        cell.moneyLabel.text = money
        
        if starredTracks[indexPath.row].note!.isEmpty{
            cell.noteLabel.text = "Not Yok".localized()
            cell.noteLabel.textColor = .lightGray
        }else{
            cell.noteLabel.text = starredTracks[indexPath.row].note
            cell.noteLabel.textColor = .black

        }
        
        
        
        
        
        let categoryEach = starredTracks[indexPath.row].category

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
            
            
            
            
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starredTracks.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 10, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Hücreler arasındaki boşluk
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        title = ""
        
        let VC = ExpensesDetailController()
        VC.category = "Stars".localized()
        VC.uuid = starredTracks[indexPath.row].id
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
}
