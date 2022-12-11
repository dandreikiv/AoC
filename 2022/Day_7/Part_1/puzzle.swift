import Foundation

class Puzzle {

    struct File {
        let name: String
        let size: Int
    }

    struct Folder {
        let name: String
        let files: [File]
        let folders: [Folder]

        func totalSize() -> Int {
            let filesTotalSize = files.reduce(0) { $0 + $1.size }
            let subfuldersTotalSize = folders.reduce(0) { $0 + $1.totalSize() }
            return filesTotalSize + subfuldersTotalSize
        }
    }

    private var input: [String] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            input = try String(contentsOf: url).components(separatedBy: "\n")
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        var path: [String] = []
        var files: [String: [Int]] = [:] // [path: [fileSize]]
        var folders: [String: [String]] = [:] // [path: [fileSize]]
        for command in input {
            let components = command.components(separatedBy: " ")

            if components[0] == "$" { // terminal command
                if components[1] == "cd" { // change dir
                    let folderName = components[2] 
                    if folderName == ".." { // level up
                        path.removeLast()
                    } else { // level down to new folder
                        path.append(folderName)
                    }
                }
            } else { // terminal output, folder or file
                let key = path.joined(separator: ">")
                if components[0] == "dir" { // found folder
                    let subfolder = (path + [components[1]]).joined(separator: ">")
                    folders[key, default: []] += [subfolder]
                } else { // found file
                    let fileSize = Int(components[0].components(separatedBy: " ")[0]) ?? 0
                    let key = path.joined(separator: ">")
                    files[key, default: []] += [fileSize]
                }
            }
        }
        var sizes: [String: Int] = [:]
        _ = folderSize("/", folders, files, &sizes)

        var result = 0
        for (key, value) in sizes {
            if value < 1_000_00 {
                result += value
            }
        }
        
        return result
        
    }

    func folderSize(_ root: String, _ folders: [String: [String]], _ files: [String: [Int]], _ folderSizes: inout [String: Int]) -> Int {
        var result: Int = 0
        for subfolder in folders[root, default: []] {
            result += folderSize(subfolder, folders, files, &folderSizes)
        }
        result += files[root, default: []].reduce(0, +)
        print("root: \(root), size: \(result)")
        folderSizes[root] = result
        return result
    }
 }

let puzzle = Puzzle()
puzzle.printInput()
print(puzzle.solve())

