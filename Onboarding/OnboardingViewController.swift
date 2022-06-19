//
//  ViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 26/08/2021.
//

import UIKit
import NotificationCenter

class OnboardingViewController: UIViewController {
    private var loginObserver: NSObjectProtocol?
    let pageIdentifier = "OnboardingPageView"
    var pages: [OnboardingPageView] {
        get {
            let page1: OnboardingPageView = Bundle.main.loadNibNamed(pageIdentifier, owner: self, options: nil)?.first as! OnboardingPageView
            page1.imageView.image = UIImage(named: "Groceries")
            page1.label.text = "Welcome to Fresh Pick!       " +
                                "All your daily groceries just a few taps away!"
            page1.buttonLabel.text = "NEXT"
            
            let page2: OnboardingPageView = Bundle.main.loadNibNamed(pageIdentifier, owner: self, options: nil)?.first as! OnboardingPageView
            page2.imageView.image = UIImage(named: "Groceries")
            page2.label.text = "We offer only the freshest fruits, vegetables, dairy products and meats."
            page2.buttonLabel.text = "NEXT"
            
            let page3: OnboardingPageView = Bundle.main.loadNibNamed(pageIdentifier, owner: self, options: nil)?.first as! OnboardingPageView
            page3.imageView.image = UIImage(named: "Groceries")
            page3.label.text = "Place your order and expect us at your doorstep within a very short period."
            page3.buttonLabel.text = "LET'S GO!"
            
            return [page1, page2, page3]
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        UserDefaults.standard.set(true, forKey: "notFirstTime")
        super.viewDidLoad()
        setupScrollView(pages: pages)
        pageControl.currentPage = 0
        //if tapped next, swipe to next page
        loginObserver = NotificationCenter.default.addObserver(forName: .nextNotfication, object: nil, queue: .main, using: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.pageControl.currentPage += 1
            strongSelf.scrollView.setContentOffset(CGPoint(x: strongSelf.view.frame.width * CGFloat(strongSelf.pageControl.currentPage), y: 0), animated: true)
        })
        //if tapped done remove this view
        loginObserver = NotificationCenter.default.addObserver(forName: .doneNotfication, object: nil, queue: .main, using: { [weak self] _ in
            print("Donee")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "nav") as? UINavigationController
            let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate
            let window = sceneDelegate?.window
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            window?.reloadInputViews()
            //DONT SHOW AGAIN
        })
    }
    deinit {
        if let observer = loginObserver{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    func setupScrollView(pages: [OnboardingPageView]) {
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width * CGFloat(pages.count), height: view.height)
        for i in 0..<pages.count {
            pages[i].frame = CGRect(x: view.width * CGFloat(i), y: 0, width: view.width, height: view.height)
            scrollView.addSubview(pages[i])
        }
    }
}
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x/view.frame.width
        pageControl.currentPage = Int(pageIndex)
    }
}
