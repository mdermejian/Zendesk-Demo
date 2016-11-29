//
//  Constants.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 27/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

struct Config {
	
	/* https://{subdomain}.zendesk.com/api/v2 */
	static let baseURLPath = "https://%@.zendesk.com/api/v2"
	static let subdomain = "mxtechtest"
	
	static let username = "acooke+techtest@zendesk.com"
	static let password = "mobile"
	
	//unused for now
	static let id = 39551161
	
	static let cacheMemoryCapacity = 4 * 1024 * 1024
	static let cacheDiskCapacity = 10 * 1024 * 1024
	
	//the number of tickets to request with each backend call
	static let ticketBatchSize = 20
}

// This would hold the palette of special colors being used within the app 
struct Colors {
	
	static let zendeskGreen	= UIColor(red: 130/255, green: 162/255, blue: 48/255, alpha: 1.0)
	
}
