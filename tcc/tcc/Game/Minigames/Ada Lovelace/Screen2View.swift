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

                // Visualização da sequência de comandos
                VStack(spacing: 8) {
                    Text("Sequência de Comandos:")
                        .font(.headline)
                    
                    if viewModel.commandQueue.isEmpty {
                        Text("Nenhum comando adicionado")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.vertical, 8)
                    } else {
                        let columns = [
                            GridItem(.adaptive(minimum: 35, maximum: 35), spacing: 4)
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(Array(viewModel.commandQueue.enumerated()), id: \.offset) { index, command in
                                Image(command.rawValue)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                // Botões de setas para adicionar comandos
                VStack(spacing: 12) {
                    Text("Adicionar Comandos:")
                        .font(.subheadline)
                    
                    HStack(spacing: 16) {
                        Button { 
                            viewModel.addCommand(.left)
                        } label: { 
                            Image("left")
                                .opacity(viewModel.isExecuting ? 0.5 : 1.0)
                        }
                        .disabled(viewModel.isExecuting)
                        
                        Button { 
                            viewModel.addCommand(.up)
                        } label: { 
                            Image("up")
                                .opacity(viewModel.isExecuting ? 0.5 : 1.0)
                        }
                        .disabled(viewModel.isExecuting)
                        
                        Button { 
                            viewModel.addCommand(.down)
                        } label: { 
                            Image("down")
                                .opacity(viewModel.isExecuting ? 0.5 : 1.0)
                        }
                        .disabled(viewModel.isExecuting)
                        
                        Button { 
                            viewModel.addCommand(.right)
                        } label: { 
                            Image("right")
                                .opacity(viewModel.isExecuting ? 0.5 : 1.0)
                        }
                        .disabled(viewModel.isExecuting)
                    }
                    .buttonStyle(.plain)
                }

                // Botões de controle
                HStack(spacing: 12) {
                    Button(action: {
                        viewModel.executeCommands(cellSize: cellSize)
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(viewModel.commandQueue.isEmpty || viewModel.isExecuting ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(viewModel.commandQueue.isEmpty || viewModel.isExecuting)
                    
                    Button(action: {
                        viewModel.removeLastCommand()
                    }) {
                        HStack {
                            Image(systemName: "arrow.uturn.backward")
                            Text("Remover")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(viewModel.commandQueue.isEmpty || viewModel.isExecuting ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(viewModel.commandQueue.isEmpty || viewModel.isExecuting)
                    
                    Button(action: {
                        viewModel.clearCommands()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Limpar")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(viewModel.commandQueue.isEmpty || viewModel.isExecuting ? Color.gray : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(viewModel.commandQueue.isEmpty || viewModel.isExecuting)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .alert("Parabéns!", isPresented: $viewModel.hasReachedExit) {
            Button("Novo Labirinto") {
                viewModel.hasReachedExit = false
                viewModel.generateMaze()
                let mazeSize = CGSize(
                    width: cellSize.width * CGFloat(viewModel.cols),
                    height: cellSize.height * CGFloat(viewModel.rows)
                )
                viewModel.placePlayerOutside(mazeSize: mazeSize, cellSize: cellSize)
            }
            Button("OK") {
                viewModel.hasReachedExit = false
            }
        } message: {
            Text("Você chegou à saída!")
        }
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
                                .fill(
                                    r == entry.row && c == entry.col ? Color.green :
                                    r == exit.row && c == exit.col ? Color.red :
                                    Color.white
                                )
                        }
                        .frame(width: cellSize.width, height: cellSize.height)
                        .overlay(
                            Rectangle()
                                .stroke(cells[r][c] ? Color.gray.opacity(0.2) : Color(hex: "#2C5B36"), lineWidth: cells[r][c] ? 0.5 : 3.0)
                        )
                    }
                }
            }
        }
    }
}

#Preview("Portrait") { Screen2View() }
