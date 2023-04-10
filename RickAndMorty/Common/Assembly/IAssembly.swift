//
//  IAssembly.swift
//  RickAndMorty
//
//  Created by User on 09.04.2023.
//

import Foundation
import UIKit

protocol IAssembly: AnyObject {
	// MARK: - Common
	var session: URLSession { get }
	var decoder: JSONDecoder { get }
	var httpTransport: IHTTPTransport { get }
	var imageLoader: IImageLoader { get }
	var characterPageLoader: ICharacterPageLoader { get }

	// MARK: - Navigation

	var navigationViewControllerAssembly: INavigationViewControllerAssembly { get }
	var navigationController: UINavigationController { get }

	// MARK: - Screens
	var characterListViewControllerAssembly: ICharacterListViewControllerAssembly { get }
	var detailCharacterViewControllerAssembly: IDetailCharacterViewControllerAssembly { get }

}
