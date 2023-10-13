//
//  TableViewCell.swift
//  ExpenseTracker
//
//  Created by Erkan on 27.08.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    

    let moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.font = .italicSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.font = .boldSystemFont(ofSize: 16)
    
        label.textAlignment = .left
        return label
    }()
    
    var categoryView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return imageView
    }()
    
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Category"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let noteLabel: UILabel = {
       let label = UILabel()
        label.text = "Note"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let cellBackground: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 0.6)
        return view
    }()
    
    
    let backView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
     //   view.layer.cornerRadius = 15
        
       // view.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)//UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
        

     //   view.layer.shadowColor = UIColor.lightGray.cgColor
      //  view.layer.shadowRadius = 2
      //  view.layer.shadowOpacity = 0.6
      
        return view
    }()
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        
        
    }
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Hücre seçildiğinde veya seçim kaldırıldığında çalışacak kod buraya gelecek.
          if selected {
              // Hücre seçildiğinde köşeleri yuvarlayın
              print("aaa")
              self.contentView.layer.cornerRadius = 10 // İstediğiniz yuvarlama miktarını ayarlayabilirsiniz
              self.contentView.clipsToBounds = true
              backView.backgroundColor = .black
          } else {
              // Hücre seçimi kaldırıldığında köşeleri yuvarlama işlemi geri alın
              self.contentView.layer.cornerRadius = 0
              self.contentView.clipsToBounds = false
          }
      }*/
    
    
    
   /* override var isSelected: Bool {
        didSet {
            if isSelected {
               // backgroundColor = UIColor.blue
                
                
               
                backView.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 160/255, alpha: 1)

            } else {
                backView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
            }
        }
    }*/
    
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       //backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        
        
        
      //  backView.backgroundColor = UIColor(red: 245/255, green: 238/255, blue: 248/255, alpha: 1)
        
        addSubview(backView)
        backView.addSubview(cellBackground)
        backView.addSubview(moneyLabel)
       //  addSubview(categoryLabel)
        cellBackground.addSubview(categoryView)
        backView.addSubview(noteLabel)
        backView.addSubview(dateLabel)
        
  
        
     // addSubview(categoryLabel)
     //   categoryLabel.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: <#T##CGFloat#>)
        
        backgroundColor = UIColor.clear
        

       // categoryLabel.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: 0, width: 0, height: 0)
        
     //  categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        moneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        moneyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cellBackground.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, paddingTop: 5, paddingBottom: -5, paddingLeft: 10, paddingRight: 0, width: 45, height: 0)
       
        cellBackground.layer.cornerRadius = 22.5
        
        noteLabel.anchor(top: cellBackground.topAnchor, bottom: nil, leading: cellBackground.trailingAnchor, trailing: moneyLabel.leadingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 7, paddingRight: -7, width: 0, height: 20)
        dateLabel.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -5).isActive = true
        
        dateLabel.anchor(top: nil, bottom: cellBackground.bottomAnchor, leading: noteLabel.leadingAnchor, trailing: moneyLabel.leadingAnchor, paddingTop: 0, paddingBottom: -5, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
        
        categoryView.anchor(top: cellBackground.topAnchor, bottom: cellBackground.bottomAnchor, leading: cellBackground.leadingAnchor, trailing: cellBackground.trailingAnchor, paddingTop: 9, paddingBottom: -9, paddingLeft: 9, paddingRight: -9, width: 0, height: 0)
        
        
        
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
