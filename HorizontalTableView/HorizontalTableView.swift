//
//  HorizontalTableView.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/1/22.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class HorizontalTableViewCell: UIView {
    fileprivate var index = -1
}

protocol HorizontalTableViewDelegate: class {
    func tableView(_ tableView: HorizontalTableView, widthForItemAt index: Int) -> CGFloat
    func tableView(_ tableView: HorizontalTableView, cellForItemAt index: Int) -> HorizontalTableViewCell
    func numberOfItems(in tableView: HorizontalTableView) -> Int
}

class HorizontalTableView: UIView {
    private let _scrollView: UIScrollView
    weak var delegate: HorizontalTableViewDelegate?
    private var itemsOffset = [CGFloat]()
    private var availableCells = Set<HorizontalTableViewCell>()
    private var cellsOnScrollView = Set<HorizontalTableViewCell>()
    var cellType: HorizontalTableViewCell.Type = HorizontalTableViewCell.self
    override init(frame: CGRect) {
        _scrollView = UIScrollView()
        _scrollView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        _scrollView.delegate = self
        addSubview(_scrollView)
        
        NSLayoutConstraint.activate([
            _scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _scrollView.topAnchor.constraint(equalTo: topAnchor),
            _scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        caculateContentSize()
        updateCellInScrollView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size.width > 0 {
            reloadData()
        }
    }
    
    func dequeueCell() -> HorizontalTableViewCell {
        if !availableCells.isEmpty {
            return availableCells.removeFirst()
        }
        return cellType.init()
    }
    
    private func caculateContentSize() {
        let itemCount = delegate?.numberOfItems(in: self) ?? 0
        itemsOffset.removeAll()
        var totalWidh = CGFloat(0)
        for i in 0..<itemCount {
            let width = delegate?.tableView(self, widthForItemAt: i) ?? 0
            totalWidh += width
            itemsOffset.append(totalWidh)
        }
        _scrollView.contentSize = CGSize(width: totalWidh, height: bounds.size.height)
    }
    
    private func updateCellInScrollView() {
        var visiableItems = Set<Int>()
        let minOffset = _scrollView.contentOffset.x
        let maxOffset = _scrollView.contentOffset.x + _scrollView.bounds.size.width
        var currentOffset = minOffset
        while currentOffset <= maxOffset {
            if let index = itemIndexFor(offset: currentOffset) {
                visiableItems.insert(index)
                currentOffset = itemsOffset[index]
            } else {
                break
            }
        }
        
        for cell in cellsOnScrollView {
            if !visiableItems.contains(cell.index) {
                availableCells.insert(cell)
                cellsOnScrollView.remove(cell)
                cell.removeFromSuperview()
            }
        }
        
        for item in visiableItems {
            if !cellsOnScrollView.contains(where: { $0.index == item }) {
                let newCell = delegate?.tableView(self, cellForItemAt: item) ?? HorizontalTableViewCell()
                cellsOnScrollView.insert(newCell)
                _scrollView.addSubview(newCell)
                let width = delegate?.tableView(self, widthForItemAt: item) ?? 0
                let x = item > 0 ? itemsOffset[item - 1] : 0
                newCell.frame = CGRect(x: x, y: 0, width: width, height: _scrollView.bounds.size.height)
            }
        }
    }
    
    private func itemIndexFor(offset: CGFloat) -> Int? {
        for (index, maxWidth) in itemsOffset.enumerated() {
            if offset >= maxWidth {
                continue
            }
            return index
        }
        return nil
    }
}

extension HorizontalTableView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellInScrollView()
    }
}
