// swift
import SwiftUI

struct Screen2View: View {
    @StateObject private var viewModel = Screen2ViewModel()

    private let cellSize: CGSize = CGSize(width: 22, height: 22)

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("adaWindow")
                GeometryReader { geo in
                    let mazeSize = CGSize(
                        width: cellSize.width * CGFloat(viewModel.cols),
                        height: cellSize.height * CGFloat(viewModel.rows)
                    )
                    ZStack {
                        MazeGridView(cells: viewModel.cells, cellSize: cellSize, entry: viewModel.entry, exit: viewModel.exit)
                            .frame(width: mazeSize.width, height: mazeSize.height)
                            .onAppear { viewModel.generateMaze() }

                        Image("player")
                            .resizable()
                            .frame(width: cellSize.width, height: cellSize.height)
                            .position(x: viewModel.playerX, y: viewModel.playerY)
                            .onAppear {
                                viewModel.placePlayerOutside(mazeSize: mazeSize, cellSize: cellSize)
                            }
                    }
                    .frame(width: mazeSize.width, height: mazeSize.height)
                    .position(x: geo.size.width / 2, y: mazeSize.height / 2)
                }
                .frame(height: cellSize.height * CGFloat(viewModel.rows))

                HStack(spacing: 16) {
                    Button { viewModel.moveLeft(playerSize: cellSize, cellSize: cellSize) } label: { Image("left") }
                    Button { viewModel.moveUp(playerSize: cellSize, cellSize: cellSize) } label: { Image("up") }
                    Button { viewModel.moveDown(playerSize: cellSize, cellSize: cellSize) } label: { Image("down") }
                    Button { viewModel.moveRight(playerSize: cellSize, cellSize: cellSize) } label: { Image("right") }
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

private struct MazeGridView: View {
    let cells: [[Bool]]
    let cellSize: CGSize
    let entry: (row: Int, col: Int)
    let exit: (row: Int, col: Int)

    var body: some View {
        VStack(spacing: 0) {
            ForEach(cells.indices, id: \.self) { r in
                HStack(spacing: 0) {
                    ForEach(cells[r].indices, id: \.self) { c in
                        ZStack {
                            Rectangle()
                                .fill(cells[r][c] ? Color.white : Color.gray.opacity(0.7))
                            if r == entry.row && c == entry.col {
                                Rectangle().stroke(Color.green, lineWidth: 2)
                            }
                            if r == exit.row && c == exit.col {
                                Rectangle().stroke(Color.red, lineWidth: 2)
                            }
                        }
                        .frame(width: cellSize.width, height: cellSize.height)
                        .overlay(
                            Rectangle()
                                .stroke(Color.gray.opacity(0.35), lineWidth: 0.6)
                        )
                    }
                }
            }
        }
    }
}

#Preview("Portrait") { Screen2View() }
