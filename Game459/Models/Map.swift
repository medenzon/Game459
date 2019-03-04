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
    
    ///
    /// Updates the matrix element at the location's row and column to
    /// the new Int8 value.
    ///
    /// - Parameters:
    ///   - location: A row and column in the map.
    ///   - value: The value to be set at the given location.
    ///
    func set(_ location: Location, to value: Int8) {
        _matrix[location.row][location.col] = value
    }
    
    ///
    /// Gets the map's matrix value at the given row and column.
    ///
    /// - Parameters:
    ///   - location: A row and column in the map.
    /// - Returns:
    ///   - The map's value at the given row and column.
    ///
    func value(at location: Location) -> Int8 {
        return matrix[location.row][location.col]
    }
}
