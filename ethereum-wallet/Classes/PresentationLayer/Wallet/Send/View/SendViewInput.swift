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


protocol SendViewInput: class, Presentable {
  func setupInitialState()
  func didReceiveCurrency(_ currency: String)
  func inputDataIsValid(_ isValid: Bool)
  func didReceiveGasLimit(_ gasLimit: Decimal)
  func didReceiveGasPrice(_ gasPrice: Decimal)
  func didDetectQRCode(_ code: String)
  func didChanged(totalAmount: Decimal, totalEther: Ether, fee: Decimal, feeEther: Ether, iso: String)
  func showLoading()
  func loadingSuccess()
  func loadingFilure()
}
