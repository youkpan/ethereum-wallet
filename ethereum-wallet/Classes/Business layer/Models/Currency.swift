// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.



import UIKit

protocol Currency {
  var raw: NSDecimalNumber { get }
  var value: Double { get }
  var name: String { get }
  var iso: String { get }
  var symbol: String { get }
}

extension Currency {
  var fullName: String {
    return "\(name) (\(iso))"
  }
  
  var fullNameWithSymbol: String {
    return "\(symbol)\t\(fullName)"
  }
  
  var amount: String {
    let valueString = NSDecimalNumber(string: "\(value)").stringValue
    return "\(valueString) \(symbol)"
  }
  
  func amount(in iso: String, rate: Double) -> String {
    let total = value * rate
    return total.amount(for: iso)
  }
  
}
