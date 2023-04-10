//
//  ViewController.swift
//  RickAndMorty
//
//  Created by User on 07.04.2023.
//

import UIKit

class CharacterListVC: UIViewController {

	// MARK: - Properties

	private let characterTableView = UITableView()
	private let imageView = UIImageView()
	private var dataSource: UITableViewDiffableDataSource<Int, CharacterItem>?
	private let presenter: CharacterListPresenter

	// MARK: - Init

	init(presenter: CharacterListPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setup()
		presenter.didLoad()
	}

	// MARK: - Private

	private func setup() {
		navigationItem.backButtonTitle = "back"
		view.addSubview(imageView)
		view.addSubview(characterTableView)
		title = "Rick && Morty"
		navigationItem.largeTitleDisplayMode = .automatic
		characterTableView.contentInsetAdjustmentBehavior = .always
		imageView.image = UIImage(named: "rick")

		setupLayout()
		characterTableView.backgroundColor = .clear
		characterTableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
		characterTableView.register(LoaderCell.self, forCellReuseIdentifier: "LoaderCell")
		characterTableView.dataSource = self
		characterTableView.delegate = self
	}

	private func setupLayout() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		characterTableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: view.rightAnchor),

			characterTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			characterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			characterTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			characterTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}
// MARK: - UITableViewDataSource

extension CharacterListVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.viewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch presenter.viewModels[indexPath.row] {

		case .character(characterItem: let item):
			guard let characterCell = tableView.dequeueReusableCell(
					withIdentifier: "CharacterCell",
					for: indexPath
				) as? CharacterCell
			else { return UITableViewCell() }
			characterCell.configure(item: item)

			return characterCell

		case .loader:
			guard let loaderCell = tableView.dequeueReusableCell(
					withIdentifier: "LoaderCell",
					for: indexPath
				) as? LoaderCell
			else { return UITableViewCell() }
			loaderCell.startAnimation()
			return loaderCell
		}
	}
}

// MARK: - UITableViewDelegate

extension CharacterListVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return UITableView.automaticDimension
		return 60
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(row: indexPath.row)
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
			if tableView.visibleCells.contains(cell) {
				guard cell as? LoaderCell != nil else { return }
				self.presenter.nextLoad()
			}
		}
	}
}

// MARK: - ReloadData

extension CharacterListVC: ICharacterView {
	func reloadData() {
		characterTableView.reloadData()
	}
}
