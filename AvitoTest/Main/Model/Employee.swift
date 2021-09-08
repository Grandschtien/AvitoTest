//
//  Employee.swift
//  AvitoTest
//
//  Created by Егор Шкарин on 07.09.2021.
//

import Foundation

struct Employee: Codable {
    let name, phoneNumber: String?
    let skills: [String]?
}
