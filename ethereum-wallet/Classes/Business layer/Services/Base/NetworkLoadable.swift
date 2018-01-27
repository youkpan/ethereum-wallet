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


import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol NetworkLoadable {
  typealias ResultObjectBlock<T> = (Result<T>) -> Void
  typealias ResultJSONBlock = (Result<Any>) -> Void
  typealias ResultArrayBlock<T> = (Result<[T]>) -> Void
  
  func loadObject<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String?, completion: @escaping ResultObjectBlock<PlainType>)
  func loadObjectJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock)
  func loadArrayJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock)
  func loadArray<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String?, completion: @escaping ResultArrayBlock<PlainType>)
}

extension NetworkLoadable {
  
  // MARK: - Response Object
  
  func loadObject<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultObjectBlock<PlainType>) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.ObjectMapperImmutableSerializer(keyPath, context: nil),
                                 completion: completion)
    operation.execute()
  }
  
  // MARK: - Response JSON
  
  func loadObjectJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments),
                                 completion: completion)
    operation.execute()
  }
  
  func loadArrayJSON(request: URLRequestConvertible, completion: @escaping ResultJSONBlock) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments),
                                 completion: completion)
    operation.execute()
  }
  
  // MARK: - Response Array
  
  func loadArray<PlainType: ImmutableMappable>(request: URLRequestConvertible, keyPath: String? = nil, completion: @escaping ResultArrayBlock<PlainType>) {
    let operation = AnyOperation(request: request,
                                 responseSerializer: DataRequest.ObjectMapperImmutableArraySerializer(keyPath, context: nil),
                                 completion: completion)
    operation.execute()
  }
}

private protocol NetworkOperationProtocol {
  associatedtype ResponseSerializer: DataResponseSerializerProtocol
  typealias ResponseObject = ResponseSerializer.SerializedObject
  
  var request: URLRequestConvertible { get }
  var responseSerializer: ResponseSerializer { get }
  var completion: ((Result<ResponseObject>) -> Void)? { get }
}

private struct AnyOperation<ResponseSerializer: DataResponseSerializerProtocol>: NetworkOperationProtocol {
  
  var request: URLRequestConvertible
  var responseSerializer: ResponseSerializer
  var completion: ((Result<ResponseSerializer.SerializedObject>) -> Void)?
  
  func execute() {
    Alamofire.request(request).response(queue: DispatchQueue.main, responseSerializer: responseSerializer) { response in
      self.completion?(response.result)
    }
  }
}
