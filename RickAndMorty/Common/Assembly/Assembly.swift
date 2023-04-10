//
//  Assembly.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

final class Assembly: IAssembly {

	// MARK: - Common
	lazy private(set) var imageLoader: IImageLoader = ImageLoader(httpTransport: httpTransport)

	lazy private(set)var httpTransport: IHTTPTransport = {
		HTTPTransport(session: session, decoder: decoder)
	}()

	lazy private(set) var decoder: JSONDecoder = .init()

	lazy private(set) var session: URLSession = .shared

	var characterPageLoader: ICharacterPageLoader {
		CharacterPageLoader(httpTransport: httpTransport)
	}

	// MARK: - Navigation

	lazy var navigationViewControllerAssembly: INavigationViewControllerAssembly = NavigationViewControllerAssembly()

	lazy var navigationController: UINavigationController = self.navigationViewControllerAssembly.assembly()

	// MARK: - Screens

	var characterListViewControllerAssembly: ICharacterListViewControllerAssembly {
		CharacterListViewControllerAssembly(
			characterPageLoader: characterPageLoader,
			imageLoader: imageLoader,
			detailCharacterViewControllerAssembly: detailCharacterViewControllerAssembly,
			navigationController: navigationController
		)
	}

	var detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly {
		DetailCharacterViewControllerAssembly(
			imageLoader: imageLoader,
			characterLoader: CharacterLoader(httpTransport: httpTransport)
		)
	}
}
