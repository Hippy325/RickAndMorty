//
//  CharacterListRouter.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

protocol ICharacterListRouter {
	var navigationCantroller: UINavigationController? { get set }

	func pushToDetailCharacter(index: Int)
}

final class CharacterListRouter: ICharacterListRouter {

	// MARK: - Properties

	private let detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	weak var navigationCantroller: UINavigationController?

	// MARK: - Init

	init(
		detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly
	) {
		self.detailCharacterViewControllerAssembly = detailCharacterViewControllerAssembly
	}

	// MARK: - Protocol implementation

	func pushToDetailCharacter(index: Int) {
		navigationCantroller?.pushViewController(
			detailCharacterViewControllerAssembly.assembly(index: index), animated: true
		)
	}
}
