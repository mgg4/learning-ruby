# Given an array of numbers, find the number of occurances where one or more numbers
# in the array, total up to another number in the array.

# My solution uses a binary mask to select values from the array to be summed.

# Define a routine to generate the masking array.  This is used to determine 
# which values to use.
def setMask(n,mp)
	# n = the number to be converted to binary
	# mp = the maximum number of digits required
	x = n
	mask = Array(mp)
	mp.downto(0) do |p|
		# Is the current value is greater than the current power of 2?
		if x >= 2**p
			# Yes, this value is a "1" digit.
			mask[p] = 1
			# ...and reduce the value by the current power of 2.
			x -= 2**p
		else
			# Not greater, so this is a "0" digit.
			mask[p] = 0	
		end
	end
	# When done, return the masking array.
	return mask
end

# The array to search
num = Array[3,4,9,14,15,19,28,37,47,50,54,56,59,61,70,73,78,81,92,95,97,99]
# Start with a sorted array.  Even though the input appears to be sorted,
# sort it to make sure.
num.sort!
# Initialize some values
numlength = num.length
print "The array has #{num.length} members\n"
maxPower = num.length - 1
print "Max power of two is #{maxPower}\n"
matches = 0

# This algorithm starts with the last element and takes it down to the 3rd element in 
# the array (zero based).  No need to go any lower, as there would not be sufficient 
# elements to the left of the value to sum together.
numlength.downto(2) do |i|
	print "i is '#{i}'\n"
	# The initial value for the mask will be based on the current loop counter.
	# If we treat the current search number as a power of 2, then (2**i)-1 will
	# create a mask value containing all of the values to the left of the value we
	# are searching for in the array.
	nbr = (2**i)-1
	print "nbr is '#{nbr}'\n"
	# No need to take this test below 3, as 2 and 1 will only produce single digits.
	# TODO: Additional efficiency would be found if we determine if the number itself
	# is a power of two.  This case also produces single digits.  However the savings
	# may be minor.
	nbr.downto(3) do |n|
		# Clear the accumulator
		s = 0
		# Generate the mask
		bMask = setMask(n,i-1)
		# For each value in the mask and the number array...
		(i-1).downto(0) do |x|
			# ...accumulate the sum of all values with a matching "1" in the masking array.
			s += (num[x] * bMask[x])
		end
		# Check for a match.
		if num[i] == s
			print "MATCH!! #{bMask.inspect}\n"
			matches += 1
		end
		
	end
end



print "Found #{matches} matches\n"