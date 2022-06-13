//
//  EventsViewModel.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 11/06/2022.
//

import Foundation

protocol EventsViewModelDelegate: AnyObject {
    func didGetEventsData()
    func didFailGettingEventsData(error: String)
    func showLoading()
    func hideLoading()
}

class EventsViewModel {
    
    weak var delegate: EventsViewModelDelegate?
    
    var events = [Character]()
    
    var eventsSorted = [Character]()
        
    var eventsService: EventsFetching
    
    init(eventsService: EventsFetching = EventsService()) {
        self.eventsService = eventsService
    }
    
    func sortEvents(){
    
        let sortedEvents = events.sorted(by: {$0.modified ?? "Unkown date" < $1.modified ?? "Unkown date"
        })
        eventsSorted = sortedEvents
    }
    
    func getEvents(){
        self.loadingView(.show)
        DispatchQueue.global().async { [weak self] in
            self?.eventsService.fetchEvent(onComplete: { event in
                self?.events = event.data.results
                self?.delegate?.didGetEventsData()
                self?.sortEvents()
                self?.loadingView(.hide)
            }, onError: { error in
                self?.delegate?.didFailGettingEventsData(error: error)
                self?.loadingView(.hide)
            })
        }
    }
    
    func getEvents(at index:Int) -> Character{
        return eventsSorted[index]
    }
    
    func getEventsCount() -> Int{
        return eventsSorted.count
    }
    
    func loadingView(_ state: LoadingViewState){
        switch state {
        case .show:
            self.delegate?.showLoading()
        case .hide:
            self.delegate?.hideLoading()
        }
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMMM yyyy"

        return convertDateFormatter.string(from: oldDate ?? Date.now)
    }
}
