//
//  ZendeskTestTests.swift
//  ZendeskTestTests
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import XCTest
@testable import ZendeskTest

class ZendeskTestTests: XCTestCase {
	
	var emptyTicket: [String: AnyObject] = [:]
	let dummyResponse = HTTPURLResponse()
	
	override func tearDown() {
		super.tearDown()
		emptyTicket = [:]
	}

	func testConstructorReturnsNonNil() {
		
		let ticket = Ticket(response: dummyResponse, representation: emptyTicket)
		XCTAssertNotNil(ticket, "ticket should not be nil")
		
	}
	
	func testDefaults() {
		
		guard let ticket = Ticket(response: dummyResponse, representation: emptyTicket) else {
			XCTFail("guard statement failed")
			return
		}
		
		XCTAssert(ticket.status == .open, "ticket.starred should be false")
		XCTAssert(ticket.priority == .normal, "ticket.status should be .undefined")
	}
	
	func testPropertiesAreNil() {
		
		let ticket = Ticket(response: dummyResponse, representation: emptyTicket)
		
		XCTAssertNil(ticket!.id, "uninitialized optional property should be nil")
		XCTAssertNil(ticket!.subject, "uninitialized optional property should be nil")
		XCTAssertNil(ticket!.descriptionOfTicket, "uninitialized optional property should be nil")
		XCTAssertNil(ticket!.createdAt, "uninitialized optional property should be nil")
	}
	
	func testInvalidRepresentation() {
		
		let invalidRepresentation: [Int: String] = [1:"xxx"]
		let ticket = Ticket(response: dummyResponse, representation: invalidRepresentation)
		XCTAssertNil(ticket, "ticket should be nil")
	}
	
	func testValidRepresentation() {
		
		let validTicketRepresentation =
			[
				"id": 418,
				"subject":"This is a sample ticket",
				"description":"Feel free to delete this sample ticket.",
				"created_at":"2016-02-26T16:10:27Z",
				"priority":"normal",
				"status":"new",
				] as [String : Any]
		
		let ticket = Ticket(response: dummyResponse, representation: validTicketRepresentation)
		XCTAssertNotNil(ticket, "ticket should not be nil")
		
		XCTAssertTrue(ticket!.id == 418)
		XCTAssertTrue(ticket!.subject == "This is a sample ticket")
		XCTAssertTrue(ticket!.descriptionOfTicket == "Feel free to delete this sample ticket.")
		XCTAssertTrue(ticket!.status == .new)
		XCTAssertTrue(ticket!.priority == .normal)
		
		let creationDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(abbreviation: "UTC") , year: 2016, month: 2, day: 26, hour: 16, minute: 10, second: 27)
		XCTAssertTrue(ticket!.createdAt!.compare(creationDateComponents.date!) == .orderedSame)
		
	}
	
	func testEquatable() {
		var ticket1 = Ticket(response: dummyResponse, representation: emptyTicket)
		var ticket2 = Ticket(response: dummyResponse, representation: emptyTicket)
		
		ticket1?.id = 1
		ticket2?.id = 1
		XCTAssertTrue(ticket1 == ticket2, "tickets should be equal")
		
		ticket1?.id = 1
		ticket2?.id = 2
		XCTAssertFalse(ticket1 == ticket2, "tickets should NOT be equal")
		
		ticket1?.id = nil
		ticket2?.id = 2
		XCTAssertFalse(ticket1 == ticket2, "tickets should NOT be equal")
		
		ticket1?.id = 1
		ticket2?.id = nil
		XCTAssertFalse(ticket1 == ticket2, "tickets should NOT be equal")
		
		ticket1?.id = nil
		ticket2?.id = nil
		XCTAssertFalse(ticket1 == ticket2, "tickets should NOT be equal")
		
	}
	
	func testComparable() {
		var ticket1 = Ticket(response: dummyResponse, representation: emptyTicket)
		var ticket2 = Ticket(response: dummyResponse, representation: emptyTicket)
		
		XCTAssertFalse(ticket1! < ticket2!, "If one or both creation dates are nil, ticket1 < ticket2 should return false!")
		
		ticket1?.createdAt = Date(timeIntervalSinceNow: 100)
		ticket2?.createdAt = Date(timeIntervalSinceNow: 100)
		XCTAssertFalse(ticket1! < ticket2!, "For the same creation date ticket1 < ticket2 should return false!")
		
		ticket1?.createdAt = Date(timeIntervalSinceNow: 100)
		ticket2?.createdAt = Date(timeIntervalSinceNow: 200)
		XCTAssertTrue(ticket1! < ticket2!, "A ticket that was created before another should be <")
		
		ticket1?.createdAt = Date(timeIntervalSinceNow: 200)
		ticket2?.createdAt = Date(timeIntervalSinceNow: 100)
		XCTAssertFalse(ticket1! < ticket2!, "A ticket that was created after another should NOT be <")
		
	}
	
}
