//
//  TicketsTableViewController.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 27/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class TicketsTableViewController: UITableViewController {

	// MARK: Stored properties

	// Current page - this is incremented in the API callback closure
	private var page = 1
	
	private var isLoading = false {
		didSet {
			loadingFooterView?.isHidden = !isLoading
			UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
		}
	}

	// This is set from the backend when the nextPage is not null
	private var hasMore = true {
		didSet {
			if !hasMore { tableView.tableFooterView = nil }
		}
	}

	// Total number of records available. This is set from the backend
	private var totalRecords = 0 {
		didSet {
			
			if let _ = navigationItem.title { navigationItem.title = "\(Constants.Ticket_Title) (\(String(totalRecords)))" }
		}
	}
	
	//List of tickets for the table view
	private var tickets: [Ticket] = []
	
	// MARK: Constants

	//Keep constants' scope as small as possible
	private struct Constants {
		static let CellReuseId = "TicketCell"
		
		static let Ticket_Title = NSLocalizedString("Ticket_Title", comment: "The title of the Tickets table view")
		static let Network_Error_Message_Title = NSLocalizedString("Network_Error_Message_Title", comment: "The title of the network error message")
		static let Network_Error_Message_Body = NSLocalizedString("Network_Error_Message_Body", comment: "The body of the network error message")
		static let OK_Action = NSLocalizedString("OK_Action", comment: "Okay button title")
	}
	
	// MARK: IBOutlets

	@IBOutlet weak var loadingFooterView: UIView!
	
	// MARK: - View controller lifecycle

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.title = Constants.Ticket_Title
		loadNextBatch()
	}
	
	// MARK: Networking

	private func loadNextBatch() {
		
		guard isLoading == false else { return }
		
		isLoading = true
		
		TicketManager.sharedManager.getTickets(page: page) { (success, totalCount, hasMore, _tickets) in
			self.isLoading = false
			
			guard success == true, let _tickets = _tickets, let hasMore = hasMore, let totalCount = totalCount else {
				
				//present alert controller with error message
				let alertController = UIAlertController(title: Constants.Network_Error_Message_Title, message: Constants.Network_Error_Message_Body, preferredStyle: .alert)
				let okAction = UIAlertAction(title: Constants.OK_Action, style: .default)
				alertController.addAction(okAction)
				self.present(alertController, animated: true)

				return
			}
			
			self.page += 1
			self.totalRecords = totalCount
			self.hasMore = hasMore
			
			var indexPaths: [IndexPath] = []
			for ticket in _tickets {
				let row = self.tickets.count
				indexPaths += [IndexPath(row: row, section:0)]
				self.tickets += [ticket]
			}
			
			OperationQueue.main.addOperation {
				self.tableView.beginUpdates()
				self.tableView.insertRows(at: indexPaths, with: .fade)
				self.tableView.endUpdates()
			}
		}
	}

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseId, for: indexPath) as! TicketCell
		cell.ticket = tickets[indexPath.row]
        return cell
    }
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		//when the cell before last is about to appear, trigger the next batch load
		if indexPath == IndexPath(row: tickets.count-2, section: 0) && hasMore {
			loadNextBatch()
		}
	}
}
