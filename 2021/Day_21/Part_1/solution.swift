import Foundation

class Solution {

    private var input: [Int] = [2, 7]

    func solve() -> Int {
        var dice = 0
        var p1 = input[0]
        var p2 = input[1]

        var p1Score = 0
        var p2Score = 0

        while p1Score < 1000 && p2Score < 1000 {
            p1 = p1 + (dice + 1) + (dice + 2) + (dice + 3)
            p1 = (p1 % 10) == 0 ? 10 : p1 % 10
            p1Score += p1

            dice += 3
            print("p1", p1, "p1Score", p1Score)
            print("dice after p1", dice)
            if p1Score >= 1000 {
                break
            }

            p2 = p2 + (dice + 1) + (dice + 2) + (dice + 3)
            p2 = (p2 % 10) == 0 ? 10 : p2 % 10
            p2Score += p2
            dice += 3
            print("p2", p2, "p2Score", p2Score)
            print("dice after p2", dice)
            if p2Score >= 1000 {
                break
            }
        }        

        print("p1Score", p1Score, "p2Score", p2Score, "dice", dice) 
        
        return min(p1Score, p2Score) * dice
    }
}

let solution = Solution()
print(solution.solve())
