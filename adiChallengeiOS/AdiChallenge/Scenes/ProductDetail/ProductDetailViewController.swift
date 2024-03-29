//
//  ProductDetailViewController.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

protocol ProductDetailDisplayLogic: class {
    func displayProductDetail(viewModel: ProductDetail.ProductDetail.ViewModel)
    func submitReviewResponseHandler(result: ReviewModel)
}

class ProductDetailViewController: UIViewController, ProductDetailDisplayLogic {
    
    var interactor: ProductDetailBusinessLogic?
    var productId = ""
    var reviews: [ReviewModel] = [ReviewModel](){
        didSet {
            DispatchQueue.main.async {
                self.reviewsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: - Variables
    private lazy var reviewsTableView = UITableView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var imageView = UIImageView()
    private lazy var imageContainer = UIView()
    
    private lazy var reviewButtonContainer = UIView()
    private lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Review", for: .normal)
        button.addTarget(self, action: #selector(reviewButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 12, weight: .medium)
        textView.textAlignment = .center
        return textView
    }()
    
    private lazy var starRatingView: StarRatingView = {
        var starRatingView = StarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 5, color: .white, starRounding: .roundToHalfStar)
        return starRatingView
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchProductDetail(productId: productId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.reviewButton.layer.cornerRadius = 5
            self.reviewButton.layer.borderWidth = 1
            self.reviewButton.layer.borderColor = UIColor.white.cgColor
            
            self.reviewsTableView.layer.borderWidth = 1
            self.reviewsTableView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    // MARK: - Class Functions
    
    private func configureUI() {
        setTableView()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(reviewsTableView)
        self.view.addSubview(containerView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(descriptionTextView)
        
        containerView.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
        
        reviewButtonContainer.addSubview(reviewButton)
        reviewButtonContainer.addSubview(starRatingView)
        self.view.addSubview(reviewButtonContainer)
        reviewButtonContainer.backgroundColor = .black
        
        self.view.addSubview(backButton)
        
        addConstraints()
    }
    
    private func addConstraints() {
        reviewsTableView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(self.view.snp.centerY).offset(self.view.frame.height * 0.15)
            maker.bottom.equalToSuperview().inset(49)
        }
        
        containerView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(reviewsTableView.snp.top)
        }
        
        imageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        imageContainer.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.lessThanOrEqualTo(self.view.frame.height * 0.40)
        }
        
        reviewButton.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(20)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(120)
        }
        
        reviewButtonContainer.snp.makeConstraints { (maker) in
            maker.trailing.leading.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(imageContainer.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(20)
        }
        
        priceLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(nameLabel.snp.bottom)
        }
        
        descriptionTextView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(priceLabel.snp.bottom).offset(20)
            maker.bottom.equalTo(reviewsTableView.snp.top)
        }
        
        backButton.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(20)
        }
        
        starRatingView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(self.view.frame.width / 2)
        }
    }
    
    private func setTableView() {
        reviewsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.showsVerticalScrollIndicator = false
    }
    
    func fetchProductDetail(productId: String) {
        DispatchQueue.main.async {
            self.view.showLoading()
        }
        interactor?.fetchProductDetail(productId: productId)
    }
    
    func displayProductDetail(viewModel: ProductDetail.ProductDetail.ViewModel) {
        DispatchQueue.main.async {
            self.view.stopLoading()
        }
        guard let response = viewModel.displayResult.resultModel else { return }
        if let reviews = response.reviews {
            self.reviews = reviews
        }
        imageView.setImageFromUrl(url: response.imgUrl ?? "") { (image) in
            self.imageView.image = image
        }
        DispatchQueue.main.async {
            self.nameLabel.text = response.name
            self.priceLabel.text = "\(response.currency ?? "") \(response.price ?? 0)"
            self.descriptionTextView.text = response.description
        }
    }
    
    @objc private func reviewButtonAction() {
        let alert = UIAlertController(title: "", message: "Please write your review", preferredStyle: .alert)
        alert.addTextField { (_) in }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            self.submitReview(productId: self.productId, rating: Int(self.starRatingView.rating), review: textField.text ?? "")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Submit Review Functions
    func submitReview(productId: String, rating: Int, review: String) {
        DispatchQueue.main.async {
            self.view.showLoading()
        }
        let rating = Int(self.starRatingView.rating)
        interactor?.submitReview(productId: productId, rating: rating, review: review)
    }
    
    func submitReviewResponseHandler(result: ReviewModel) {
        DispatchQueue.main.async {
            self.view.stopLoading()
        }
        reviews.append(result)
    }
}

// MARK: - TableView Extension
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        cell.textLabel?.text = "(\(reviews[indexPath.row].rating ?? 5)/5) " + (reviews[indexPath.row].text ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
}
