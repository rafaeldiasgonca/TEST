// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen2ViewModel.swift
// ViewModel para o Minigame 2

import Foundation
import Combine
import CoreGraphics

final class Screen2ViewModel: ObservableObject {
    @Published var message: String = "Aguardando"

    @Published var playerX: CGFloat = 0
    @Published var playerY: CGFloat = 0

    @Published var mazeWidth: CGFloat = 0
    @Published var mazeHeight: CGFloat = 0

    @Published var stepUp: CGFloat = 22
    @Published var stepDown: CGFloat = 22
    @Published var stepLeft: CGFloat = 22
    @Published var stepRight: CGFloat = 22

    let rows: Int = 10
    let cols: Int = 10
    @Published var cells: [[Bool]] = []
    @Published var entry: (row: Int, col: Int) = (0, 0)
    @Published var exit: (row: Int, col: Int) = (9, 9)
    @Published var hasReachedExit: Bool = false

    func begin() { message = "Em jogo" }
    func reset() { 
        message = "Aguardando"
        hasReachedExit = false
    }

    func generateMaze() {
        var grid = Array(repeating: Array(repeating: false, count: cols), count: rows)
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        func neighbors(_ r: Int, _ c: Int) -> [(Int, Int, Int, Int)] {
            var result: [(Int, Int, Int, Int)] = []
            let dirs = [( -2, 0), ( 2, 0), ( 0,-2), ( 0, 2)]
            for (dr, dc) in dirs {
                let nr = r + dr, nc = c + dc
                if nr >= 1, nr < rows - 1, nc >= 1, nc < cols - 1, !visited[nr][nc] {
                    let wr = r + dr/2, wc = c + dc/2
                    result.append((nr, nc, wr, wc))
                }
            }
            result.shuffle()
            return result
        }
        let startR = 1
        let startC = 1
        var stack: [(Int, Int)] = [(startR, startC)]
        visited[startR][startC] = true
        grid[startR][startC] = true
        while let (cr, cc) = stack.last {
            let nbrs = neighbors(cr, cc)
            if let next = nbrs.first {
                let (nr, nc, wr, wc) = next
                visited[nr][nc] = true
                grid[wr][wc] = true
                grid[nr][nc] = true
                stack.append((nr, nc))
            } else {
                _ = stack.popLast()
            }
        }
        // Entrada no topo
        entry = (0, 1)
        grid[entry.row][entry.col] = true
        grid[entry.row + 1][entry.col] = true

        // BFS para encontrar célula alcançável mais distante para a saída
        var dist = Array(repeating: Array(repeating: -1, count: cols), count: rows)
        var queue: [(Int, Int)] = [(1, 1)]
        dist[1][1] = 0
        let stepDirs = [(-1,0),(1,0),(0,-1),(0,1)]
        var farthestCell: (Int, Int) = (1, 1)
        var maxDist = 0
        
        while !queue.isEmpty {
            let (r, c) = queue.removeFirst()
            for (dr, dc) in stepDirs {
                let nr = r + dr, nc = c + dc
                if nr >= 0, nr < rows, nc >= 0, nc < cols, grid[nr][nc], dist[nr][nc] == -1 {
                    dist[nr][nc] = dist[r][c] + 1
                    queue.append((nr, nc))
                    if dist[nr][nc] > maxDist {
                        maxDist = dist[nr][nc]
                        farthestCell = (nr, nc)
                    }
                }
            }
        }
        
        // Define a saída como a célula mais distante alcançável
        exit = farthestCell
        grid[exit.row][exit.col] = true
        
        // Se a saída estiver na borda, garantir que está aberta
        if exit.row == 0 && exit.row + 1 < rows {
            grid[exit.row + 1][exit.col] = true
        } else if exit.row == rows - 1 && exit.row - 1 >= 0 {
            grid[exit.row - 1][exit.col] = true
        }
        if exit.col == 0 && exit.col + 1 < cols {
            grid[exit.row][exit.col + 1] = true
        } else if exit.col == cols - 1 && exit.col - 1 >= 0 {
            grid[exit.row][exit.col - 1] = true
        }
        
        cells = grid
        hasReachedExit = false
    }

    func playerCell(cellSize: CGSize) -> (row: Int, col: Int) {
        let col = Int(floor(playerX / cellSize.width))
        let row = Int(floor(playerY / cellSize.height))
        return (max(0, min(rows - 1, row)), max(0, min(cols - 1, col)))
    }

    private func tryMove(to targetRow: Int, targetCol: Int, cellSize: CGSize, playerSize: CGSize) {
        guard targetRow >= 0, targetRow < rows, targetCol >= 0, targetCol < cols else { return }
        guard cells[targetRow][targetCol] else { return }
        playerX = CGFloat(targetCol) * cellSize.width + playerSize.width / 2
        playerY = CGFloat(targetRow) * cellSize.height + playerSize.height / 2
        // Check if player reached exit
        if targetRow == exit.row && targetCol == exit.col {
            hasReachedExit = true
        }
    }

    func placePlayerOutside(mazeSize: CGSize, cellSize: CGSize) {
        mazeWidth = mazeSize.width
        mazeHeight = mazeSize.height
        playerX = CGFloat(entry.col) * cellSize.width + cellSize.width / 2
        playerY = -cellSize.height / 2
    }

    func moveUp(playerSize: CGSize, cellSize: CGSize) {
        let (row, col) = playerCell(cellSize: cellSize)
        tryMove(to: row - 1, targetCol: col, cellSize: cellSize, playerSize: playerSize)
    }
    func moveDown(playerSize: CGSize, cellSize: CGSize) {
        let (row, col) = playerCell(cellSize: cellSize)
        tryMove(to: row + 1, targetCol: col, cellSize: cellSize, playerSize: playerSize)
    }
    func moveLeft(playerSize: CGSize, cellSize: CGSize) {
        let (row, col) = playerCell(cellSize: cellSize)
        tryMove(to: row, targetCol: col - 1, cellSize: cellSize, playerSize: playerSize)
    }
    func moveRight(playerSize: CGSize, cellSize: CGSize) {
        let (row, col) = playerCell(cellSize: cellSize)
        tryMove(to: row, targetCol: col + 1, cellSize: cellSize, playerSize: playerSize)
    }
}
