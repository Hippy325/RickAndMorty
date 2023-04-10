//
//  DispatchQueueSpy.swift
//  RickAndMortyTests
//
//  Created by User on 09.04.2023.
//
// swiftlint:disable large_tuple

import Foundation
@testable import RickAndMorty

final class DispatchQueueSpy: IDispatchQueue {

	var invokedAsync = false
	var invokedAsyncCount = 0
	var invokedAsyncParameters: (group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags)?
	var invokedAsyncParametersList = [(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags)]()

	func async(
		group: DispatchGroup?,
		qos: DispatchQoS,
		flags: DispatchWorkItemFlags,
		execute work: @escaping @convention(block) () -> Void
	) {
		invokedAsync = true
		invokedAsyncCount += 1
		invokedAsyncParameters = (group, qos, flags)
		invokedAsyncParametersList.append((group, qos, flags))
		work()
	}
}
