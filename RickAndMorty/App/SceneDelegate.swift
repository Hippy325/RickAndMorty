//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	let assembly: IAssembly = Assembly()

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()
		let navigationController = assembly.navigationController
		let characterListViewController = assembly.characterListViewControllerAssembly.assemble()
		navigationController.viewControllers = [characterListViewController]
		window?.rootViewController = navigationController
	}

	func sceneDidDisconnect(_ scene: UIScene) {
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
	}

	func sceneWillResignActive(_ scene: UIScene) {
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
	}
}
