//
//  HomePresenter.swift
//  SwiftViperArchitecture
//
//  Created by Ali şeker on 28.07.2023.
//

import Foundation

class HomePresenter : HomeViewPresenterInput{
    func onTapCell(model: CatEntity) {
         
    }
    
   
    let interactor : HomeInteractor
    let view : HomeViewInputs
    
    init(interactor : HomeInteractor,view : HomeViewInputs) {
        self.interactor = interactor
        self.view = view
    }
    private func fetchCats() {
         interactor.fetchCats(url: "\(ProductConstant.BASE_URL)/\(ServicePath.http.rawValue)") { response in
             switch response {
             case .success(let items):
                 self.view.reloadTableView(cats: items)
             case .failure:
                 print("")
             }

             self.view.indicatorView(animate: false)
         }
     }

    

    func viewDidLoad() {
        view.indicatorView(animate : true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchCats()
        }
       
    }
    
    func onTapCell() {
         
    }
    
    
}
