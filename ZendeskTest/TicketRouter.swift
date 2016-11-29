//
//  TicketRouter.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

//Encapsulates the details of a URLRequest for each TicketEndpoint API case
class TicketRouter: URLRequestConvertible, APIConfigurator {

	var endpoint: TicketEndpoint
	init(endpoint: TicketEndpoint) {
		self.endpoint = endpoint
	}

	
	//MARK: - APIConfigurator implementation - URL Request properties
	var baseURL: URL {
		let stringURL = String(format: Config.baseURLPath, arguments: [Config.subdomain])
		return URL(string: stringURL)!
	}

	var method: HTTPMethod {
		switch self.endpoint {
		case .GetAllTickets: return .get
		}
	}
	
	var encoding: Alamofire.ParameterEncoding {
		switch self.endpoint {
		case .GetAllTickets: return URLEncoding.default //return nil
		}
	}
	
	//relative path to be appended to the base url
	var relativePath: String {
		switch self.endpoint {
		case .GetAllTickets:
			return ("/tickets.json")
		}
	}
	
	var parameters: [String: AnyObject]? {
		var params: [String:AnyObject] = [:]
		
		switch self.endpoint {
		case .GetAllTickets(let page):
			//When the response exceeds the per-page maximum, you can paginate through the records by incrementing the "page" parameter
			params["page"] = "\(page)" as AnyObject
			
			//ask the backend for the list of tickets sorted by created date...
			params["sort_by"] = "created_at" as AnyObject
			
			//...in descending order
			params["sort_order"] = "desc" as AnyObject
			
			//and don't be greedy! a few records at a time is enough
			params["per_page"] = Config.ticketBatchSize as AnyObject
			
		}
		
		return params
	}

	var timeoutInterval: TimeInterval {
		return TimeInterval(60 * 0.5)
	}
	
	var defaultHeaders: [String: String] {
		
		var headers: [String:String] = [:]
		
		/*
		The Zendesk API is a JSON API. 
		You must supply a Content-Type: application/json header in PUT and POST requests. 
		You must set an Accept: application/json header on all requests.
		*/
		headers["Accept"] = "application/json"
		
		
		/*
		It is not required to build a login capability so feel free to hard-code credentials.
		API Authentication can be done using Basic Auth
		*/
		if let data = "\(Config.username):\(Config.password)".data(using: .utf8) {
			let credential = data.base64EncodedString(options: [])
			headers["Authorization"] = "Basic \(credential)"
		}

		return headers
	}
	

	
	// MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		
		//build the URLRequest from all the individual components
		var urlRequest = try URLRequest(url: baseURL.appendingPathComponent(relativePath),
		                            method: method,
		                            headers: defaultHeaders)
		urlRequest.timeoutInterval = timeoutInterval
		urlRequest.cachePolicy = .returnCacheDataElseLoad
		
		switch self.endpoint {
		case .GetAllTickets:
			return try encoding.encode(urlRequest, with: parameters)
		}
	}
}
