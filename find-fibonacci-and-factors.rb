# Find the next prime number in the Fibonacci Sequence larger than a given number.
# The number to use is provided on the command line.
# Once the desired value is found, determine the unique prime factors of that value + 1.
# The final answer is the sum of those unique prime factors.

# Check the command to ensure we have a parameter
if ARGV.length < 1
	print "Missing parameter"
	exit
end

# Pull in the command line argument and convert to an integer.
# For non-numeric input, this will set limit to zero.
limit=ARGV[0].to_i

# Define a function to determine if a number is prime.
# This is efficient enough for small numbers, but for larger values,
# a different algorithm should be used for efficiency.
def isPrime (number)
	# By definition, zero and one are not prime.
	if number == 0 or number == 1
		return false
	end

	# Preset the starting and ending values
	i=2
	limit = number / i
	# Repeat until the numbers meet in the middle
	while i <= limit
		# Check to see if the number divides evenly.
		if number % i == 0
			# If so, the number is NOT prime.
			return false
		end
		# Adjust for the next loop
		i+=1
		limit = number / i
	end
	# If we made it here, then the number IS prime.
	return true
end

# Recursive routine to return a given member of the Fibonacci Sequence
def fib(n)
	# The first two numbers are always zero and 1
	return n if (0..1).include? n
	# Recursively call this routine to find the previous two Fibonacci numbers.
	# Return the sum of those to values.
	fib(n-1) + fib(n-2) if n > 1
end

# Routine to determine the prime factors of a number
# Returns a hash of the prime factors, where:
#   - the key is the prime number
#   - and the corresponding value is the number of times that factor is present.
# Also prints out the array as prime factors are found.
def getPrimeFactors (n)
	# Create the empty hash
	factors = {}
	# Start with 2 as the first factor
	d = 2
	# Our opening delimeter represents the array which we are about to list.
	delim = "[ "
	# Repeat until the number is reduced to 1
	while (n > 1) do
		# Does the number divide evenly?
		while (n%d == 0) do
			# Yes, we found a factor, print it out and adjust the delimiter.
			print delim + d.to_s
			delim = ", "
			# Have we already seen this prime factor in the hash?
			if (factors.keys).include? d
				# Yes, increment the value
				factors[d] += 1
			else
				# No, initialize the value.
				factors[d] = 1
			end
			# Earlier we determined the number will divide evenly.
			# Now perform the division for the next iteration.
			n /= d
		end
		# Number is no longer divisible by the current factor.
		# Increment the factor to the next prime number.
		begin
			d += 1
		end until (isPrime(d) == true)
	end
	# When we have completed our search, close out the visual output of our array.
	print " ]\n"
	# Return the hash of the factors.
	factors
end

# The main line code
# Start with the first (zero-based) Fibonacci number
j = 0
# Loop through, printing the Fibonacci numbers until the result is 
# greater than the input, AND is prime.
begin
	fibnbr = fib(j)
	print "#{fibnbr}, "
	j+=1
end until fibnbr >= limit and isPrime(fibnbr)

print "\nLevel 2 part A answer is: #{fibnbr}\n"

print "For part B, the number being factored is: #{fibnbr+1}\n"

factors = getPrimeFactors(fibnbr.to_i+1)

print "The unique prime factors are: #{factors.keys}\n"

# Spin through the list of the keys from the hash, summing them into the accumulator
levelbpw = 0
(factors.keys).each { |n| levelbpw += n }

print "The level 2 password is: #{levelbpw}\n"
