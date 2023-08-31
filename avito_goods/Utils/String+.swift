//
//	String+.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import Foundation

extension String {
    public func formatPriceString() -> String {
        guard self.count > 3 else { return self }
        var arrayString = Array(self)
        arrayString.reverse()
        let sign = arrayString[0]
        arrayString.removeFirst(2)
        let arrayStringCount = arrayString.count
        var result = [Character]()
        
        for i in 0 ..< arrayStringCount {
            if i % 3 == 0 && i != arrayStringCount, i != 0 {
                result += " "
            }
            
            result.append(arrayString[i])
            
        }
        
        result.reverse()
        result += " " + String(sign)
        
        return String(result)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        let inputDate = "yyyy-MM-dd"
        let outputDate = "EEEE, d MMM yyyy"
        dateFormatter.dateFormat = inputDate
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = outputDate
        let formattedDate = dateFormatter.string(from: date)
        let capitalizedDate = formattedDate.prefix(1).uppercased() + formattedDate.dropFirst()
        return capitalizedDate
    }
    
    var formatPhoneNumber: String {
        var result = [Character]()
        for char in self {
            if char.isNumber {
                result.append(char)
            }
        }
        
        return String(result)
    }
}

