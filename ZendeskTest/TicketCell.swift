//
//  TicketCell.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 27/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {

	//MARK: API
	var ticket: Ticket? {
		didSet {
			updateUI()
		}
	}
	
	// MARK: Computed property
	private var caption: String {
		var caption = ""
		if let id = ticket?.id { caption += "#\(id)" }
		if let creationDate = ticket?.createdAt { caption += " • \(Utility.ddMMMyyyyDateFormatter.string(from: creationDate))" }
		return caption
	}
	
	// MARK: IBOutlets
	@IBOutlet weak var captionLabel: UILabel! {
		didSet {
			captionLabel.textColor = Colors.zendeskGreen
		}
	}
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var priorityImageView: UIImageView!
	@IBOutlet weak var statusLabel: UILabel! {
		didSet {
			statusLabel.layer.backgroundColor = Colors.zendeskGreen.cgColor
			statusLabel.textColor = UIColor.white
		}
	}
	
	//MARK: UI update
	private func updateUI () {
		
		guard let ticket = ticket else { return }
		
		captionLabel.text = caption
		subjectLabel.text = ticket.subject
		descriptionLabel.text = ticket.descriptionOfTicket
		priorityImageView.image = ticket.priority.image
		statusLabel.text = ticket.status.description

	}
}
