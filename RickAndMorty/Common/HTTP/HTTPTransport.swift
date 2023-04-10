//
//  HTTPTransport.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation

final class HTTPTransport {

	// MARK: - Properties

	private let session: URLSession
	private let decoder: JSONDecoder

	// MARK: - Init

	init(session: URLSession, decoder: JSONDecoder) {
		self.session = session
		self.decoder = decoder
	}
}

// MARK: - Protocol implementation

extension HTTPTransport: IHTTPTransport {

	enum Error: String, Swift.Error {
		case invalidUrl
	}

	func loadData(url: URL, completion: @escaping (Result<Data, Swift.Error>, URLResponse?) -> Void) -> ICancellable {
		let task = session.dataTask(with: url) { (data, response, error) in
			if let data = data {
				completion(.success(data), response)
			} else if let error = error {
				completion(.failure(error), response)
			} else {
				completion(.failure(URLError(.unknown)), response)
			}
		}

		task.resume()

		return task
	}

	func loadData(
		stringUrl: String,
		completion: @escaping (Result<Data, Swift.Error>, URLResponse?) -> Void
	) -> ICancellable {

		guard let url = URL(string: stringUrl) else {
			completion(.failure(Error.invalidUrl), nil)
			return Cancellable {}
		}

		return loadData(url: url, completion: completion)
	}

	func load<T: Decodable>(
		url: URL,
		responseType: T.Type,
		completion: @escaping (Result<T, Swift.Error>, URLResponse?) -> Void
	) -> ICancellable {
		loadData(url: url) { [decoder] (result, response) in
			switch result {
			case .success(let data):
				do {
					let decodedData = try decoder.decode(T.self, from: data)
					completion(.success(decodedData), response)
				} catch {
					completion(.failure(error), response)
				}
			case .failure(let error):
				completion(.failure(error), response)
			}
		}
	}

	func load<T: Decodable>(
		stringUrl: String,
		responseType: T.Type,
		completion: @escaping (Result<T, Swift.Error>, URLResponse?) -> Void
	) -> ICancellable {
		guard let url = URL(string: stringUrl) else {
			completion(.failure(Error.invalidUrl), nil)
			return Cancellable {}
		}

		return load(url: url, responseType: responseType, completion: completion)
	}
}
