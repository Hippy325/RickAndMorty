//
//  CharacterPageLoader.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation

private extension String {
	static let characterUrl = "https://rickandmortyapi.com/api/character"
}

// MARK: - IProtocol

protocol ICharacterPageLoaderDelegate: AnyObject {
	func didSuccessLoaded(characters: [Character])
	func didFailureLoaded(error: Error)
}

// MARK: - IProtocol

protocol ICharacterPageLoader: AnyObject {
	var delegate: ICharacterPageLoaderDelegate? { get set }
	var isStarted: Bool { get }
	var isFinished: Bool { get }

	func loadNextPage()
}

final class CharacterPageLoader: ICharacterPageLoader {

	// MARK: - Properties

	private let httpTransport: IHTTPTransport
	private var nextPageUrl: URL? = URL(string: .characterUrl)

	// MARK: - Protocol properties

	var isStarted: Bool = false
	var isFinished: Bool = false

	weak var delegate: ICharacterPageLoaderDelegate?

	// MARK: - Init

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	// MARK: - Protocol implementation

	func loadNextPage() {
		guard !isFinished else { return }

		isStarted = true
		guard let url = nextPageUrl else { return }
		httpTransport.load(url: url, responseType: CharacterResponse.self) { [weak self] (result, response) in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				self.nextPageUrl = response.info.next
				self.isFinished = response.info.next == nil
				self.delegate?.didSuccessLoaded(characters: response.results)
			case .failure(let error):
				self.delegate?.didFailureLoaded(error: error)
			}
		}
	}
}
