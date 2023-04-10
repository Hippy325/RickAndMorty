//
//  IHTTPTransport.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation

protocol IHTTPTransport {

	@discardableResult
	func loadData(
		stringUrl: String,
		completion: @escaping (Result<Data, Error>, URLResponse?) -> Void
	) -> ICancellable

	@discardableResult
	func load<T: Decodable>(
		stringUrl: String,
		responseType: T.Type,
		completion: @escaping (Result<T, Error>, URLResponse?) -> Void
	) -> ICancellable

	@discardableResult
	func loadData(
		url: URL,
		completion: @escaping (Result<Data, Error>, URLResponse?) -> Void
	) -> ICancellable

	@discardableResult
	func load<T: Decodable>(
		url: URL,
		responseType: T.Type,
		completion: @escaping (Result<T, Error>, URLResponse?) -> Void
	) -> ICancellable
}
