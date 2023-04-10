//
//  CharacterLoader.swift
//  RickAndMorty
//
//  Created by User on 09.04.2023.
//

import Foundation

private extension String {
	static let characterURL = "https://rickandmortyapi.com/api/character/"
}

// MARK: - IProtocol

protocol ICharacterLoader: AnyObject {
	func load(characterIndex: Int, _ completion: @escaping (Result<Character, Error>) -> Void)
}

final class CharacterLoader: ICharacterLoader {

	// MARK: - Properties

	private let httpTransport: IHTTPTransport

	// MARK: - Init

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	// MARK: - Protocol implementation

	func load(characterIndex: Int, _ completion: @escaping (Result<Character, Error>) -> Void) {
		httpTransport.load(
			stringUrl: String.characterURL.appending(String(characterIndex)),
			responseType: Character.self
		) { result, _ in
			completion(result)
		}
	}
}
