//
//  CharacterListRouterSpy.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//

import Foundation
@testable import RickAndMorty
import UIKit

final class CharacterListRouterSpy: ICharacterListRouter {
	weak var navigationCantroller: UINavigationController?

	var invokedPushToDetailCharacter = false
	var invokedPushToDetailCharacterCount = 0
	var index: Int = -1

	func pushToDetailCharacter(index: Int) {
		invokedPushToDetailCharacter = true
		invokedPushToDetailCharacterCount += 1
		self.index = index
	}
}
