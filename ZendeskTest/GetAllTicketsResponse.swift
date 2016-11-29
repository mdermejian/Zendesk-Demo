//
//  GetAllTicketsResponse.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

/*
	The keys in the key-value pairs received from the backend response to GetAllTickets
*/
fileprivate enum GetAllTicketsResponseFields: String {
	
	case Tickets = "tickets"
	case NextPage = "next_page"
	case PreviousPage = "previous_page"
	case Count = "count"
}

/*
	The backend response to GetAllTickets API call
*/
struct GetAllTicketsResponse: ResponseObjectSerializable {
	
	//MARK: - stored properties
	var tickets: [Ticket]?
	var nextPage: String?
	var previousPage: String?
	var count: Int?
	
	//MARK: - computed properties
	//indicates whether there are more records to be fetched
	var hasMore: Bool {
		return nextPage != nil
	}
	
	// MARK: ResponseObjectSerializable
	
	fileprivate typealias Fields = GetAllTicketsResponseFields

	init?(response: HTTPURLResponse, representation: Any) {
		
		guard let representation = representation as? [String: AnyObject]
			else { return nil }
		
		var _tickets: [Ticket] = []
		if let allTicketsRepresentation = representation[Fields.Tickets.rawValue] as? [[String:AnyObject]] {
			for ticketRepresentation in allTicketsRepresentation {
				if let ticket = Ticket(response: response, representation: ticketRepresentation as AnyObject) {
					_tickets.append(ticket)
				}
			}
		}
		tickets = _tickets

		if let previousPage = representation[Fields.PreviousPage.rawValue] as? String { self.previousPage = previousPage }
		if let nextPage = representation[Fields.NextPage.rawValue] as? String { self.nextPage = nextPage }
		if let count = representation[Fields.Count.rawValue] as? Int { self.count = count }
		
	}
}

