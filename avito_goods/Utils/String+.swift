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
        var arrStr = Array(self)
        arrStr.reverse()
        let sign = arrStr[0]
        arrStr.removeFirst(2)
        let arrStrCount = arrStr.count
        var res = [Character]()
        
        for i in 0 ..< arrStrCount {
            if i % 3 == 0 && i != arrStrCount - 1 {
                res += " "
            }
            res.append(arrStr[i])
        }
        
        res.reverse()
        res += " " + String(sign)
        
        return String(res)
    }
}
