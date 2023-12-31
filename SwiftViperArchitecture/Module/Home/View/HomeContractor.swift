//
//  HomeContractor.swift
//  SwiftViperArchitecture
//
//  Created by Ali şeker on 28.07.2023.
//

import Foundation

protocol HomeInteractorOutputs {
    func onSuccessSearch()
    func onErrorSearch()
}

protocol HomeViewInputs {
    func configure()
    func reloadTableView(cats : [CatEntity])
    func setupTableViewCell()
    func indicatorView(animate: Bool)
    func sortByTitle()
}

protocol HomeViewPresenterInput {
    func viewDidLoad()
    func onTapCell(model: CatEntity)

}
