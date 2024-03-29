//
//  SampleViewTableViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/22/24.
//

import UIKit

class MainTableViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var pages: [PageEnum] = PageEnum.allCases

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func setCoordinator(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PageEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = pages[indexPath.row].rawValue
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigate(page: pages[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
