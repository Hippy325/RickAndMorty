//
//  IDispatchQueue.swift
//  RickAndMorty
//
//  Created by User on 08.04.2023.
//

import Foundation

protocol IDispatchQueue {
	func async(
		group: DispatchGroup?,
		qos: DispatchQoS,
		flags: DispatchWorkItemFlags,
		execute work: @escaping @convention(block) () -> Void
	)
}

extension IDispatchQueue {
	public func async(
		group: DispatchGroup? = nil,
		qos: DispatchQoS = .unspecified,
		flags: DispatchWorkItemFlags = [],
		execute work: @escaping @convention(block) () -> Void
	) {
		async(group: group, qos: qos, flags: flags, execute: work)
	}
}

extension DispatchQueue: IDispatchQueue {}
