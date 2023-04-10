//
//  Cancellable.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation

protocol ICancellable {
	func cancel()
}

struct Cancellable: ICancellable {

	// MARK: - Properties

	private let cancelClosure: () -> Void

	// MARK: - Init

	init(_ cancelClosure: @escaping () -> Void = {}) {
		self.cancelClosure = cancelClosure
	}

	// MARK: - Protocol implementation

	func cancel() {
		cancelClosure()
	}
}

extension URLSessionTask: ICancellable {}
