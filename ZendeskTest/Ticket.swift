//
//  Ticket.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation
import UIKit

struct Ticket: CustomStringConvertible {
	
	// MARK: - stored properties
	
	var id: Int?
	var subject: String?
	var descriptionOfTicket: String? //avoid using "description" because Ticket implements CustomStringConvertible
	var status: TicketStatus = .open
	var priority: TicketPriority = .normal
	var createdAt: Date?
	
	
	
	// MARK: - ResponseObjectSerializable protocol implementation
	
	fileprivate typealias Fields = TicketKey
	fileprivate typealias Value = AnyObject
	
	init?(response: HTTPURLResponse, representation: Any) {
		
		guard let representation = representation as? [String: AnyObject] else { return nil }
		
		if let id = representation[Fields.ID.rawValue] as? NSNumber { self.id = id.intValue }
		if let subject = representation[Fields.Subject.rawValue] as? String { self.subject = subject }
		if let descriptionOfTicket = representation[Fields.Description.rawValue] as? String { self.descriptionOfTicket = descriptionOfTicket }
		if let status = representation[Fields.Status.rawValue] as? String { self.status = TicketStatus(rawValue: status)! }
		if let priority = representation[Fields.Priority.rawValue] as? String { self.priority = TicketPriority(rawValue: priority)! }
		if let createdAt = representation[Fields.CreatedAt.rawValue] as? String {
			self.createdAt = Utility.iso8601DateFormatter.date(from: createdAt)
		}
	}
}

// MARK: - Comparable protocol implementation

extension Ticket: Comparable {}

func == (lhs: Ticket, rhs: Ticket) -> Bool {
	return lhs.id != nil
		&& rhs.id != nil
		&& lhs.id == rhs.id
}

func < (lhs: Ticket, rhs: Ticket) -> Bool {
	
	guard lhs.createdAt != nil && rhs.createdAt != nil else {
		return false
	}
	
	if lhs.createdAt!.compare(rhs.createdAt!) == .orderedAscending {
		return true
	}
	return false
}

// MARK: - API Keys

// The keys to the values received in the API response
// These do not represent the entirety of the response
// we are only choosing a select few to parse and store
public enum TicketKey: String {
	
	case ID				= "id"
	case Subject		= "subject"
	case Description	= "description"
	case Status			= "status"
	case Priority		= "priority"
	case CreatedAt		= "created_at"
}
