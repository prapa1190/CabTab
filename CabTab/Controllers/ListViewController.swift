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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "CabTab"
		callViewModelForUIUpdate()
    }

	func callViewModelForUIUpdate() {
		cabDataViewModel = CabDataViewModel()
		cabDataViewModel.bindCabDataViewModelToController = {
			DispatchQueue.main.async {
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
