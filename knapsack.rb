

#overload sort to sort list of items
class Item
	def initialize(val,weight)
		@value=val
		@weight=weight
	end
end

#cost synonymous with weight
def highestValue(arr, maxWeight)
	#sort by the second value
	#x.sort_by{|k|k[1]}
	orderedList = arr.sort_by{|i|i[2]}.reverse
	
	sackWeight = 0
	itemsInSack = ''
	lowerBound = 0 #also the sack cost/weight
	orderedList.each do |i|
		lowerBound += i[1].to_f
		if lowerBound <= maxWeight
			itemsInSack += i[0]  +  ' '
			sackWeight = lowerBound
		else
			break
		end
	end

	puts "\nhightest value first \n Sack Total Weight: #{sackWeight} Items In sack: #{itemsInSack}"
end

def lowestCost(arr, maxWeight)
	orderedList = arr.sort_by{|i|i[1]}

	sackWeight = 0
	itemsInSack = ''
	lowerBound = 0 #also the sack weight
	orderedList.each do |i|
		lowerBound += i[1].to_f
		if lowerBound <= maxWeight
			itemsInSack += i[0]  +  ' '
			sackWeight = lowerBound
		else
			break
		end
	end

	puts "\nlowest cost first \n Sack Total Weight: #{sackWeight} Items In sack: #{itemsInSack}"
end

def highestRatio(arr, maxWeight)
	#create ratios
	arr.each do |item|
		item << item[2].to_f/item[1].to_f
	end
	
	sackWeight = 0
	itemsInSack = ''
	lowerBound = 0 #also the sack weight

	orderedList = arr.sort_by{|i|i[3]}.reverse

	orderedList.each do |i|
		lowerBound += i[1].to_f
		if lowerBound <= maxWeight
			itemsInSack += i[0]  +  ' '
			sackWeight = lowerBound
		else
			break
		end
	end

	puts "\nhighest ratio first \n Sack Total Weight: #{sackWeight} Items In sack: #{itemsInSack}"
end

def partialKnapsack(arr, maxWeight)
	#create ratios
	arr.each do |item|
		item << item[2].to_f/item[1].to_f
	end

	sackValue = 0
	itemsInSack = ''
	lowerBound = 0 #also the sack weight

	orderedList = arr.sort_by{|i|i[3]}.reverse
	orderedList.each do |i|
		lowerBound += i[1].to_f
		if lowerBound <= maxWeight
			itemsInSack += i[0]  +  ' '
			sackValue += i[2].to_f
			sackWeight = lowerBound
		else
			#amount of weight we can fit in the sack
			#take out last item we put in sack and see how much space is left
			weightLeft = maxWeight.to_f - (lowerBound.to_f - i[1].to_f)

			#fractional part of last item we want to take
			fractionWeight = weightLeft/i[1].to_f

			puts "\nPartial Knapsack items in sack #{itemsInSack} sackWeight #{sackWeight} \n fraction taken from item #{i[0]} is original cost: #{i[1]} value: #{i[2]} => fractional amount left over cost #{i[1].to_f - weightLeft} and value: #{i[2].to_f * fractionWeight} left over from item #{i[0]}"

			break

			
		end
	end

end

def main
	#format input
	input = []
	File.foreach(ARGV[0], 'r') do |f|
		input = f.gsub(/\n/," ")
		input = input.gsub(/\r/," ")
		input = input.gsub(','," ")
		input = input.split
	end
	
	maxWeight = input[0].to_i
	#toss the max weight from input
	input = input.drop(1).each_slice(3).to_a
	#	p input

	highestValue(input, maxWeight)
	lowestCost(input, maxWeight)
	highestRatio(input,maxWeight)
	partialKnapsack(input, maxWeight)
end

main()
