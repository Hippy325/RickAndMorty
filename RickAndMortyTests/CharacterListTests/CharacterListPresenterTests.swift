//
//  CharacterListPresenterTests.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//
// swiftlint:disable all

import XCTest
@testable import RickAndMorty

final class CharacterListPresenterTests: XCTestCase {
	var sut: CharacterListPresenter!
	var characterPageLoader: CharacterPageLoaderSpy!
	var imageLoader: ImageLoaderSpy!
	var characterListRouter: CharacterListRouterSpy!
	var mainQueue: DispatchQueueSpy!

	override func setUpWithError() throws {
		try super.setUpWithError()

		characterPageLoader = .init()
		imageLoader = .init()
		characterListRouter = .init()
		mainQueue = .init()
		sut = .init(
			characterPageLoader: characterPageLoader,
			imageLoader: imageLoader,
			router: characterListRouter,
			mainQueue: mainQueue
		)
	}

	override func tearDownWithError() throws {
		imageLoader = nil
		characterListRouter = nil
		mainQueue = nil
		characterPageLoader = nil
		sut = nil

		try super.tearDownWithError()
	}

	func testLoadFirstPage() throws {
		// Arrange
		let rick = Character.makeStub(id: 1, name: "Rick")
		let rickItem = sut.transformCharacter(from: rick)
		let expectedViewModels: [CharacterListItem] = [.character(characterItem: rickItem), .loader]
		// Act
		sut.didLoad()
		characterPageLoader.delegate?.didSuccessLoaded(characters: [rick])

		// Asset
		XCTAssertTrue(characterPageLoader.invokedLoadNextPage)
		XCTAssertTrue(mainQueue.invokedAsync)
		XCTAssertEqual(sut.viewModels, expectedViewModels)
	}

	func testLoadNextPage() throws {
		// Arrange
		let rick = Character.makeStub(id: 1, name: "Rick")
		let morty = Character.makeStub(id: 2, name: "Morty")

		let rickItem = sut.transformCharacter(from: rick)
		let mortyItem = sut.transformCharacter(from: morty)
		let expectedViewModels: [CharacterListItem] = [
			.character(characterItem: rickItem),
			.character(characterItem: mortyItem),
			.loader
		]
		sut.didLoad()
		characterPageLoader.delegate?.didSuccessLoaded(characters: [rick])

		// Act
		sut.nextLoad()
		characterPageLoader.delegate?.didSuccessLoaded(characters: [morty])

		// Asset
		XCTAssertTrue(characterPageLoader.invokedLoadNextPage)
		XCTAssertEqual(sut.viewModels, expectedViewModels)
	}

	func testGoToDetailScreen() throws {
		// Arrange
		let id = 1
		sut.didLoad()
		characterPageLoader.delegate?.didSuccessLoaded(characters: [Character.makeStub(id: id, name: "Rick")])

		// Act
		sut.didSelect(row: 0)

		// Asset
		XCTAssertTrue(characterListRouter.invokedPushToDetailCharacter)
		XCTAssertEqual(characterListRouter.index, id)
	}

	func testTryClickLoad() throws {
		// Arrang
		let id = 1
		sut.didLoad()
		characterPageLoader.delegate?.didSuccessLoaded(characters: [Character.makeStub(id: id, name: "Rick")])

		// Act
		sut.didSelect(row: 1)

		// Asset
		XCTAssertFalse(characterListRouter.invokedPushToDetailCharacter)
	}

	func testLoadImage() throws {
		// Arrange
		let character = Character.makeStub(id: 1, name: "Rick")
		sut.didLoad()

		// Act

		characterPageLoader.delegate?.didSuccessLoaded(characters: [character])
		switch sut.viewModels[0] {
		case .character(characterItem: let item):
			let _ = item.loadImage
		case .loader:
			break
		}

		// Asset
		XCTAssertEqual(imageLoader.invokedLoadImageParameters?.url, character.image)
		XCTAssertTrue(imageLoader.invokedLoadImage)
	}
}
