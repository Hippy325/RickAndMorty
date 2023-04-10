//
//  CharacterItem.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

enum CharacterListItem: Hashable {
	case character(characterItem: CharacterItem)
	case loader
}

struct CharacterItem: Hashable {

	// MARK: - Properties

	let index: Int
	let name: String
	let race: String
	let gender: String

	let loadImage: (_ imageSetter: @escaping (UIImage?) -> Void) -> ICancellable

	// MARK: - Hashable

	static func == (lhs: CharacterItem, rhs: CharacterItem) -> Bool {
		lhs.index == rhs.index
			&& lhs.name == rhs.name
			&& lhs.race == rhs.race
			&& lhs.gender == rhs.gender
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(index)
		hasher.combine(name)
		hasher.combine(race)
		hasher.combine(gender)
	}
}
