//
//  DetailCharacter.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import Foundation
import UIKit

final class DetailCharacterVC: UIViewController {

	// MARK: - Subviews

	private struct Subviews {
		let raceView = UILabel()
		let statusView = UILabel()
		let genderView = UILabel()
		let locationView = UILabel()
		let countEpisodeView = UILabel()
		let avatarView = UIImageView()
	}

	// MARK: - Properties

	private let presenter: IDetailCharacterPresenter
	private let subviews = Subviews()
	private let stackView = UIStackView()
	private let titleView = TitleView()

	// MARK: - Init

	init(presenter: IDetailCharacterPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		view.backgroundColor = UIColor(named: "DetailBackgraundColor")
		setup()
		presenter.didLoad()

		navigationItem.titleView = titleView
	}

	// MARK: - Private

	private func setup() {
		navigationController?.navigationBar.tintColor = UIColor(named: "NavigatinBarButtonColor")

		view.addSubview(stackView)
		stackView.axis = .vertical
		setupSubviews()
		setupLayout()
	}

	private func setupSubviews() {
		view.addSubview(subviews.avatarView)
		subviews.avatarView.translatesAutoresizingMaskIntoConstraints = false
		stackView.addArrangedSubview(subviews.raceView)
		stackView.addArrangedSubview(subviews.genderView)
		stackView.addArrangedSubview(subviews.statusView)
		stackView.addArrangedSubview(subviews.locationView)
		stackView.addArrangedSubview(subviews.countEpisodeView)

		subviews.raceView.font = UIFont.systemFont(ofSize: 20)
		subviews.genderView.font = UIFont.systemFont(ofSize: 20)
		subviews.statusView.font = UIFont.systemFont(ofSize: 20)
		subviews.countEpisodeView.font = UIFont.systemFont(ofSize: 20)
		subviews.locationView.font = UIFont.systemFont(ofSize: 20)
	}

	private func setupLayout() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		subviews.avatarView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			subviews.avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			subviews.avatarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
			subviews.avatarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),

			stackView.topAnchor.constraint(equalTo: subviews.avatarView.bottomAnchor, constant: 15),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
			stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
			stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
		])
	}
}

// MARK: - ReloadData

extension DetailCharacterVC: IDetailCharacterView {
	func reloadData() {
		guard let model = presenter.model else { return }
		subviews.raceView.text = "race: " + model.race
		subviews.genderView.text = "gender: " + model.gender
		subviews.statusView.text = "status: " + model.status
		subviews.locationView.text = "location: " + model.location
		subviews.countEpisodeView.text = "episodes: " + model.countEpisode
		model.loadImage { image in
			self.subviews.avatarView.image = image
		}

	}

	func update(title: String) {
		titleView.setup(title: title)
	}
}
