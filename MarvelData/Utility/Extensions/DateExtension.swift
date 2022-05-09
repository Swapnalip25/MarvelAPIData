//
//  DateExtension.swift
//  MarvelData
//
//  Created by Swapnali Patil on 21/04/22.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSSSS'Z'"
        return dateFormatter.string(from: self)
    }
}
