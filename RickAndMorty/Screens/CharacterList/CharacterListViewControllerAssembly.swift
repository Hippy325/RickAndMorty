//
//  CharacterListViewControllerAssembly.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation
import UIKit

protocol ICharacterListViewControllerAssembly {
	func assemble() -> UIViewController
}

final class CharacterListViewControllerAssembly: ICharacterListViewControllerAssembly {

	// MARK: - Properties

	private let characterPageLoader: ICharacterPageLoader
	private let imageLoader: IImageLoader
	private let detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	private let navigationController: UINavigationController

	// MARK: - Init

	init(
		characterPageLoader: ICharacterPageLoader,
		imageLoader: IImageLoader,
		detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly,
		navigationController: UINavigationController
	) {
		self.characterPageLoader = characterPageLoader
		self.imageLoader = imageLoader
		self.detailCharacterViewControllerAssembly = detailCharacterViewControllerAssembly
		self.navigationController = navigationController
	}

	// MARK: - Protocol implementation

	func assemble() -> UIViewController {
		let router = CharacterListRouter(
			detailCharacterViewControllerAssembly: detailCharacterViewControllerAssembly
			)
		router.navigationCantroller = navigationController
		let presenter = CharacterListPresenter(
			characterPageLoader: characterPageLoader,
			imageLoader: imageLoader,
			router: router
		)
		let characterList = CharacterListVC(presenter: presenter)
		presenter.view = characterList
		return characterList
	}
}
