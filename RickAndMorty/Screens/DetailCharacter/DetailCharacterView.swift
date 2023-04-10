//
//  DetailCharacterView.swift
//  RickAndMorty
//
//  Created by User on 09.04.2023.
//

import Foundation

protocol IDetailCharacterView: AnyObject {
	func reloadData()
	func update(title: String)
}
