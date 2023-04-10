//
//  CharacterListPresenter.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

protocol ICharacterListPresenter {
	func didLoad()
	func didSelect(row: Int)
	func nextLoad()
}

final class CharacterListPresenter {

	// MARK: - Properties

	private let characterPageLoader: ICharacterPageLoader
	private let imageLoader: IImageLoader
	private let router: ICharacterListRouter
	weak var view: ICharacterView?
	private let mainQueue: IDispatchQueue

	var viewModels: [CharacterListItem] = [] {
		didSet {
			self.mainQueue.async {
				self.view?.reloadData()
			}
		}
	}

	// MARK: - Init

	init(
		characterPageLoader: ICharacterPageLoader,
		imageLoader: IImageLoader,
		router: ICharacterListRouter,
		mainQueue: IDispatchQueue = DispatchQueue.main
	) {
		self.characterPageLoader = characterPageLoader
		self.imageLoader = imageLoader
		self.router = router
		self.mainQueue = mainQueue
	}
}

// MARK: - Protocol implementation

extension CharacterListPresenter: ICharacterListPresenter {

	func transformCharacter(from character: Character) -> CharacterItem {
		CharacterItem(
			index: character.index,
			name: character.name,
			race: character.species,
			gender: character.gender
		) {  imageSetter in
			guard let url = character.image else { return Cancellable() }
			return self.imageLoader.loadImage(from: url) { (result) in
				self.mainQueue.async {
					imageSetter(try? result.get())
				}
			}
		}
	}

	func didSelect(row: Int) {
		switch viewModels[row] {
		case .character:
			router.pushToDetailCharacter(index: row + 1)
		case .loader:
			break
		}
	}

	func didLoad() {
		characterPageLoader.delegate = self
		characterPageLoader.loadNextPage()
	}

	func nextLoad() {
		characterPageLoader.loadNextPage()
	}
}

// MARK: - Load delegate

extension CharacterListPresenter: ICharacterPageLoaderDelegate {
	func didSuccessLoaded(characters: [Character]) {
		mainQueue.async {
			if self.viewModels.count != 0 {
				self.viewModels.removeLast()
			}
			let items = characters.map { (character) -> CharacterItem in
				self.transformCharacter(from: character)
			}
			items.forEach { (item) in
				self.viewModels.append(.character(characterItem: item))
			}
			if !self.characterPageLoader.isFinished {
				self.viewModels.append(.loader)
			}
		}
	}

	func didFailureLoaded(error: Error) {}
}
