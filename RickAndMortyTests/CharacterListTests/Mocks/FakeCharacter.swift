//
//  FakeCharacter.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//
// swiftlint:disable identifier_name

import Foundation
@testable import RickAndMorty

extension Character {
	static func makeStub(id: Int, name: String) -> Character {
		let url = URL(string: "https://rickandmortyapi.com/api/character")!

		return Character(
			id: id,
			name: name,
			species: "Human",
			gender: "Male",
			status: "Live",
			location: Location(name: ""),
			episode: [],
			image: url
		)
	}
}
