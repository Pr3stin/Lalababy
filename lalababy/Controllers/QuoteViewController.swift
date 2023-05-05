//
//  QuoteViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 5/1/23.
//

import UIKit
import CoreData

class QuoteViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://api.goprogram.ai/inspiration"
        getData(from: url)
       
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = json.quote
                self.authorLabel.text = json.author
            }
            
        })
        
        task.resume()
    }
    

    struct Response: Codable {
        let quote: String
        let author: String
    }

}
