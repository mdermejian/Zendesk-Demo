//
//  TicketManager.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation
import Alamofire

/*
	This is the network controller for Ticket related API calls: it talks to the backend and then pushes data into your cache, into your persistence engine. (not implemented yet here)
*/
class TicketManager {
	
	//Singleton shared instance
	static let sharedManager = TicketManager()
	
	//hide the default init
	private init() {}
	
	//MARK: methods
	
	func getTickets(page: Int = 1, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ hasMore: Bool?, _ tickets: [Ticket]?) -> Void) {
		
		let request = TicketRouter(endpoint: .GetAllTickets(page: page))
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			//Use Generic Response Object Serialization to map the response into a GetAllTicketsResponse object
			.responseObject(completionHandler: { (response: DataResponse<GetAllTicketsResponse>) in
				completion(response.result.isSuccess,
				           response.result.value?.count,
				           response.result.value?.hasMore,
				           response.result.value?.tickets)
			})
		
	}
}
