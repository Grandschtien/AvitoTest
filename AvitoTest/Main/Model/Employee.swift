//
//  Employee.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 07.09.2021.
//

import Foundation

struct Employee: Codable {
    var name, phoneNumber: String?
    var skills: [String]?
    
    enum CodingKeys: String, CodingKey {
           case name
           case phoneNumber = "phone_number"
           case skills
       }
}
