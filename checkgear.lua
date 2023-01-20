-- Initialization function for this job file.
 
local jobs = T{"BLU", "BRD", "COR", "DNC", "DRG", "GEO", "MNK", "NIN", "RDM", "RNG", "RUN", "SAM", "THF", "WAR"}
 
mysets = {}
 
for k,v in pairs(jobs) do
    include('Silvermutt-'..v .. '.lua')
    get_sets()
    mysets[v] = sets
    sets = {}
 end
 
 
function get_sets()
    for k,v in pairs(mysets) do sets[k] = v end
end