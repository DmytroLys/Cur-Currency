//
//  ViewController.swift
//  Cur-Currency
//
//  Created by Dmytro on 01.09.2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    // MARK: - IBOutlets -
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var currencyPicker: UIPickerView!
    @IBOutlet private weak var bitcoinLabel: UILabel!
    // MARK: - Properties -
    var coinManager = CoinManager()
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
    
    
}
// MARK: - UIPickerViewDataSource,UIPickerViewDelegate -
extension CurrencyViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentRow = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currentRow)
    }
}
// MARK: - CoinManagerDelegate - 
extension CurrencyViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Ooops", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    
    func didUpdateBitcoinLabel(data: CurrencyModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = data.rateToString
            self.currencyLabel.text = data.currency
        }
    }
    
    
    
}





