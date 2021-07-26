BEGIN { pattern = ARGV[1] + 0; delete ARGV }
pattern == 1	{ sub(/[][:space:]]/,""); print }
pattern == 2	{ sub(/[\][:space:]]/,""); print }
pattern == 3	{ sub(/[^][:space:]]/,""); print }
