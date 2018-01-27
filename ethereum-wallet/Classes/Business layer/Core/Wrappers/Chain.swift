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



import Geth

enum Chain: String {
  
  case mainnet
  case ropsten
  case rinkeby
  
  static var `default`: Chain {
    return .mainnet
  }
  
  var chainId: Int64 {
    switch self {
    case .mainnet:
      return 5767778797
    case .ropsten:
      return 5767778797
    case .rinkeby:
      return 5767778797
    }
  }
  
  var netStats: String? {
    switch self {
    case .rinkeby:
      return "flypaper:Respect my authoritah!@stats.rinkeby.io"
    default:
      return nil
    }
  }
  
  var enode: String? {
    switch self {
    case .mainnet:
      return nil
    case .ropsten:
      return Constants.Ethereum.ropstenEnodeRawUrl
    case .rinkeby:
      return Constants.Ethereum.rinkebyEnodeRawUrl
    }
  }
  
  var genesis: String {
    switch self {
    case .mainnet:
      return GethMainnetGenesis()
    case .ropsten:
      return GethTestnetGenesis()
    case .rinkeby:
      return GethRinkebyGenesis()
    }
  }
  
  var description: String {
    return "\(self)"
  }
  
  var localizedDescription: String {
    switch self {
    case .mainnet:
      return "Mainnet"
    case .ropsten:
      return "Ropsten Testnet"
    case .rinkeby:
      return "Rinkeby Testnet"
    }
  }
  
  var path: String {
    return "/.\(description)"
  }
  
  var etherscanUrl: String {
    switch self {
    case .mainnet:
      return "heapi.hayoou.com"
    case .ropsten:
      return "heapi.hayoou.com"
    case .rinkeby:
      return "heapi.hayoou.com"
    }
  }
  
  var clientUrl: String {
    switch self {
    case .mainnet:
      return "https://mainnet.infura.io"
    case .ropsten:
      return "https://ropsten.infura.io"
    case .rinkeby:
      return "https://rinkeby.infura.io"
    }
  }
  
  static func all() -> [Chain] {
    return [.mainnet, .ropsten, .rinkeby]
  }
  
}
