//
//  Date+EXT.swift
//  NewsApp
//
//  Created by Mine Rala on 23.10.2021.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy"
          return dateFormatter.string(from: self)
      }
}

extension String {

     func convertToDate() -> Date? {
         let dateFormatter           = DateFormatter()
         dateFormatter.locale = Locale(identifier: "en_US_POSIX") 
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         dateFormatter.timeZone      = .current

         return dateFormatter.date(from: self)
     }


     func convertToDisplayFormat() -> String {
         guard let date = self.convertToDate() else { return "N/A" }
         return date.convertToMonthYearFormat()
     }
    }

