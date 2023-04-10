//
//  CharacterPageLoaderSpy.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//

import Foundation
@testable import RickAndMorty

final class CharacterPageLoaderSpy: ICharacterPageLoader {
	weak var delegate: ICharacterPageLoaderDelegate?

	var invokedIsStartedGetter = false
	var invokedIsStartedGetterCount = 0
	var stubbedIsStarted: Bool! = false

	var isStarted: Bool {
		invokedIsStartedGetter = true
		invokedIsStartedGetterCount += 1
		return stubbedIsStarted
	}

	var invokedIsFinishedGetter = false
	var invokedIsFinishedGetterCount = 0
	var stubbedIsFinished: Bool! = false

	var isFinished: Bool {
		invokedIsFinishedGetter = true
		invokedIsFinishedGetterCount += 1
		return stubbedIsFinished
	}

	var invokedLoadNextPage = false
	var invokedLoadNextPageCount = 0

	func loadNextPage() {
		stubbedIsStarted = true
		invokedLoadNextPage = true
		invokedLoadNextPageCount += 1
	}
}
