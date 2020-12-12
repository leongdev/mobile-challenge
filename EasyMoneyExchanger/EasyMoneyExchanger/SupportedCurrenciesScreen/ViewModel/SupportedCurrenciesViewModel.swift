//
//  CurrenciesViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 11/12/20.
//

import Foundation
import UIKit

class SupportedCurrenciesViewModel {

    var supportedList: [SupportedList]?
    var supportedListDictionary: [String: [SupportedList]]?
    var supportedTitles = [String]()
    var isSearching = false

    let coreData: CoreDataManager

    init( coreData: CoreDataManager) {
        self.coreData = coreData
    }

//    func showCurrencieModal(currenciesView viewController: CurrenciesViewController) {
//        let modal = UIStoryboard(name: "CurrenciesScreenModal", bundle: nil)
//        let localViewController = (modal.instantiateViewController(withIdentifier: "CurrenciesScreenModal") as? CurrenciesModalViewController)!
//
//        localViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
//        localViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//        localViewController.viewModel = self
//        viewController.present(localViewController, animated: true, completion: nil)
//    }

    func initSupportedCurrenciesScreen(tableView: UITableView) {
        // Setup supported Items List
        initSupportedList(uiTableView: tableView)
        initSupportedTitles(uiTableView: tableView)
        initSupportedListDictionary(uiTableView: tableView)

        print(supportedList!)
        print(supportedTitles)
    }

    func initSupportedList(uiTableView tableView: UITableView) {
        supportedList = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedList = sortSupportedList(supportedList: supportedList!)
        supportedList = addSupportedListFlags(supportedList: supportedList!)
    }

    func initSupportedTitles(uiTableView tableView: UITableView) {
        let localSupportedList = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedTitles = getSupportedTitles(supportedList: localSupportedList)
    }

    func initSupportedListDictionary(uiTableView tableView: UITableView) {
        var supportedListWithoutFlags = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedListWithoutFlags = sortSupportedList(supportedList: supportedListWithoutFlags)
        supportedListDictionary = getSupportedListDictionary(supportedList: supportedList!, supportedListWithoutFlags: supportedListWithoutFlags)
    }

    func getCoreDataSupported(uiTableView: UITableView) -> [String: String]? {
        coreData.getSupported(tableView: uiTableView)
        coreData.getRates(tableView: uiTableView)
        return coreData.supportedItems![0].currencies
    }
}
