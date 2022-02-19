//
//  Extensions.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/19/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
