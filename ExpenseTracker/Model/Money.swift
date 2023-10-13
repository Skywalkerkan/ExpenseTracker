//
//  Money.swift
//  ExpenseTracker
//
//  Created by Erkan on 27.08.2023.
//

import Foundation



struct Money{
    
    
    let category: String?
    let imageName: String?

}


struct savedTrack{
    
    let category: String?
    let id: UUID?
    let note: String?
    let moneyEach: Float?
    let date: Date?
    let dateString: String?
    
}
