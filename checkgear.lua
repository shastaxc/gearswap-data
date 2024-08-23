-- Initialization function for this job file.

local jobs = T{'BLU', 'BST', 'COR', 'DNC', 'DRG', 'DRK', 'GEO', 'MNK', 'NIN', 'PLD', 'PUP', 'RNG', 'RUN', 'SAM', 'THF', 'WAR'}
-- local jobs = T{'BLM', 'BLU', 'COR', 'GEO', 'RDM', 'SCH', 'SMN', 'THF', 'WHM'}

mysets = {}

for k,v in pairs(jobs) do
  include('Silvermutt-'..v .. '.lua')
  -- include('Kinkima-'..v .. '.lua')
  get_sets()
  mysets[v] = sets
  sets = {}
end


function get_sets()
  for k,v in pairs(mysets) do sets[k] = v end
end
