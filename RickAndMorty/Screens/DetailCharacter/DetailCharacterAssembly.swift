//
//  DetailCharacterAssembly.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

protocol IDetailCharacterViewControllerAssembly {
	func assembly(index: Int) -> UIViewController
}

final class DetailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly {

	// MARK: - Properties

	private let imageLoader: IImageLoader
	private let characterLoader: ICharacterLoader

	// MARK: - Init

	init(imageLoader: IImageLoader, characterLoader: ICharacterLoader) {
		self.imageLoader = imageLoader
		self.characterLoader = characterLoader
	}

	// MARK: - Protocol implementation

	func assembly(index: Int) -> UIViewController {
		let presenter = DetailCharacterPresenter(
			characterIndex: index,
			imageLoader: imageLoader,
			characterLoader: characterLoader
		)
		let detailCharacter = DetailCharacterVC(presenter: presenter)
		presenter.view = detailCharacter
		return detailCharacter
	}
}
