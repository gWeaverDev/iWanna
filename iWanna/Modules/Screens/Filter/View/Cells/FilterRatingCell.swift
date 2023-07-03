//
//  FilterRatingCell.swift
//  iWanna
//
//  Created by George Weaver on 01.07.2023.
//

import UIKit
import DoubleSlider

final class FilterRatingCell: UITableViewCell {
    
    struct Model {
        
    }
    
    var sliderValueChanged: ((String) -> Void)?
    
    private var sliderSteps: [String] = []
    
    private var viewModel: FilterRatingCellVM?
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.filtersTitleRating()
        label.font = R.font.robotoMedium(size: 18)
        label.textColor = R.color.background_light()
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let sliderRating = DoubleSlider()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAppearance()
        makeSliderSteps()
        setupSlider()
        addTargets()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(from model: Model) {}
    
    private func addTargets() {
        sliderRating.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutorezing(ratingLabel, sliderRating)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            ratingLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -30),
            
            sliderRating.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 25),
            sliderRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            sliderRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -37),
            sliderRating.heightAnchor.constraint(equalToConstant: 38),
            sliderRating.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func makeSliderSteps() {
        for num in stride(from: 0.0, to: 10.0, by: 0.5) {
            sliderSteps.append("\(num)")
        }
        sliderSteps.append("\(10.0)")
    }
    
    private func setupSlider() {
        sliderRating.trackTintColor = R.color.background_light()!
        sliderRating.trackHighlightTintColor = R.color.background_yellow()!
        sliderRating.labelDelegate = self
        sliderRating.numberOfSteps = sliderSteps.count
        sliderRating.smoothStepping = true
        
        let labelOffset: CGFloat = 8.0
        sliderRating.lowerLabelMarginOffset = labelOffset
        sliderRating.upperLabelMarginOffset = labelOffset
        
        sliderRating.lowerValueStepIndex = 0
        sliderRating.upperValueStepIndex = sliderSteps.count - 1
    }
    
    @objc
    private func sliderChanged(_ doubleSlider: DoubleSlider) {
        let lowerValue = (doubleSlider.lowerValue * 10.0).rounded(toPlaces: 1)
        let upperValue = (doubleSlider.upperValue * 10.0).rounded(toPlaces: 1)
        let ratingRange = "\(lowerValue)-\(upperValue)"
        sliderValueChanged?(ratingRange)
    }
}

extension FilterRatingCell: DoubleSliderLabelDelegate, DoubleSliderEditingDidEndDelegate {
    
    func editingDidEnd(for doubleSlider: DoubleSlider) {
        print("Lower Step Index: \(doubleSlider.lowerValueStepIndex) Upper Step Index: \(doubleSlider.upperValueStepIndex)")
    }
    
    func labelForStep(at index: Int) -> String? {
        return sliderSteps[index]
    }
}
