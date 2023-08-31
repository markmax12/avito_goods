//
//	ItemDetailsViewController.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var itemId: String? {
        didSet {
            Task {
                do {
                    try await loadItemDetails()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var rootView: ItemDetailsRootView!
    var viewModel: ItemDetailViewModel
    var coordinator: Coordinator
    
    init(viewModel: ItemDetailViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupRootView()
    }
    
    private func setupRootView() {
        rootView = ItemDetailsRootView(frame: .zero)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootView)
        
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func loadItemDetails() async throws {
        guard let itemId else { return }
       // let itemDetails = try await itemDetailsFetcherService.itemDetails(for: itemId)
       // await configuireView(with: itemDetails)
    }
    
    private func configuireView(with itemDetails: ItemDetails) async {
        await rootView.propagateView(with: itemDetails)
    }
    
}
