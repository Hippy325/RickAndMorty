//
//  ImageLoaderSpy.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//

import Foundation
@testable import RickAndMorty
import UIKit

final class ImageLoaderSpy: IImageLoader {

	var invokedLoadImage = false
	var invokedLoadImageCount = 0
	var invokedLoadImageParameters: (url: URL, Void)?
	var stubbedLoadImageCompletionResult: (Result<UIImage, Error>, Void)?

	func loadImage(
		from url: URL,
		completion: @escaping (Result<UIImage, Error>) -> Void
	) -> ICancellable {
		invokedLoadImage = true
		invokedLoadImageCount += 1
		invokedLoadImageParameters = (url, ())
		if let result = stubbedLoadImageCompletionResult {
			completion(result.0)
		}
		return Cancellable()
	}
}
