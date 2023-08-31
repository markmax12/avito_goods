//
//	ItemDetailsViewController.swift
//  avito_goods
//
//  Created by Maxim Ivanov.
//  
//

import UIKit
import MessageUI
import Combine

class ItemDetailsViewController: UIViewController, MFMailComposeViewControllerDelegate {
  
    var rootView: ItemDetailsRootView!
    var viewModel: ItemDetailViewModel
    var coordinator: Coordinator
    var subscriptions = Set<AnyCancellable>()
    private var loaderView: LoaderView
    
    init(viewModel: ItemDetailViewModel,
         coordinator: Coordinator,
         loaderView: LoaderView) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.loaderView = loaderView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupRootView()
        bindToViewState()
        bindViewModelToView()
        viewModel.fetchData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLoader()
    }
    
    private func setupRootView() {
        rootView = ItemDetailsRootView(frame: .zero)
        rootView.setInteractiveButtonsDelegate(delegate: self)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootView)
        
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.frame = view.bounds
    }
    
    private func bindViewModelToView() {
        viewModel
            .$itemDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itemDetails in
                self?.configuireView(with: itemDetails)
            }.store(in: &subscriptions)
    }
    
    private func bindToViewState() {
        viewModel
            .$view
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.respondToStateChange(state: state)
            }.store(in: &subscriptions)
    }
    
    private func respondToStateChange(state: ItemDetailsViewState) {
        switch state {
            case .loading:
                rootView.isHidden = true
                loaderView.startAnimating()
            case .presenting:
                loaderView.stopAnimating()
                rootView.isHidden = false
            case .error(let error):
                rootView.isHidden = true
                present(error) { [navigationController] in
                    navigationController?.popViewController(animated: true)
                }
        }
    }
    
    private func loadItemDetails() async throws {
        viewModel.fetchData()
    }
    
    private func configuireView(with itemDetails: ItemDetails) {
        rootView.propagateView(with: itemDetails)
    }
}

extension ItemDetailsViewController: InteractiveCommunicationButtonsDelegate {

    enum InteractiveCommunicationPresentationError: Error, LocalizedError {
        case notOnDevice(credential: String)
        
        var errorDescription: String? {
            switch self {
                case .notOnDevice(let creds):
                    return NSLocalizedString("Попробуйте с телефона, или свяжитесь сами: \(creds)", comment: "")
            }
        }
    }
    
    func didPressEmailButton(email: String?) {
        guard let email else { return }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true)
        } else {
            present(InteractiveCommunicationPresentationError.notOnDevice(credential: email), nil)
        }
    }
    
    func didPresCallButton(phoneNumber: String?) {
        guard let phoneNumber else { return }
        if let url = URL(string: "tel://\(phoneNumber.formatPhoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            present(InteractiveCommunicationPresentationError.notOnDevice(credential: phoneNumber), nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
