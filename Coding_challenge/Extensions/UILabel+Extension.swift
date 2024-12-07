//
//  UILabel+Extension.swift
//  Coding_challenge
//
//  Created by Dung-pc on 07/12/2024.
//

import UIKit

extension UILabel {
    func createLabel(
        font: UIFont = .systemFont(ofSize: 14),
        textColor: UIColor = .gray,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        translatesAutoresizingMaskIntoConstraints: Bool = false
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    }
}

extension Double {
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
}
