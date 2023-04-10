//
//  DetailCharacterPresenter.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

protocol IDetailCharacterPresenter: AnyObject {
	func didLoad()
	var model: DetailModel? { get }
}

// MARK: - Detail data model

struct DetailModel {
	let name: String
	let race: String
	let gender: String
	let status: String
	let location: String
	let countEpisode: String

	let loadImage: (_ imageSetter: @escaping (UIImage?) -> Void) -> ICancellable
}

final class DetailCharacterPresenter {

	// MARK: - Properties

	private let imageLoader: IImageLoader
	private let mainQueue: IDispatchQueue
	private let characterLoader: ICharacterLoader

	private let characterIndex: Int

	weak var view: IDetailCharacterView?

	var model: DetailModel? {
		didSet {
			mainQueue.async {
				self.view?.reloadData()
				self.view?.update(title: self.model?.name ?? "Rick && Morty")
			}
		}
	}

	// MARK: - Init

	init(
		characterIndex: Int,
		imageLoader: IImageLoader,
		characterLoader: ICharacterLoader,
		mainQueue: IDispatchQueue = DispatchQueue.main
	) {
		self.characterIndex = characterIndex
		self.mainQueue = mainQueue
		self.imageLoader = imageLoader
		self.characterLoader = characterLoader
	}
}

// MARK: - Protocol implementation

extension DetailCharacterPresenter: IDetailCharacterPresenter {
	func didLoad() {
		characterLoader.load(characterIndex: characterIndex) { [weak self] (result) in
			guard let self = self, let character = try? result.get() else { return }
			let detailModel = self.transformCharacter(from: character)
			DispatchQueue.main.async {
				self.model = detailModel
			}
		}
	}
}

extension DetailCharacterPresenter {

	// MARK: - Private

	private func transformCharacter(from character: Character) -> DetailModel {
		DetailModel(
			name: character.name,
			race: character.species,
			gender: character.gender,
			status: character.status,
			location: character.location.name,
			countEpisode: String(character.episode.count)
		) { [imageLoader, url = character.image] imageSetter in
			guard let url = url else { return Cancellable() }
			return imageLoader.loadImage(from: url) { (result) in
				self.mainQueue.async {
					imageSetter(try? result.get())
				}
			}
		}
	}
}
