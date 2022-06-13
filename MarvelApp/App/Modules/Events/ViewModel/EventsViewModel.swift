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
}

class EventsViewModel {
    
    weak var delegate: EventsViewModelDelegate?
    
    var events = [Character]()
    
    var eventsService: EventsFetching
    
    init(eventsService: EventsFetching = EventsService()) {
        self.eventsService = eventsService
    }
    
    func getEvents(){
        DispatchQueue.global().async { [weak self] in
            self?.eventsService.fetchEvent(onComplete: { event in
                self?.events = event.data.results
                self?.delegate?.didGetEventsData()
            }, onError: { error in
                self?.delegate?.didFailGettingEventsData(error: error)
            })
        }
    }
    
    func getEvents(at index:Int) -> Character{
        return events[index]
    }
    
    func getEventsCount() -> Int{
        return events.count
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
