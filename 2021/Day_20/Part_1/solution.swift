import Foundation

struct Point: Hashable {
    let row: Int
    let cell: Int
}

class Solution {

    private var input: [String] = []
    private var algorithm: [Character] = []
    private var image: [[Character]] = []

    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.components(separatedBy: "\n\n")

            for line in input[0].components(separatedBy: "\n") {
                algorithm.append(contentsOf: line)
            }

            let lines = input[1].components(separatedBy: "\n")
            let rows = lines.count
            let cells = lines[0].count
            
            image = Array(repeating: Array(repeating: ".", count: cells + 2), count: rows + 2)
            for (row, line) in lines.enumerated() {
                for (cell, char) in line.enumerated() {
                    image[row + 1][cell + 1] = char 
                }
            }

        } catch {
            print(error)
        }
    }

    func solve() -> Int {  
        var newEdgeValue: Character = "."
        var edgeValue: Character = "." 
        for _ in 0..<50 {
            if algorithm[0] == "#" {
                newEdgeValue = edgeValue == "#" ? "." : "#"
            }

            print("newEdgeValue",  newEdgeValue)

            let rows = image.count
            let cells = image[0].count
            
            var outputImage: [[Character]] = Array(repeating: Array(repeating: newEdgeValue, count: cells + 2), count: rows + 2)

            for row in 0..<rows {
                for cell in 0..<cells {
                    var sequence: [Character] = []
                    for point in neighborsOfPoint(.init(row: row, cell: cell)) {
                        if point.row < 0 || point.row >= rows || point.cell < 0 || point.cell >= cells {
                            sequence.append(newEdgeValue)
                        } else {
                            sequence.append(image[point.row][point.cell])
                        }
                    }

                    let index =  charsToInt(sequence)
                    let char = algorithm[index]
                    outputImage[row + 1][cell + 1] = char
                }
            }
            
            image = outputImage
            outputImage = []

            edgeValue = newEdgeValue
        }

        return image.flatMap { $0 }.filter { $0 == "#" }.count
    }

    func neighborsOfPoint(_ point: Point) -> [Point] {
        var result: [Point] = []
        for row in -1...1 {
            for cell in -1...1 {
                result.append(Point(row: point.row + row, cell: point.cell + cell))
            }
        }
        return result
    }

    func charsToInt(_ sequence: [Character]) -> Int {
        var res = 0
        for (index, char) in sequence.reversed().enumerated() {
            if char == "#" {
                res |= 1 << index
            }
        }
        return res
    }
}

let solution = Solution()
print(solution.solve())
