//
//  NavigarionViewControllerAssembly.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation
import UIKit

protocol INavigationViewControllerAssembly {
	func assembly() -> UINavigationController
}

final class NavigationViewControllerAssembly: INavigationViewControllerAssembly {

	// MARK: - Protocol implementation

	func assembly() -> UINavigationController {
		let navigationController = UINavigationController()
		navigationController.navigationBar.backgroundColor = .clear
		navigationController.navigationBar.prefersLargeTitles = true
		return navigationController
	}
}
