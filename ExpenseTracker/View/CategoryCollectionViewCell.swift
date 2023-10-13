//
//  CategoryCollectionViewCell.swift
//  ExpenseTracker
//
//  Created by Erkan on 27.08.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
               // backgroundColor = UIColor.blue
                
                
               
                categoryBackView.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 160/255, alpha: 1)
                //UIColor(red: 150/255, green: 255/255, blue: 150/255, alpha: 0.6)
                // UIColor(red: 255/255, green: 221/255, blue: 160/255, alpha: 1)

            } else {
                categoryBackView.backgroundColor = .clear
            }
        }
    }
    
    let categoryBackView: UIView = {
        let imageView = UIView()
       // imageView.backgroundColor = .green
       // imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 12
      //  imageView.layer.borderWidth = 2
        imageView.layer.shadowRadius = 15
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    var category: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    

    
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Kategori"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryBackView)
        categoryBackView.addSubview(category)
        categoryBackView.addSubview(categoryLabel)
        
        
        categoryBackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        category.anchor(top: categoryBackView.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 5, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: 35, height: 35)
        
        category.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
   

       

        categoryLabel.anchor(top: nil, bottom: categoryBackView.bottomAnchor, leading: categoryBackView.leadingAnchor, trailing: categoryBackView.trailingAnchor, paddingTop: 3, paddingBottom: -5, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
        
        
        
        
        
      
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
