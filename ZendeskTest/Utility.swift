//
//  Utility.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation
import UIKit

final class Utility {
	
	// share the DateFormatter. It's expensive to create
	private static let _formatter = DateFormatter()
	
	// used to transform an ISO8601 date string to foundation Date object
	static var iso8601DateFormatter: DateFormatter {
		_formatter.locale = Locale(identifier: "en_US_POSIX")
		_formatter.timeZone = TimeZone(abbreviation: "UTC")
		_formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
		return _formatter
	}

	// used to transform a Date object to string in the "dd MMM yyyy" format
	static var ddMMMyyyyDateFormatter: DateFormatter {
		_formatter.locale = Locale.current
		_formatter.timeZone = TimeZone(abbreviation: "UTC")
		_formatter.dateFormat = "dd MMM yyyy"
		return _formatter
	}
	
}
