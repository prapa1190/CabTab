//
//  ListViewController.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit

class ListViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	private var cabDataViewModel: CabDataViewModel!
	private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "List"

		activityIndicator = UIActivityIndicatorView(style: traitCollection.userInterfaceStyle == .light ? .gray : .white)
		activityIndicator.hidesWhenStopped = true
		let barButton = UIBarButtonItem(customView: activityIndicator)
		self.navigationItem.setRightBarButton(barButton, animated: true)

		callViewModelForUIUpdate()
    }

	func callViewModelForUIUpdate() {
		activityIndicator.startAnimating()
		cabDataViewModel = CabDataViewModel()
		cabDataViewModel.bindCabDataViewModelToController = {
			DispatchQueue.main.async { [unowned self] in
				self.activityIndicator.stopAnimating()
				self.tableView.reloadData()
			}
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	deinit {
		cabDataViewModel = nil
		activityIndicator = nil
	}
}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		cabDataViewModel.getCabCont()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CabTableViewCell") as! CabTableViewCell
		cell.cabIDLabel.text = cabDataViewModel.getIDForCabForIndex(indexPath.row)
		cell.cabTypeImageView.image = UIImage(named: cabDataViewModel.getCabTypeImageForIndex(indexPath.row))
		cell.cabTypeLabel.text = cabDataViewModel.getCabTypeForIndex(indexPath.row)
		cell.cabDistanceLabel.text = cabDataViewModel.getCabDistanceForIndex(indexPath.row)
		return cell
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		UIView()
	}
}

extension ListViewController: UITableViewDelegate {

}
