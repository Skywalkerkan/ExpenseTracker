//
//  RecentTransactionCollectionViewCell.swift
//  ExpenseTracker
//
//  Created by Erkan on 31.08.2023.
//

import UIKit
import SwipeCellKit

class RecentTransactionCollectionViewCell: SwipeCollectionViewCell, UIGestureRecognizerDelegate {
    

    
    let backView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        view.backgroundColor = UIColor(red: 248/255, green: 249/255, blue: 249/255, alpha: 1)
        
        //view.backgroundColor = .white
        
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        view.layer.shadowColor = UIColor(red: 208/255, green: 211/255, blue: 212/255, alpha: 1).cgColor
        view.layer.shadowRadius = 3.5
        view.layer.shadowOpacity = 1
        
        return view
    }()
    
    
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.font = .italicSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.text = "1523534"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.text = "31 Ağu 2023"
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
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let noteLabel: UILabel = {
       let label = UILabel()
        label.text = "Note yazmak artık Çok kolay baba"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor(red: 246/255, green: 241/255, blue: 233/255, alpha: 1)
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    let cellBackground: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 214/255, green: 234/255, blue: 248/255, alpha: 0.6)
        return view
    }()
    
    
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(backView)
       // addSubview(backView)
        backView.addSubview(cellBackground)
        backView.addSubview(moneyLabel)
       //  addSubview(categoryLabel)
        cellBackground.addSubview(categoryView)
        backView.addSubview(noteLabel)
        backView.addSubview(dateLabel)
        
       
        
        backView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 7, paddingRight: -7, width: 0, height: 0)
        cellBackground.backgroundColor = .red
        cellBackground.layer.cornerRadius = frame.size.height / 2 - 10
        cellBackground.anchor(top: backView.topAnchor, bottom: backView.bottomAnchor, leading: backView.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: -10, paddingLeft: 10, paddingRight: 0, width: 40, height: 0)
        moneyLabel.centerYAnchor.constraint(equalTo: cellBackground.centerYAnchor).isActive = true
        moneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        noteLabel.anchor(top: cellBackground.topAnchor, bottom: nil, leading: cellBackground.trailingAnchor, trailing: moneyLabel.leadingAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 7, paddingRight: -5, width: 0, height: 20)
      //  dateLabel.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -5).isActive = true
        
        dateLabel.anchor(top: noteLabel.bottomAnchor, bottom: nil, leading: noteLabel.leadingAnchor, trailing: moneyLabel.leadingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
        
        
        categoryView.anchor(top: cellBackground.topAnchor, bottom: cellBackground.bottomAnchor, leading: cellBackground.leadingAnchor, trailing: cellBackground.trailingAnchor, paddingTop: 10, paddingBottom: -10, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
   
    }
    
    
  /*  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let userInterfaceStyler = traitCollection.userInterfaceStyle
        
        if userInterfaceStyler == .dark{
            backView.backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
            noteLabel.textColor = UIColor(red: 208/255, green: 211/255, blue: 212/255, alpha: 1)
            dateLabel.textColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        }else{
            backView.backgroundColor = UIColor(red: 248/255, green: 249/255, blue: 249/255, alpha: 1)
            //noteLabel.textColor = .black
            if noteLabel.text == "Not Yok" {
                noteLabel.textColor = UIColor.lightGray
            }else{
                noteLabel.textColor = UIColor.black
            }
            dateLabel.textColor = .lightGray

        }
        
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

