//
//  View.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import UIKit

extension String: Error {}

extension String {
    //get string length
    var length: Int {
        return self.count
    }

    //check a string contain a sting
    func contains(string: String) -> Bool{
        return self.range(of: string) != nil
    }
    
    var isValidName: Bool {
        let REGEX = "^[a-zA-Z-.\\s]{3,30}+"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: self)
    }
}

extension Double {
    var doubleToString: String {
        return String(format: "%.1f", self)
    }
}

extension String {
    var localToUTC: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm:ss a" //Your New Date format as per requirement change it own
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm:ss a"
        if dt != nil {
            return dateFormatter.string(from: dt!)
        }
        return nil
    }
}

extension String {
    func getFormattedDate() -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // This formate is input formated .
        
        if let formateDate = dateFormatter.date(from:self) {
            dateFormatter.dateFormat = "YYYY-MM-dd" // Output Formated
            return dateFormatter.string(from: formateDate)
        }
        return nil
    }
}

extension String {
    func convertStringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from:self)
    }
}


extension String {
    func getParameterForUrlString(param: String) -> String? {
        let url = URL(string: self)
        if let url = url,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let parameterWeWant = urlComponents.queryItems?.filter({ $0.name == param }).first
            return parameterWeWant?.value ?? "REJECTED"
        }
        return nil
    }
}

extension String {
    static func dateString(from date: Date, 
                           timeZone: String) -> (dateStr: String,
                                                 dateFormatter: DateFormatter) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "MMM d, EEE, hh:mm a"
        dateFormatter.locale = Locale(identifier: "en")
        return (dateFormatter.string(from: date),
                dateFormatter)
    }
}
