user = {'name' => 'Austin', 'age' => 28}
user2 = {'name' => 'Austin', 'age' => 28}

puts "User 1 key object IDs:"
p user.keys.map(&:object_id)

puts "User 2 key object IDs:"
p user2.keys.map(&:object_id)
