//
//  ViewController.swift
//  BlockOperation
//
//  Created by Pawan iOS on 07/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    
    let operationQueue = OperationQueue()
    
    let imageURLs = ["https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg",
                     "https://s1.ax1x.com/2017/12/06/oaiz8.png",
                     "https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547_1280.jpg",
                     "https://cdn.pixabay.com/photo/2021/11/13/23/06/tree-6792528_1280.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        
        let blockOperation1 = BlockOperation()
        
        blockOperation1.addExecutionBlock { [self] in
            downloadImage(from: URL(string: imageURLs[0])!) { data  in
                DispatchQueue.main.async {
                    self.img1.image = UIImage(data: data)
                }
            }
        }
        
        let blockOperation2 = BlockOperation()
        
        blockOperation2.addExecutionBlock { [self] in
            downloadImage(from: URL(string: imageURLs[1])!) { data  in
                DispatchQueue.main.async {
                    self.img2.image = UIImage(data: data)
                }
            }
        }
        
        let blockOperation3 = BlockOperation()
        
        blockOperation3.addExecutionBlock { [self] in
            downloadImage(from: URL(string: imageURLs[2])!) { data  in
                DispatchQueue.main.async{
                    self.img3.image = UIImage(data: data)
                }
            }
        }
        
        let blockOperation4 = BlockOperation()
        
        blockOperation4.addExecutionBlock { [self] in
            downloadImage(from: URL(string: imageURLs[3])!) { data  in
                DispatchQueue.main.async {
                    self.img4.image = UIImage(data: data)
                }
            }
        }
        
        blockOperation2.addDependency(blockOperation1)
        blockOperation3.addDependency(blockOperation2)
        blockOperation4.addDependency(blockOperation3)
        
        //   operationQueue.waitUntilAllOperationsAreFinished()
        
        operationQueue.maxConcurrentOperationCount = 2
        
        operationQueue.addOperations([blockOperation1,blockOperation2, blockOperation3, blockOperation4], waitUntilFinished: false)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, closure: @escaping (Data) -> ()) {
        
        getData(from: url) { data, response, error in
            if error != nil { return }
            closure(data!)
        }
    }
}
 

//
//    let blockOperation = BlockOperation()
//
//    blockOperation.addExecutionBlock {
//        print("Hello")
//    }
//
//    let blockOperation2 = BlockOperation()
//
//    blockOperation2.addExecutionBlock {
//        print("Hello 2")
//    }
//
//
//    let blockOperation3 = BlockOperation()
//
//    blockOperation3.addExecutionBlock {
//        print("Hello 3")
//    }
//
//    let operationQueue = OperationQueue()
//    operationQueue.addOperations([blockOperation,blockOperation2, blockOperation3], waitUntilFinished: false)
//}
