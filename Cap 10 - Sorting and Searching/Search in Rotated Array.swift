class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int? {
        var start = 0
        var end = nums.count - 1

        while start <= end {
            let mid = start + (end - start)/2

            if nums[mid] == target {
                return mid
            }

            if nums[mid] >= nums[start] {
                if target >= nums[start] && target < nums[mid] {
                    end = mid - 1
                } else {
                    start = mid + 1
                }
            } else {
                if target > nums[mid] && target <= nums[end] {
                    start = mid + 1
                } else {
                    end = mid - 1
                }
            }
        }

        return nil
    }
}

let sol = Solution()

print(sol.search([4,5,6,7,0,1,2], 3))
