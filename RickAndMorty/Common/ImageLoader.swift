//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation
import UIKit

protocol IImageLoader {
	@discardableResult
	func loadImage(
		from url: URL,
		completion: @escaping (Result<UIImage, Error>) -> Void
	) -> ICancellable
}

final class ImageLoader: IImageLoader {

	enum Error: String, Swift.Error {
		case cannotConvertDataToImage
	}

	// MARK: - Properties

	private let httpTransport: IHTTPTransport
	private let lock = NSLock()
	private var images: [URL: UIImage] = [:]

	// MARK: - Init

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	// MARK: - Private

	private func set(image: UIImage, for url: URL) {
		lock.lock()
		images[url] = image
		lock.unlock()
	}

	private func get(for url: URL) -> UIImage? {
		lock.lock()
		let image = images[url]
		lock.unlock()
		return image
	}

	// MARK: - Protocol implementation

	func loadImage(
		from url: URL,
		completion: @escaping (Result<UIImage, Swift.Error>) -> Void
	) -> ICancellable {

		if let image = get(for: url) {
			completion(.success(image))
			return Cancellable()
		}

		return httpTransport.loadData(url: url) { (result, _) in
			switch result {
			case .success(let data):
				guard let image = UIImage(data: data) else {
					return completion(.failure(Error.cannotConvertDataToImage))
				}
				self.set(image: image, for: url)
				completion(.success(image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
