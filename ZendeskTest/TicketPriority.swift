//
//  TicketPriority.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

enum TicketPriority: String, CustomStringConvertible {
	
	case normal = "normal"
	case high = "high"
	case low = "low"
	case urgent = "urgent"
	
	// MARK: computed properties
	
	var image: UIImage? {
		switch self {
		case .normal: return UIImage(named: "normal")
		case .high: return UIImage(named: "high")
		case .low: return UIImage(named: "low")
		case .urgent: return UIImage(named: "urgent")
		}
	}

	// MARK: CustomStringConvertible implementation

	var description: String {
		switch self {
		case .normal: return "Normal priority"
		case .high: return "High priority"
		case .low: return "Low priority"
		case .urgent: return "Urgent"
		}
	}
}
