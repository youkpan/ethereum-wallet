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

final class Defaults: NSObject {
  
  class var isAuthorized: Bool {
    get {
      return getBool(forKey: .isAuthorized)
    }
    
    set {
      set(value: newValue, forKey: .isAuthorized)
    }
  }
  
  class var chain: Chain {
    get {
      let raw: String =  get(forKey: .chain, fallback: Chain.mainnet.rawValue)
      return Chain(rawValue: raw)!
    }
    
    set {
      set(value: newValue.rawValue, forKey: .chain)
    }
  }
  
  class var mode: SyncMode {
    get {
      let raw: Int = get(forKey: .mode, fallback: SyncMode.standard.rawValue)
      return SyncMode(rawValue: raw)!
    }
    
    set {
      set(value: newValue.rawValue, forKey: .mode)
    }
  }
}

private extension Defaults {
  
  enum Keys: String {
    case isAuthorized = "isAuthorizedKey"
    case chain = "chainKey"
    case mode = "syncMode"
  }
  
  static func set<T: Any>(value: T, forKey key: Keys) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }
  
  static func get<T: Any>(forKey key: Keys, fallback: T) -> T {
    if let value = UserDefaults.standard.value(forKey: key.rawValue) as? T {
      return value
    }
    
    return fallback
  }
  
  static func getBool(forKey key: Keys) -> Bool {
    return UserDefaults.standard.bool(forKey: key.rawValue)
  }
  
}
