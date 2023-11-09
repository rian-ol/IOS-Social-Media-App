//
//  CollegeList.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import Foundation


enum College: String, CaseIterable, Identifiable{
    
    case UniversityOfLimerick
    case UniversityOfGalway
    
    var name: String{
        switch self{
        case .UniversityOfLimerick: return "University of Limerick"
        case .UniversityOfGalway: return "University of Galway"
        }
    }
    
    
    var id: Self{return self}
}
