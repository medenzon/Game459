//
//  Map.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

class Map {
    
    private var _matrix: [[Int8]]!
    private var _rows: Int!
    private var _cols: Int!
    
    var matrix: [[Int8]] {
        get {
            return self._matrix
        }
    }
    
    var rows: Int {
        get {
            return _rows
        }
    }
    
    var cols: Int {
        get {
            return _cols
        }
    }
    
    init() {
        self._matrix = []
        self._rows = 0
        self._cols = 0
    }
    
    init(rows: Int, cols: Int) {
        self._matrix = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        self._rows = rows
        self._cols = cols
    }
    
    init(matrix: [[Int8]]) {
        self._matrix = matrix
        self._rows = matrix.count
        self._cols = matrix[0].count
    }
    
    func set(_ location: Location, to value: Int8) {
        _matrix[location.row][location.col] = value
    }
    
    func value(at location: Location) -> Int8 {
        return matrix[location.row][location.col]
    }
}

