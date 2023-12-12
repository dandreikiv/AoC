import Foundation
import RegexBuilder

class Solver {

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
        for line in input {
            print(line)
        }
    }

    func solve() -> Int {
        let seeds = input[0]
            .components(separatedBy: ":")[1]
            .components(separatedBy: " ")
            .compactMap { Int($0) }
        
        var maps: [String: [[Int]]] = [:]

        var i = 1
        while i < input.count {
            if input[i].contains("map:") { 
                let key = input[i]
                maps[key] = []
                i = i + 1
                while i < input.count && !input[i].isEmpty {
                    let numbers = input[i].components(separatedBy: " ").compactMap { Int($0) }
                    maps[key, default: []] += Array(arrayLiteral: numbers)
                    i = i + 1
                }
            }
            i = i + 1
        } 

        let locations = seeds.map { 
            locationForSeed($0, maps: maps)
        }

        return locations.min()!
    }

    func locationForSeed(_ seed: Int, maps: [String: [[Int]]]) -> Int {
        let seedToSoil = maps["seed-to-soil map:", default: []]
        let soilToFertilizer = maps["soil-to-fertilizer map:", default: []]
        let fertilizerToWater = maps["fertilizer-to-water map:", default: []]
        let waterToLight = maps["water-to-light map:", default: []]
        let lightToTemperature = maps["light-to-temperature map:", default: []]
        let temperatureToHumidity = maps["temperature-to-humidity map:", default: []]
        let humidityToLocation = maps["humidity-to-location map:", default: []]

        let soil = convert(seed, using: seedToSoil)
        let fertilizer = convert(soil, using: soilToFertilizer)
        let water = convert(fertilizer, using: fertilizerToWater)
        let light = convert(water, using: waterToLight)
        let temperature = convert(light, using: lightToTemperature)
        let humidity = convert(temperature, using: temperatureToHumidity)
        let location = convert(humidity, using: humidityToLocation)

        return location
    }

    func convert(_ input: Int, using ranges: [[Int]]) -> Int {
        for range in ranges {
            let dest = range[0]
            let source = range[1]
            let length = range[2]

            if input >= source && input <= source + length {
                return dest + input - source
            }
        }
        return input
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())