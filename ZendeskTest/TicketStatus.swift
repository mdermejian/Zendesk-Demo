//
//  TicketStatus.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

enum TicketStatus: String, CustomStringConvertible {
	
	case new = "new"
	case open = "open"
	case pending = "pending"
	case hold = "hold"
	case solved = "solved"
	case closed = "closed"
	
	// MARK: CustomStringConvertible implementation
	
	var description: String {
		switch self {
		case .new: return "NEW"
		case .open: return "OPEN"
		case .pending: return "PENDING"
		case .hold: return "ON HOLD"
		case .solved: return "SOLVED"
		case .closed: return "CLOSED"
		}
	}
	
}
