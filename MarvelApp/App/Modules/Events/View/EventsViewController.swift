//
//  EventsViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import UIKit

class EventsViewController: UIViewController {

    //MARK: - Properties
    
    lazy var viewModel: EventsViewModel = {
        let eventsViewModel = EventsViewModel()
        eventsViewModel.delegate = self
        return eventsViewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero    , collectionViewLayout: layout)
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        collectionView.layer.shadowOpacity = 1.0
        collectionView.layer.shadowRadius = 2.0
        collectionView.layer.masksToBounds = false
        return collectionView
    }()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,  right: view.rightAnchor, paddingLeft: 12, paddingRight: 12)

        viewModel.getEvents()
    
    }
    
    //MARK: - Helpers
    
    func showMessageError(message: String){
            let alert = UIAlertController(title: "Fail", message: message, preferredStyle: .alert)
            let actionRetry = UIAlertAction(title: "Retry?", style: .default) { [weak self] _ in
                self?.viewModel.getEvents()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
            
            alert.addAction(actionRetry)
            alert.addAction(actionCancel)
            
            present(alert, animated: true)
        }
}

//MARK: - Events view model Delegate

extension EventsViewController: EventsViewModelDelegate{

    func didGetEventsData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }

    func didFailGettingEventsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.showMessageError(message: error)
        }
    }
}

//MARK: - collection Delegate & Datasource

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 390, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2.0
        cell.layer.masksToBounds = false
        
        let event = viewModel.getEvents(at: indexPath.row)
        let dateFormat = viewModel.convertDateFormat(inputDate: event.modified ?? "Unkown date")
        
        cell.configureCell(with: event)
        cell.configureDate(date: dateFormat)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getEventsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailEventsVC = DetailEventsViewController()
        let event = viewModel.getEvents(at: indexPath.row)
        detailEventsVC.eventsComics = event.comics.items
        detailEventsVC.configureCell(with: event)
        detailEventsVC.modalPresentationStyle = .popover
        present(detailEventsVC, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
