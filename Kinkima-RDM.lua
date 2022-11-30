-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup,
end

-- Executes on first load and main job change
function job_setup()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1] == 'test' then
    test()
  end
end

function test()
end