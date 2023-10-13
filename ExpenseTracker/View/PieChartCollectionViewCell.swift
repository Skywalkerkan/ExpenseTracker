//
//  PieChartCollectionViewCell.swift
//  ExpenseTracker
//
//  Created by Erkan on 4.09.2023.
//

import UIKit

class PieChartCollectionViewCell: UICollectionViewCell {
    
    
    let categoryBackView: UIView = {
        let imageView = UIView()
       // imageView.backgroundColor = .green
       // imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 12
      //  imageView.layer.borderWidth = 2
      //  imageView.layer.shadowRadius = 15
        //imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
   
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    var categoryImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Kategori"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    let percentageLabel: UILabel = {
       let label = UILabel()
        label.text = "%15"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    let totalExpense: UILabel = {
       let label = UILabel()
        label.text = "%5500"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(categoryBackView)
        categoryBackView.addSubview(categoryImage)
        categoryBackView.addSubview(categoryLabel)
        categoryBackView.addSubview(percentageLabel)
        categoryBackView.addSubview(totalExpense)
        
        
        categoryBackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        categoryImage.anchor(top: nil, bottom: nil, leading: categoryBackView.leadingAnchor, trailing: nil, paddingTop: 5, paddingBottom: -5, paddingLeft: 10, paddingRight: 0, width: 30, height: 30)
        categoryImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
         categoryLabel.anchor(top: topAnchor, bottom: bottomAnchor, leading: categoryImage.trailingAnchor, trailing: categoryBackView.trailingAnchor, paddingTop: 10, paddingBottom: -10, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
        totalExpense.anchor(top: categoryLabel.topAnchor, bottom: categoryLabel.bottomAnchor, leading: nil, trailing: categoryBackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: -5, width: 0, height: 0)
        percentageLabel.anchor(top: categoryLabel.topAnchor, bottom: categoryLabel.bottomAnchor, leading: nil, trailing: categoryBackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 5, paddingRight: -100, width: 0, height: 0)
        
        
        
        
   

       

        
        
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
